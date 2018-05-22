# Example of using factory bot
if defined?(FactoryBot)
  Array.wrap(command_options).each do |factory_options|
    factory_method = factory_options.shift
    begin
      logger.debug "running #{factory_method}, #{factory_options}"
      FactoryBot.public_send(factory_method, *factory_options)
    rescue => e
      logger.error "#{e.class}: #{e.message}"
      logger.error e.backtrace.join("\n")
      logger.error "#{e.record.inspect}" if e.is_a?(ActiveRecord::RecordInvalid)
      raise e
    end
  end
else
  logger.warn 'add factory_bot_rails or update factory_bot.rb'
end
