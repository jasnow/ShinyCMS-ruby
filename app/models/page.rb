# Model class for CMS-controlled 'brochure' pages
class Page < ApplicationRecord
  # Class methods
  def self.top_level_pages
    Page.where( section_id: nil )
  end
end
