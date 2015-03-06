require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  context "GET /new" do
    should "get new" do
      get :create
      assert_response :success
    end
  end

  context "POST /create" do
    setup do
      @user = Fabricate(:user)
    end

    should "post /create" do
      post :create
      assert_response :success
    end

    context "user exists" do
      context "wrong password" do
        should "render the new template" do
          post :create, { email: @user.email, password: "foo" }
          assert_template :new
        end
      end

      context "correct password" do
        should "log user in and redirect to projects page" do
          post :create, { email: @user.email, password: @user.password }
          assert_not_nil assigns(:current_user)  
          assert_redirected_to projects_path
        end
      end
    end

    context "user does not exists" do
      should "render sessions#new template" do
        post :create, { email: "foobar@foo.com" }
        assert_template :new
      end
    end
  end

  context "DELETE" do
    setup do
      @user = Fabricate(:user)
    end

    should "get destroy" do
      get :destroy
      assert_response :success
    end

    should "log user out and redirect to login page" do
      assert_nil assigns(:current_user) 
      assert_redirected_to sessions_path
    end
  end
end
