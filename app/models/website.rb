class Website < ApplicationRecord
  scope :desktop_asc, -> { order(desktop_score: :asc) }
  scope :desktop_desc, -> { order(desktop_score: :desc) }
  scope :mobile_asc, -> { order(mobile_score: :asc) }
  scope :mobile_desc, -> { order(mobile_score: :desc) }
end
