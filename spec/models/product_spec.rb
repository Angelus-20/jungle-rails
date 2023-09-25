require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    before(:each) do
      # this creates a category for testing
      @category = Category.new(name: "Electronics")
    end

    # Example 1: Product with all fields set should save successfully
    it "should save successfully with all fields set" do
      product = Product.new(
        name: "Example Product",
        price: 99.99,
        quantity: 10,
        category: @category
      )
      expect(product).to be_valid
    end

    # Example 2: Product name validation
    it "requires a name" do
      product = Product.new(
        price: 99.99,
        quantity: 10,
        category: @category
      )
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    # Example 3: Product price validation
    it "requires a price" do
      product = Product.new(
        name: "Example Product",
        quantity: 10,
        category: @category
      )
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    # Example 4: Product quantity validation
    it "requires a quantity" do
      product = Product.new(
        name: "Example Product",
        price: 99.99,
        category: @category
      )
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    # Example 5: Product category validation
    it "requires a category" do
      product = Product.new(
        name: "Example Product",
        price: 99.99,
        quantity: 10
      )
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
