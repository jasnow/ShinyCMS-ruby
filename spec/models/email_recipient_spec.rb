# frozen_string_literal: true

# ShinyCMS ~ https://shinycms.org
#
# Copyright 2009-2020 Denny de la Haye ~ https://denny.me
#
# ShinyCMS is free software; you can redistribute it and/or modify it under the terms of the GPL (version 2 or later)

require 'rails_helper'

# Tests for EmailRecipient model
RSpec.describe EmailRecipient, type: :model do
  it_should_behave_like ShinyToken do
    let( :tokenised ) { create :email_recipient }
  end
end