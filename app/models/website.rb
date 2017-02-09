class Website < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :desktop_asc, -> { active.order(desktop_score: :asc) }
  scope :desktop_desc, -> { active.order(desktop_score: :desc) }
  scope :mobile_asc, -> { active.order(mobile_score: :asc) }
  scope :mobile_desc, -> { active.order(mobile_score: :desc) }
end
