require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post '/user', params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'user/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post '/user', params: { user: { name:  "ExampleUser",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'user/show'
    assert is_logged_in?
  end
end
