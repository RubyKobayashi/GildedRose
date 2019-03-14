class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      sulfuras(item)
        backstage(item)
        aged_brie(item)
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      end

      # after SellIn
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          end
        end
      end
    end
  end

  private

  def sulfuras(item)
      item.name == "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end

    def aged_brie(item)
      if item.name == "Aged Brie" && item.quality < 50
      item.quality = item.quality + 1
    end
  end

    def backstage(item)
        if backstage_item?(item) && item.sell_in < 6 && item.quality < 50
          item.quality = item.quality + 3 #3
        elsif backstage_item?(item) && item.sell_in < 11 && item.quality < 50
          item.quality = item.quality + 2
        elsif backstage_item?(item) && item.sell_in < 0
          item.quality = 0 #2
      end
        end

        def backstage_item?(item)
          item.name == "Backstage passes to a TAFKAL80ETC concert"
        end

        def after_sell_in?(item)
          item.sell_in < 0
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
