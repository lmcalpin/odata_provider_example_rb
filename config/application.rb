require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module OdataProviderExampleRb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    class Foo
      attr_reader :foo, :bar, :baz
    
      def initialize(foo, bar, baz)
        @foo = foo
        @bar = bar
        @baz = baz
      end    
    end
    config.to_prepare do
      inmem = OData::InMemorySchema::Base.new("InMem", classes: Foo)
      OData::Edm::DataServices.schemas << inmem
      (1..20).each do |n|
        inmem.find_entity_type("Foo").entities.append(Foo.new(n, "test", "test #{n}"))
      end    
      OData::Edm::DataServices.schemas << OData::ActiveRecordSchema::Base.new
    end
  end
end

