module Muddle
  class Base
    attr_accessor :config

    def initialize(&block)
      @config = Muddle::Configuration.new &block
    end

    def configure(&block)
      @config.configure &block
    end
  end
end
