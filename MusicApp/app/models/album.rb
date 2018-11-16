# == Schema Information
#
# Table name: albums
#
#  id         :bigint(8)        not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  year       :integer          not null
#  live       :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ApplicationRecord
  validates_presence_of :title, :year
  after_initialize :default_values

  belongs_to :band
  has_many :tracks

  private

  def default_values
    self.live ||= false
  end
end
