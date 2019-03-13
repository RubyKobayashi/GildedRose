require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context "before Sell by Date" do
      it "changes the sellIn by -1" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq(-1)
    end

      it "changes the quality by -1" do
      items = [Item.new("cabbage", 2, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(1)
      end
    end


    context "when item is 'Sulfuras, Hand of Ragnaros'" do
      it "doesn't decrease the quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
      item2 = [Item.new("Sulfuras, Hand of Ragnaros", 1, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(50)
      expect(item2[0].quality).to eq(50)
    end
  end

    context "when item in 'Brie'" do
      it "increases the quality" do
        items = [Item.new("Aged Brie", 2, 40)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq(41)
      end
    end
end
end
