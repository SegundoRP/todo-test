# == Schema Information
#
# Table name: notes
#
#  id         :bigint           not null, primary key
#  body       :text
#  user_id    :bigint           not null
#  task_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
