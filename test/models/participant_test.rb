# == Schema Information
#
# Table name: participants
#
#  id         :bigint           not null, primary key
#  role       :integer
#  user_id    :bigint           not null
#  task_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
