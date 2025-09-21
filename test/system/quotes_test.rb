require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:first)
  end

  test "Showing a quote" do
    visit quotes_path
    click_link @quote.name
  end

  test "Creating a new quote" do
    # When we visit the Quotes#index page
    # we expect to see a title with the text "Quotes"
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    # Wehn we click on the link with the text "New quote"
    # we expect to land on a page with the title "New quote"
    click_on "New quote"
    assert_selector "h1", text: "New quote"

    # When we fill in the name input with "Milkshake quote"
    # and we click on "Create quote"
    fill_in "Name", with: "Milkshake quote"
    click_on "Create quote"

    # We expect to be back on the page with the title "Quotes"
    # and to see our "Milkshake quote" added to the list
    assert_selector "h1", text: "Quotes"
    assert_text "Milkshake quote"
  end

  test "Updating a quote" do
    visit quotes_path
    assert_selector "h1", text: "Quotes"

    click_on "Edit", match: :first
    # After clicking Edit, you should be on the edit page
    assert_selector "h1", text: "Edit quote"  # This is what you'd expect
    
    fill_in "Name", with: "Updated quote"
    click_on "Update quote"

    # Only after submitting the form should you be back on the quotes page
    assert_selector "h1", text: "Quotes"
    assert_text "Updated quote"
  end


  test "Destroying a quote" do
    visit quotes_path
    assert_text @quote.name

    click_on "Delete", match: :first
    assert_no_text @quote.name
  end
end
