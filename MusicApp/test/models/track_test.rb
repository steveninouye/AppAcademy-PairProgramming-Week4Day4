# == Schema Information
#
# Table name: tracks
#
#  id          :bigint(8)        not null, primary key
#  album_id    :integer          not null
#  title       :string           not null
#  ord         :integer          not null
#  lyrics      :text             not null
#  bonus_track :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
