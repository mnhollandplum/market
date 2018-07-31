require 'pry'
class Market
    attr_reader :name,
                :vendors
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    vendors << vendor
  end

  def vendor_names
    vendor_names = []
    vendor_names = @vendors.map do |vendor|
      vendor.name
    end
    vendor_names
  end

  def vendors_that_sell(item)
    vendors_that_sell = []
    @vendors.each do |vendor|
      if vendor.inventory.include?(item)
        vendors_that_sell << vendor
      end
    end
    vendors_that_sell
  end

  def sorted_item_list
    @vendors.map do |vendor|
      vendor.inventory.map do |name, amount|
        name
      end
    end.flatten.sort.uniq
  end

  def total_inventory
    total_inventory = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |name, amount|
        total_inventory[name] += amount
      end
    end
    total_inventory
  end

  def sell(item, quantity)
    if total_inventory[item] >= quantity
      depletes_stock_after_sale(item, quantity)
      true
    else
      false
    end
  end

  def depletes_stock_after_sale(item, quantity)
    vendors_that_sell(item).each do |vendor|
        if vendor.inventory[item] >= quantity
          vendor.inventory[item] -= quantity
        else
          quantity -= vendor.inventory[item]
          vendor.inventory[item] = 0
        end
      end
  end


end
