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

class Track < ApplicationRecord
  validates_presence_of :title, :ord, :lyrics, :album_id
  after_initialize :default_values

  belongs_to :album

  private

  def default_values
    self.bonus_track ||= false
  end
end
