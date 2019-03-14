class GildedRose

  MAXIMUM_QUALITY = 50
  MINIMUM_QUALITY = 0

  def initialize(items)
    @items = items
    @maximum_quality = 50
    @minimum_quality = 0
  end

  def update_quality()
    @items.each do |item|
      update_sulfuras(item)
      update_backstage(item)
      update_aged_brie(item)
      update_normal_products(item)
      if after_sell_in?(item)
        update_normal_products(item)
      end
    end
  end
end

  private

  def update_sulfuras(item)
      sulfuras?(item)
      item.sell_in = item.sell_in - 1
    end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_aged_brie(item)
    if aged_brie?(item) && quality_under_50?(item)
    item.quality = item.quality + 1
    end
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def quality_under_50?(item)
   item.quality < @maximum_quality
  end

  def update_backstage(item)
    if backstage_item?(item)
      if after_sell_in?(item)
        item.quality = 0
      elsif sell_in_5_days_or_less(item)
        item.quality = item.quality + 3 #3
      elsif sell_in_10_days_or_less(item)
        item.quality = item.quality + 2
    end
  end
end

  def backstage_item?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def sell_in_10_days_or_less(item)
    item.sell_in < 11
  end

  def sell_in_5_days_or_less(item)
    item.sell_in < 6
  end

  def after_sell_in?(item)
    item.sell_in < 0
  end

  def update_normal_products(item)
    if !backstage_item?(item) && !aged_brie?(item) && !sulfuras?(item)
      if item.quality > @minimum_quality
        item.quality = item.quality - 1
      end
    end
  end



class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
