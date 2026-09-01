# IPAddress

[![CI](https://github.com/kuyio/ipaddress-ruby-gem/actions/workflows/ci.yml/badge.svg)](https://github.com/kuyio/ipaddress-ruby-gem/actions/workflows/ci.yml)

IPAddress is a Ruby library designed to make the use of IPv4 and IPv6
addresses simple, powerful and enjoyable. It provides a complete set of
methods to handle IP addresses for any need, from simple scripting to full
network design.

This is a maintained fork of the original [ipaddress](https://github.com/bluemonk/ipaddress)
gem by Marco Ceresa, now maintained by [kuy.io](https://kuy.io).

## Requirements

* Ruby 3.3 or later

## Installation

```bash
gem install ipaddress
```

Or add it to your Gemfile:

```ruby
gem "ipaddress"
```

## Documentation

The code is fully documented with RDoc. You can generate the
documentation with Rake:

```bash
rake rdoc
```

## Quick Start

```ruby
require "ipaddress"

ip = IPAddress("172.16.10.1/24")

ip.address   #=> "172.16.10.1"
ip.prefix    #=> 24
ip.netmask   #=> "255.255.255.0"
ip.network   #=> #<IPAddress::IPv4 172.16.10.0/24>
ip.broadcast #=> #<IPAddress::IPv4 172.16.10.255/24>
```

## Extensions (kuy.io)

This fork adds methods for common network operations:

```ruby
require "ipaddress"

a = IPAddress("10.0.0.0/24")
b = IPAddress("10.0.0.128/25")

a.overlaps?(b)           #=> true
b.subnet_of?(a)          #=> true
a.address_exclude(b)     #=> [#<IPAddress::IPv4 10.0.0.0/25>]
```

## IPv4

The class `IPAddress::IPv4` is used to handle IPv4 type addresses.

### Create a new IPv4 address

```ruby
ip = IPAddress::IPv4.new "172.16.10.1/24"
ip = IPAddress.parse "172.16.10.1/24"
ip = IPAddress "172.16.10.1/24"
```

You can specify an IPv4 address in any of two ways:

```ruby
IPAddress "172.16.10.1/24"
IPAddress "172.16.10.1/255.255.255.0"
```

If you don't explicitly specify the prefix (or the subnet mask), IPAddress
defaults to `/32`:

```ruby
host = IPAddress::IPv4.new "10.1.1.1"
puts host.to_s #=> "10.1.1.1/32"
```

You can also pass a `uint32` to obtain an `IPAddress::IPv4` object:

```ruby
ip = IPAddress 167837953
puts ip.to_s #=> "10.1.1.1/32"
```

### Handling the IPv4 address

```ruby
ip = IPAddress("172.16.10.1/24")

ip.address   #=> "172.16.10.1"
ip.prefix    #=> 24
ip.netmask   #=> "255.255.255.0"
ip.octets    #=> [172, 16, 10, 1]
ip[1]        #=> 16
ip.to_s      #=> "172.16.10.1/24"
```

### Networks, broadcasts and iterators

```ruby
ip = IPAddress "172.16.10.1/24"

ip.network.to_s   #=> "172.16.10.0/24"
ip.broadcast.to_s #=> "172.16.10.255/24"
ip.network?       #=> false

ip.each { |addr| puts addr }
ip.each_host { |host| puts host }

ip.first.to_s #=> "172.16.10.1/24"
ip.last.to_s  #=> "172.16.10.254/24"
```

### Special formats

```ruby
ip = IPAddress "172.16.10.1/24"

ip.bits   #=> "10101100000100000000101000000001"
ip.to_u32 #=> 2886732289
ip.data   #=> "\254\020\n\001"
ip.to_ipv6 #=> "ac10:0a01"
ip.to_h    #=> "ac100a01"
```

### Subnetting

```ruby
network = IPAddress "172.16.10.0/24"

network.subnet(26).map(&:to_s)
#=> ["172.16.10.0/26", "172.16.10.64/26", "172.16.10.128/26", "172.16.10.192/26"]

network.split(3).map(&:to_s)
#=> ["172.16.10.0/26", "172.16.10.64/26", "172.16.10.128/25"]
```

### Summarization

```ruby
ip1 = IPAddress("172.16.10.0/24")
ip2 = IPAddress("172.16.11.0/24")

IPAddress::IPv4::summarize(ip1, ip2).map(&:to_s)
#=> ["172.16.10.0/23"]
```

### Supernetting

```ruby
ip = IPAddress("172.16.10.0/24")

ip.supernet(23).to_s #=> "172.16.10.0/23"
ip.supernet(22).to_s #=> "172.16.8.0/22"
```

## IPv6

IPAddress handles IPv6 addresses with the `IPAddress::IPv6` class.

```ruby
ip6 = IPAddress "2001:db8::8:800:200c:417a/64"

ip6.address    #=> "2001:0db8:0000:0000:0008:0800:200c:417a"
ip6.prefix     #=> 64
ip6.compressed #=> "2001:db8::8:800:200c:417a"
ip6.groups     #=> [8193, 3512, 0, 0, 8, 2048, 8204, 16762]
ip6.to_i       #=> 42540766411282592856906245548098208122
ip6.to_hex     #=> "20010db80000000000080800200c417a"
```

### Special IPv6 addresses

```ruby
# Unspecified
ip = IPAddress::IPv6::Unspecified.new
ip.to_s #=> "::/128"

# Loopback
ip = IPAddress::IPv6::Loopback.new
ip.to_s #=> "::1/128"

# Mapped
ip6 = IPAddress "::ffff:172.16.10.1/128"
ip6.mapped?       #=> true
ip6.ipv4.address  #=> "172.16.10.1"
```

## Original Project

This gem is a fork of the [ipaddress](https://github.com/bluemonk/ipaddress) gem
originally created by Marco Ceresa and Mike Mackintosh. See
[CHANGELOG.md](CHANGELOG.md) for the full history.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT License. See [LICENSE.txt](LICENSE.txt) for details.

Copyright (c) 2009-2015 Marco Ceresa. Copyright (c) 2023-present KUY.io Inc.
