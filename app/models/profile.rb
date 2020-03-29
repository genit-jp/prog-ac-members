class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :icon_image, IconUploader
  mount_uploader :pr_sheet_image, PrSheetUploader
  default_scope -> { order(updated_at: :desc) }
end
