module IPAddress::Extensions
  #
  # Checks whether this IP Address overlaps with the given IP Address.
  #
  # Accepts an IPAddress:IPv4 or an IPAddress::IPv6 object.
  #
  #   ip = IPAddress("192.168.0.0/20")
  #
  #   addr = IPAddress("192.168.12.0/22")
  #
  #   ip.overlaps? addr
  #     #=> true
  #
  #   ip.overlaps? IPAddress("192.168.16.0/22")
  #     #=> false
  #
  def overlaps?(other)
     other.include?(self) || other.include?(broadcast) || include?(other) || include?(other.broadcast)
  end

  #
  # Checks whether this IP Address is a subnet of the given IP Address.
  #
  # Accepts an IPAddress:IPv4 or an IPAddress::IPv6 object.
  #
  #   ip = IPAddress("192.168.12.0/22")
  #
  #   addr = IPAddress("192.168.0.0/20")
  #
  #   ip.subnet_of? addr
  #     #=> true
  #
  #   ip.subnet_of? IPAddress("192.167.0.0/20")
  #     #=> false
  #
  def subnet_of?(other)
    other.include_all?(self)
  end

  #
  # Calculates the exclusion of the given IP Address network from this IP Address network.
  #
  # Accepts an IPAddress:IPv4 or IPAddress::IPv6 object.
  #
  #   ip = IPAddress("192.168.0.0/24")
  #
  #   addr = IPAddress("192.168.0.5/32")
  #
  #   ip.address_exclude addr
  #     #=> [#<IPAddress::IPv4:0x0000000114a78400 @address="192.168.0.128", @allocator=0, @octets=[192, 168, 0, 128], @prefix=25, @u32=3232235648>,
  #          #<IPAddress::IPv4:0x0000000114a78180 @address="192.168.0.64", @allocator=0, @octets=[192, 168, 0, 64], @prefix=26, @u32=3232235584>,
  #          #<IPAddress::IPv4:0x0000000114a77f00 @address="192.168.0.32", @allocator=0, @octets=[192, 168, 0, 32], @prefix=27, @u32=3232235552>,
  #          #<IPAddress::IPv4:0x0000000114a77c80 @address="192.168.0.16", @allocator=0, @octets=[192, 168, 0, 16], @prefix=28, @u32=3232235536>,
  #          #<IPAddress::IPv4:0x0000000114a77b40 @address="192.168.0.0", @allocator=0, @octets=[192, 168, 0, 0], @prefix=29, @u32=3232235520>,
  #          #<IPAddress::IPv4:0x0000000114a778c0 @address="192.168.0.8", @allocator=0, @octets=[192, 168, 0, 8], @prefix=30, @u32=3232235528>,
  #          #<IPAddress::IPv4:0x0000000114a77500 @address="192.168.0.14", @allocator=0, @octets=[192, 168, 0, 14], @prefix=31, @u32=3232235534>,
  #          #<IPAddress::IPv4:0x0000000114a77280 @address="192.168.0.13", @allocator=0, @octets=[192, 168, 0, 13], @prefix=32, @u32=3232235533>]
  #
  # Raises an Exception if the given IP Address network is not contained in this IP Address network
  #
  # rubocop:disable Metrics/PerceivedComplexity
  def address_exclude(other)
    raise TypeError, "argument must be an IPAddress" unless other.is_a?(IPAddress)
    raise Exception, "#{other.to_string} is not contained in #{to_string}" unless include?(other)
    return nil if self == other

    s1, s2 = split
    Enumerator.new do |yielder|
      while (s1 != other) && (s2 != other)
        if other.subnet_of?(s1)
          yielder.yield(s2)
          s1, s2 = s1.split
        elsif other.subnet_of?(s2)
          yielder.yield(s1)
          s1, s2 = s2.split
        else
          # if we got here, there is a bug somewhere
          raise Exception, "Error performing exclusion: s1=#{s1.to_string} s2=#{s2.to_string} other=#{other.to_string}"
        end
      end

      if s1 == other
        yielder.yield s2
      elsif s2 == other
        yielder.yield s1
      else
        # if we got here, there is a bug somewhere
        raise Exception, "Error performing exclusion: s1=#{s1.to_string} s2=#{s2.to_string} other=#{other.to_string}"
      end
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity
end