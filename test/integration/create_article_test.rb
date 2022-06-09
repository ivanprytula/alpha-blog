require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "john_smith", email: "john_smith@example.com",
                        password: "password", admin: false )
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get '/articles/new'
    assert_response :success

    assert_difference('Article.count', 1) do
      post articles_path, params: { article: {
        title: "New test article",
        description: 'Description for new test article',
        category_ids: [] }
      }

      assert_response :redirect
    end

    follow_redirect!
    assert_response :success

    assert_match "New test article", response.body
  end

  test "get new article form and reject invalid create submission" do
    get '/articles/new'
    assert_response :success

    assert_no_difference('Article.count') do
      post articles_path, params: { article: {
        title: '',
        description: '',
        category_ids: [] }
      }
    end

    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
