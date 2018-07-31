require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_vendor_exists
  vendor = Vendor.new("Rocky Mountain Fresh")
  assert_instance_of Vendor, vendor
  end

  def test_vendor_starts_with_no_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal ({}), vendor.inventory
  end

  def test_vendor_can_check_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_vendor_can_stock_items
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.check_stock("Peaches")
    vendor.stock("Peaches", 30)
    vendor.check_stock("Peaches")
    vendor.check_stock("Peaches")
    vendor.stock("Peaches", 25)
    assert_equal 55, vendor.check_stock("Peaches")
    vendor.stock("Tomatoes", 12)
    assert_equal 12, vendor.check_stock("Tomatoes")
  end

  def check_inventory_is_updated
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.check_stock("Peaches")
    vendor.stock("Peaches", 30)
    vendor.check_stock("Peaches")
    vendor.check_stock("Peaches")
    vendor.stock("Peaches", 25)
    vendor.check_stock("Peaches")
    vendor.stock("Tomatoes", 12)
    vendor.check_stock("Tomatoes")

    assert_equal ({"Peaches"=>55, "Tomatoes"=>12}), vendor.inventory

  end


end
