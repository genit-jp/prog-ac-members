require 'test_helper'

class CodeReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code_review = code_reviews(:one)
  end

  test "should get index" do
    get code_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_code_review_url
    assert_response :success
  end

  test "should create code_review" do
    assert_difference('CodeReview.count') do
      post code_reviews_url, params: { code_review: { answer_id: @code_review.answer_id, lgtm: @code_review.lgtm, user_id: @code_review.user_id } }
    end

    assert_redirected_to code_review_url(CodeReview.last)
  end

  test "should show code_review" do
    get code_review_url(@code_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_code_review_url(@code_review)
    assert_response :success
  end

  test "should update code_review" do
    patch code_review_url(@code_review), params: { code_review: { answer_id: @code_review.answer_id, lgtm: @code_review.lgtm, user_id: @code_review.user_id } }
    assert_redirected_to code_review_url(@code_review)
  end

  test "should destroy code_review" do
    assert_difference('CodeReview.count', -1) do
      delete code_review_url(@code_review)
    end

    assert_redirected_to code_reviews_url
  end
end
