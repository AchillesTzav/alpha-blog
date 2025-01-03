require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  # contents in the setup method are run first before any test
  # this helps to make code less
  def setup
    @category = Category.new(name: "Sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name shoud be present" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "name shoulb be unique" do
    @category.save
    @category_2 = Category.new(name: "Sports")
    assert_not @category_2.valid?
  end

  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end
