require 'logger'

module Mizuno
    class JavaLogger < Logger
        LEVELS = {
            Logger::DEBUG => Java.org.apache.log4j.Level::DEBUG,
            Logger::INFO => Java.org.apache.log4j.Level::INFO,
            Logger::WARN => Java.org.apache.log4j.Level::WARN,
            Logger::ERROR => Java.org.apache.log4j.Level::ERROR,
            Logger::FATAL => Java.org.apache.log4j.Level::FATAL }

        def initialize
            @log4j = Java.org.apache.log4j.Logger.getLogger('ruby')
        end

        def add(severity, message = nil, progname = nil)
            content = (message or (block_given? and yield) or progname)
            @log4j.log(LEVELS[severity], content)
        end

        def puts(message)
            write(message.to_s)
        end

        def write(message)
            add(INFO, message)
        end

        def flush
            # No-op.
        end

        def close
            # No-op.
        end
    end
end
