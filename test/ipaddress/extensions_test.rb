require 'test_helper'

class ExtensionsTest < Minitest::Test

  def setup
  end

  def test_overlaps
    assert_equal true, IPAddress("192.168.0.0/20").overlaps?(IPAddress("192.168.12.0/22"))
    assert_equal false, IPAddress("192.168.0.0/20").overlaps?(IPAddress("192.168.16.0/22"))
  end

  def test_subnet_of
    assert_equal true, IPAddress("192.168.12.0/22").subnet_of?(IPAddress("192.168.0.0/20"))
    assert_equal false, IPAddress("192.168.12.0/22").subnet_of?(IPAddress("192.167.0.0/20"))
  end

  def test_address_exclude
    ip = IPAddress("192.168.0.0/24")
    addr = IPAddress("192.168.0.5/32")
    range = ip.address_exclude(addr)

    assert_equal range.to_a.map(&:to_string), [
      "192.168.0.128/25",
      "192.168.0.64/26",
      "192.168.0.32/27",
      "192.168.0.16/28",
      "192.168.0.8/29",
      "192.168.0.0/30",
      "192.168.0.6/31",
      "192.168.0.4/32",
    ]
  end
end
