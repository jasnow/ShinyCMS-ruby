# frozen_string_literal: true

# ============================================================================
# Project:   ShinyBlogs plugin for ShinyCMS (Ruby version)
# File:      plugins/ShinyBlogs/app/controllers/shiny_news/admin_controller.rb
# Purpose:   Base controller for admin area
#
# Copyright: (c) 2009-2020 Denny de la Haye https://denny.me
#
# ShinyCMS is free software; you can redistribute it and/or
# modify it under the terms of the GPL (version 2 or later).
# ============================================================================

module ShinyBlogs
  # Base controller for admin features of ShinyBlogs plugin for ShinyCMS
  # Inherits from ShinyCMS AdminController
  class AdminController < ::AdminController
    helper Rails.application.routes.url_helpers
  end
end