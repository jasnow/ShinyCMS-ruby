# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Search:', type: :request do
  before :each do
    @user = create :user, public_name: 'Success'
  end

  describe 'GET /search' do
    it 'displays the search form' do
      get shiny_search.search_path

      expect( response      ).to have_http_status :ok
      expect( response.body ).to have_title I18n.t( 'shiny_search.search.new.title' )
    end
  end

  describe 'GET /search?query=Success' do
    it 'displays the search results using the default search back-end (pg_search)' do
      get shiny_search.search_path, params: { query: 'Success' }

      expect( response      ).to     have_http_status :ok
      expect( response.body ).to     have_title I18n.t( 'shiny_search.search.results.title', query: 'Success' )
      expect( response.body ).to     have_link @user.name, href: shiny_profiles.profile_path( @user.username )
      expect( response.body ).not_to have_css 'p', text: I18n.t( 'shiny_search.search.no_results.no_results' )
    end

    it 'logs an error if no search back-ends are enabled' do
      allow_any_instance_of( ShinySearch::MainSiteHelper ).to receive( :algolia_search_is_enabled? ).and_return( false )
      allow_any_instance_of( ShinySearch::MainSiteHelper ).to receive( :pg_search_is_enabled?      ).and_return( false )

      expect( Rails.logger ).to receive( :error ).with(
        'Search feature is enabled, but no search back-ends are enabled'
      )

      get shiny_search.search_path, params: { query: 'Wot No Backend?' }

      expect( response      ).to have_http_status :ok
      expect( response.body ).to have_title I18n.t( 'shiny_search.search.results.title', query: 'Wot No Backend?' )
      expect( response.body ).to have_css 'p', text: I18n.t( 'shiny_search.search.no_results.no_results' )
    end
  end

  describe 'GET /search?engine=pg&query=Success' do
    it 'displays the search results, explicitly using the pg_search back-end' do
      get shiny_search.search_path, params: { engine: 'pg', query: 'Success' }

      expect( response      ).to     have_http_status :ok
      expect( response.body ).to     have_title I18n.t( 'shiny_search.search.results.title', query: 'Success' )
      expect( response.body ).to     have_link @user.name, href: shiny_profiles.profile_path( @user.username )
      expect( response.body ).not_to have_css 'p', text: I18n.t( 'shiny_search.search.no_results.no_results' )
    end
  end

  describe 'GET /search?engine=algolia&query=Success' do
    it 'displays the search results, using the Algolia search back-end' do
      get shiny_search.search_path, params: { engine: 'algolia', query: 'Success' }

      expect( response      ).to     have_http_status :ok
      expect( response.body ).to     have_title I18n.t( 'shiny_search.search.results.title', query: 'Success' )
      # TODO
      # expect( response.body ).to     have_link @user.name, href: shiny_profiles.profile_path( @user.username )
      # expect( response.body ).not_to have_css 'p', text: I18n.t( 'shiny_search.search.no_results.no_results' )
    end
  end

  describe 'GET /search?query=FAIL' do
    it 'displays the lack of search results' do
      get "#{shiny_search.search_path}?query=FAIL"

      expect( response      ).to     have_http_status :ok
      expect( response.body ).to     have_title I18n.t( 'shiny_search.search.results.title', query: 'FAIL' )
      expect( response.body ).to     have_css 'p', text: I18n.t( 'shiny_search.search.no_results.no_results' )
      expect( response.body ).not_to have_link @user.name, href: shiny_profiles.profile_path( @user.username )
    end
  end
end
