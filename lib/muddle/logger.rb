module Muddle::Logger
  def self.log(level, message)
    return false unless logger
    logger.send(level, message)
  end

  private

  def self.logger
    Muddle.config.logger
  end
end
