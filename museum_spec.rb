require './lib/exhibit'
require './lib/patron'
require './lib/museum'


RSpec.describe Museum do
  before(:each) do
    dmns = Museum.new("Denver Museum of Nature and Science")
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

  it "adds creates an array of exhibits" do
    @dmns.add_exhibit(gems_and_minerals)
    @dmns.add_exhibit(dead_sea_scrolls)
    @dmns.add_exhibit(imax)

    expect(@dmns.exhibits).to eq(gems_and_minerals, dead_sea_scrolls, imax)
  end

  it "can recommend exhibits to patrons" do
    expect(@dmns.recommend_exhibits(patron_1)).to eq()
    expect(@dmns.recommend_exhibits(patron_1)).to eq()
  end
end


- For `patrons_by_exhibit_interest`, this method takes no arguments and returns a Hash where each key is an Exhibit. The value associated with that Exhibit is an Array of all the Patrons that have an interest in that exhibit.
- `ticket_lottery_contestants` returns an array of patrons that do not have enough money to see an exhibit, but are interested in that exhibit. The lottery winner is generated randomly based on the available contestants when `draw_lottery_winner` is called.
- You will need to use a **stub** to test the `announce_lottery_winner` method in conjunction with the `draw_lottery_winner` method. JOY!



pry(main)> dmns = Museum.new("Denver Museum of Nature and Science")
# => #<Museum:0x00007fb20205d690...>

pry(main)> gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
# => #<Exhibit:0x00007fb202238618...>

pry(main)> dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
# => #<Exhibit:0x00007fb202248748...>

pry(main)> imax = Exhibit.new({name: "IMAX",cost: 15})
# => #<Exhibit:0x00007fb20225f8d0...>

pry(main)> dmns.add_exhibit(gems_and_minerals)

pry(main)> dmns.add_exhibit(dead_sea_scrolls)

pry(main)> dmns.add_exhibit(imax)

pry(main)> dmns.patrons
# => []

pry(main)> patron_1 = Patron.new("Bob", 0)
# => #<Patron:0x00007fb2011455b8...>

pry(main)> patron_1.add_interest("Gems and Minerals")

pry(main)>
patron_1.add_interest("Dead Sea Scrolls")

pry(main)> patron_2 = Patron.new("Sally", 20)
# => #<Patron:0x00007fb20227f8b0...>

pry(main)> patron_2.add_interest("Dead Sea Scrolls")

pry(main)> patron_3 = Patron.new("Johnny", 5)
# => #<Patron:0x6666fb20114megan...>

pry(main)> patron_3.add_interest("Dead Sea Scrolls")

pry(main)> dmns.admit(patron_1)

pry(main)> dmns.admit(patron_2)

pry(main)> dmns.admit(patron_3)

pry(main)> dmns.patrons
# => [#<Patron:0x00007fb2011455b8...>, #<Patron:0x00007fb20227f8b0...>, #<Patron:0x6666fb20114megan...>]

#Patrons are added even if they don't have enough money for all/any exhibits.

pry(main)> dmns.patrons_by_exhibit_interest
# =>
# {
#   #<Exhibit:0x00007fb202238618...> => [#<Patron:0x00007fb2011455b8...>],
#   #<Exhibit:0x00007fb202248748...> => [#<Patron:0x00007fb2011455b8...>, #<Patron:0x00007fb20227f8b0...>, #<Patron:0x6666fb20114megan...>],
#   #<Exhibit:0x00007fb20225f8d0...> => []
# }

pry(main)> dmns.ticket_lottery_contestants(dead_sea_scrolls)
# => [#<Patron:0x00007fb2011455b8...>, #<Patron:0x6666fb20114megan...>]

pry(main)> dmns.draw_lottery_winner(dead_sea_scrolls)
# => "Johnny" or "Bob" can be returned here. Fun!

pry(main)> dmns.draw_lottery_winner(gems_and_minerals)
# => nil

#If no contestants are elgible for the lottery, nil is returned.

pry(main)> dmns.announce_lottery_winner(imax)
# => "Bob has won the IMAX edhibit lottery"

# The above string should match exactly, you will need to stub the return of `draw_lottery_winner` as the above method should depend on the return value of `draw_lottery_winner`.

pry(main)> dmns.announce_lottery_winner(gems_and_minerals)
# => "No winners for this lottery"

# If there are no contestants, there are no winners.