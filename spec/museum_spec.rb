require './lib/exhibit'
require './lib/patron'
require './lib/museum'


RSpec.describe Museum do
  before(:each) do
    @dmns = Museum.new("Denver Museum of Nature and Science")

    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @imax = Exhibit.new({name: "IMAX",cost: 15})

    @patron_1 = Patron.new("Bob", 0)
    @patron_2 = Patron.new("Sally", 20)
    @patron_3 = Patron.new("Johnny", 5)
  end

  describe "#initialize" do
    it "Initializes" do
      expect(@dmns).to be_a Museum
    end

    it "returns museum name" do
      expect(@dmns.name).to eq("Denver Museum of Nature and Science")
    end


    it "creates an empty array for exhibits" do
      expect(@dmns.exhibits).to eq([])
    end
  end

  it "creates an array of exhibits" do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    expect(@dmns.exhibits).to eq([@gems_and_minerals, @dead_sea_scrolls, @imax])
  end

  xit "can recommend exhibits to patrons" do
    expect(@dmns.recommend_exhibits(@patron_1)).to eq()
    expect(@dmns.recommend_exhibits(@patron_1)).to eq()
  end

  it "creates an empty array for patrons" do
    expect(@dmns.patrons).to eq([])
  end

  it "admits patterns into an array" do 
    #Patrons are added even if they don't have enough money for all/any exhibits.
    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    expect(@dmns.patrons).to eq([@patron_1, @patron_2, @patron_3])
  end
end


