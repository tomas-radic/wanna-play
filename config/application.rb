require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WannaPlay
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
	config.i18n.default_locale = :sk
	config.max_availability_note_length = 60
    
    # demo mode used in winter, availabilities are generated 
    # for demo users, causing the webpage not to be empty 
    # while we don't play tennis.
    config.demo_mode = false
  end
end
