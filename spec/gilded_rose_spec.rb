require 'gilded_rose'

describe GildedRose do
  describe "#update_quality" do
    describe ".name" do
      it "does not change the name" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].name).to eq "foo"
      end
    end

    describe ".sell_in" do
      it "changes the sellIn by -1" do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq(-1)
      end
    end

    describe ".quality" do
      it "quality is never below 0" do
        items = [Item.new("apple", 0, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(0)
      end

      context "before SellIn Date" do
        it "changes the quality by -1" do
        items = [Item.new("cabbage", 2, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(1)
      end

      context ".name is 'Brie'" do
        it "quality increases by 1" do
          items = [Item.new("Aged Brie", 2, 40)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq(41)
        end

        it "quality is never more than 50" do
          items = [Item.new("Aged Brie", 2, 50)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq(50)
        end
      end

      context ".name is 'Backstage passes to a TAFKAL80ETC concert'" do
        context "10 days or less to SellIn date" do
          it "quality increases by 2" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 40)]
            GildedRose.new(items).update_quality()
            expect(items[0].quality).to eq(42)
          end
        end

        context "5 days or less to SellIn date" do
          it "quality increases by 3" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 40)]
            GildedRose.new(items).update_quality()
            expect(items[0].quality).to eq(43)
          end
        end
      end
      end # before sellindate

      context "after SellIn Date" do
        context ".name is 'Backstage passes to a TAFKAL80ETC concert'" do
          it "quality drops to 0" do
            items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 50)]
            GildedRose.new(items).update_quality()
            expect(items[0].quality).to eq(0)
          end
        end
      end

      context "when item is 'Sulfuras, Hand of Ragnaros'" do
        it "quality doesn't decrease" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
          item2 = [Item.new("Sulfuras, Hand of Ragnaros", 1, 50)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq(50)
          expect(item2[0].quality).to eq(50)
        end
      end
    end #quality
  end # update_quality
end #Gilded Rose
