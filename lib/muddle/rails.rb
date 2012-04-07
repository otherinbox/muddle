require File.expand_path(File.dirname(__FILE__) + '/../muddle')
require File.expand_path(File.dirname(__FILE__) + '/interceptor')

module Muddle
  class Railtie < Rails::Railtie
    initializer "muddle.configure_rails_initialization" do
      ActionMailer::Base.register_interceptor(Muddle::Interceptor)
    end
  end
end
