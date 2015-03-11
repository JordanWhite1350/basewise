require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  context "GET /new" do
    should "get new" do
      get :new
      assert_response :success
    end
  end

  context "POST /create" do
    setup do
      @user = Fabricate(:user)
    end

    context "user exists" do
      context "wrong password" do
        should "redirect to login page" do
          post :create, user: { email: @user.email, password: "foo" }
          assert_template :new
        end
      end

      context "correct password" do
        should "log user in" do
          post :create, user: { email: @user.email, password: @user.password }
          assert_equal @current_user, (session[@current_user]) 
        end

        should "redirect user to projects page" do
          post :create, user: { email: @user.email, password: @user.password }
          assert_not_nil assigns(:current_user)
          assert_redirected_to projects_path
        end
      end
    end

    context "user does not exists" do
      should "render sessions#new template" do
        post :create, user: { email: "foobar@foo.com" }
        assert_template :new
      end
    end
  end

  context "DELETE" do
    context "when the user is not logged in" do
      should "redirect to signin" do
        delete :destroy
        assert_redirected_to signin_path
      end
    end

    context "when the user is logged in" do
      setup do
        @user = Fabricate(:user)
        login_user(@user)
      end

      should "get destroy, log user out, redirect to signin page" do
        delete :destroy
        
        assert_nil session[:user_id]
        assert_nil @controller.current_user
        assert_redirected_to signin_path
      end
    end
  end
end
