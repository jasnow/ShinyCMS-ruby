# frozen_string_literal: true

# ShinyPages plugin for ShinyCMS ~ https://shinycms.org
#
# Copyright 2009-2020 Denny de la Haye ~ https://denny.me
#
# ShinyCMS is free software; you can redistribute it and/or modify it under the terms of the GPL (version 2 or later)

require 'rails_helper'

# Tests for page template model
module ShinyPages
  RSpec.describe Template, type: :model do
    context 'instance methods' do
      describe '.pages' do
        it 'returns the associated pages' do
          template = create :page_template
          create :page, template: template
          create :page, template: template
          expect( template.pages.size ).to eq 2
        end
      end

      describe '.file_exists?' do
        it 'returns true if the template file exists on the disk' do
          template = create :page_template, filename: 'an_example'
          expect( template.file_exists? ).to eq true
        end

        it 'returns false if the template file does not exist' do
          template = build :page_template, filename: 'NO-SUCH-FILE'
          expect( template.file_exists? ).to eq false
        end
      end

      describe '.elements' do
        it 'returns the template elements' do
          template = create :page_template

          expect( template.elements.size ).to eq 4
        end
      end
    end

    context 'class methods' do
      describe '.available_templates' do
        it 'it returns the names of the template files in pages/templates' do
          expect( ShinyPages::Template.available_templates.size  ).to eq 2
          expect( ShinyPages::Template.available_templates.first ).to eq 'an_example'
          expect( ShinyPages::Template.available_templates.last  ).to eq 'contact_form'
        end
      end
    end

    context 'concerns' do
      it_should_behave_like ShinyDemoDataProvider do
        let( :model ) { described_class }
      end
    end
  end
end
