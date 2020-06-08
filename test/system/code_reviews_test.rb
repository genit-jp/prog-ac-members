require "application_system_test_case"

class CodeReviewsTest < ApplicationSystemTestCase
  setup do
    @code_review = code_reviews(:one)
  end

  test "visiting the index" do
    visit code_reviews_url
    assert_selector "h1", text: "Code Reviews"
  end

  test "creating a Code review" do
    visit code_reviews_url
    click_on "New Code Review"

    fill_in "Answer", with: @code_review.answer_id
    check "Lgtm" if @code_review.lgtm
    fill_in "User", with: @code_review.user_id
    click_on "Create Code review"

    assert_text "Code review was successfully created"
    click_on "Back"
  end

  test "updating a Code review" do
    visit code_reviews_url
    click_on "Edit", match: :first

    fill_in "Answer", with: @code_review.answer_id
    check "Lgtm" if @code_review.lgtm
    fill_in "User", with: @code_review.user_id
    click_on "Update Code review"

    assert_text "Code review was successfully updated"
    click_on "Back"
  end

  test "destroying a Code review" do
    visit code_reviews_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Code review was successfully destroyed"
  end
end
