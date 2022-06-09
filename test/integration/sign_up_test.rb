require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  test "get sign up form and create new user" do
    get '/signup'
    assert_response :success

    assert_difference('User.count', 1) do
      post users_path, params: { user: { username: 'test_user', email: 'test_user@example.com', password: 'test_user_password' } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success

    assert_match 'Articles listing page', response.body
  end

  test "get sign up form and reject invalid new user submission" do
    get '/signup'
    assert_response :success

    assert_no_difference('User.count') do
      post users_path, params: { user: { username: ' ', email: '@@', password: '' } }
    end

    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
