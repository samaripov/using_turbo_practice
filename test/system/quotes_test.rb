require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    login_as users(:accountant)
    @quote = Quote.ordered.first
    visit quotes_path
  end

  private

  def assert_quotes_page
    assert_selector "h1", text: "Quotes"
  end

  test "Showing a quote" do
    click_link @quote.name
  end

  test "Creating a new quote" do
    click_on "New quote", match: :first
    fill_in "Name", with: "Fourth quote"
    click_on "Create quote"
    assert_text "Quote created"
  end

  test "Updating a quote" do
    assert_selector "h1", text: "Quotes"

    click_on "Edit", match: :first

    fill_in "Name", with: "Updated quote"
    click_on "Update quote"

    # Only after submitting the form should you be back on the quotes page
    assert_selector "h1", text: "Quotes"
    assert_text "Updated quote"
  end


  test "Destroying a quote" do
    click_on "Delete", match: :first
    page.driver.browser.switch_to.alert.accept
    assert_no_text @quote.name
  end
end
