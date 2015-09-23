require 'rails_helper'

RSpec.describe Cart, type: :model do
  before(:each) do
    create(:cart)
    @product1 = Product.create!( :title => "A", :price => 10)
    @product2 = Product.create!( :title => "B", :price => 20)
  end

  let(:cart) { Cart.first }

  describe "#add_line_item" do
    it "should add product to cart.line_items" do
      cart.add_line_item(@product1)
      expect( @cart.line_items.count ).to eq(1)
    end
  end
end
