# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#  code        :string
#
class Task < ApplicationRecord
  include AASM

  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user
  has_many :notes

  # validates :participating_users, presence: true
  validates :name, :description, presence: true
  validates :name, uniqueness: { case_insensitive: false }
  # validates :due_date_validity

  before_create :create_code
  # after_create :send_email

   aasm column: :state do
    # el atributo no es necesario que4 se llame state, puede ser status
    state :pending, initial: true
    state :in_process, :finished

    after_all_transitions :audit_status_change

    event :start do
      transitions from: :pending, to: :in_process
    end

    event :finish do
      transitions from: :in_process, to: :finished
    end
  end

  def audit_status_change
    # puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    set transitions: transitions.push(
      {
        from_state: aasm.from_state,
        to_state: aasm.to_state,
        current_event: aasm.current_event,
        timestamp: Time.zone.now
      }
    )
    # con el set persistimos la informacion en la bd con mongo DB
  end

  def due_date_validity
    return if due_date.blank?
    return if due_date > Date.today

    errors.add :due_date, I18n.t('task.errors.invalid_due_date')
  end

  def create_code
    self.code = "#{owner_id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_email
    return unless Rails.env.development?
    Tasks::SendEmailJob.perform_async id
    # Tasks::SendEmailJob.perform_in 5, id
  end
end
