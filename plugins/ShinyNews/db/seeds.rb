# frozen_string_literal: true

# ShinyNews plugin for ShinyCMS ~ https://shinycms.org
#
# Copyright 2009-2020 Denny de la Haye ~ https://denny.me
#
# ShinyCMS is free software; you can redistribute it and/or modify it under the terms of the GPL (version 2 or later)

# You can load or reload this data using the following rake task:
# rails shiny_news:db:seed

# Add feature flags

flag = FeatureFlag.create_or_find_by!( name: 'news' )
flag.update!(
  description: 'Enable news section, provided by ShinyNews plugin',
  enabled: true,
  enabled_for_logged_in: true,
  enabled_for_admins: true
)

flag = FeatureFlag.create_or_find_by!( name: 'news_votes' )
flag.update!(
  description: 'Enable votes on news posts',
  enabled: true,
  enabled_for_logged_in: true,
  enabled_for_admins: true
)

flag = FeatureFlag.create_or_find_by!( name: 'news_downvotes' )
flag.update!(
  description: 'Enable down-votes on news posts',
  enabled: true,
  enabled_for_logged_in: true,
  enabled_for_admins: true
)

# Add admin capabilities

category = CapabilityCategory.create_or_find_by!( name: 'news_posts' )
category.capabilities.create_or_find_by!( name: 'list'          )
category.capabilities.create_or_find_by!( name: 'add'           )
category.capabilities.create_or_find_by!( name: 'edit'          )
category.capabilities.create_or_find_by!( name: 'destroy'       )
category.capabilities.create_or_find_by!( name: 'change_author' )
