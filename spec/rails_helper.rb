# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

module ControllerMacros
  def sign_me_in
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = create(:user)
      sign_in :user, @current_user
    end
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  config.extend ControllerMacros, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
end
