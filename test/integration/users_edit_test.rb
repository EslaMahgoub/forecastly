require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:eslam)
  end
  
  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name: "", email: "eslam@example.com", password: "pass", password_confirmation: "word"}}
    assert_template 'users/edit'
  end

  #if user clicked on edit page when he isn't login, redirect him to the page after login
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Tony Stark"
    email = "tony@example.com"
    patch user_path(@user), params: {user: {name: name, email: email, password: "", password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to root_path
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end



end