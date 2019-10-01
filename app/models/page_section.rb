# Model for page sections
class PageSection < ApplicationRecord
  # Associations
  has_many :pages,
           -> { where( hidden: false ).order( :sort_order ) },
           foreign_key: 'section_id', inverse_of: 'section'
  has_many :hidden_pages,
           -> { where( hidden: true ).order( :sort_order ) },
           foreign_key: 'section_id', class_name: 'Page', inverse_of: 'section'

  belongs_to :section,
             class_name: 'PageSection', optional: true, inverse_of: 'sections'
  has_many   :sections,
             -> { where( hidden: false ).order( :sort_order ) },
             foreign_key: 'id', inverse_of: 'section'

  # Instance methods

  # Return the default page for this section if one is set
  # If the default isn't set, return the first page in this section
  def default_page
    pages.find( default_page_id ) || pages.first
  end

  # Class methods

  def self.top_level_sections
    PageSection.where( section: nil )
  end

  def self.default_section
    # TODO
    PageSection.first
  end
end