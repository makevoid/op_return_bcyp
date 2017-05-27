module OpReturnBcyp
  module Vendor
    module Caching

      DISABLED = false # use this `OpReturnBcyp::Vendor::Caching.remove_const :DISABLED; OpReturnBcyp::Vendor::Caching::DISABLED = true` to disable caching

      R = Redis.new

      def cache(key, &block)
        return block.call if DISABLED

        log = false
        cache_key = "cache:#{key}"
        value = R[cache_key]
        puts "cache read: #{value.inspect}" if log
        if value && value != ""
          value = Oj.load value
          return value
        end

        value = block.call
        return unless value
        puts "cache write: #{value.inspect}" if log
        R[cache_key] = Oj.dump value
        value
      end

      def expire(key)
        cache_key = "cache:#{key}"
        LR[cache_key] = nil
      end

    end
  end
end
