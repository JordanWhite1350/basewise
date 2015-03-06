require 'test_helper'

class RegisterControllerTest < ActionController::TestCase
  context "GET" do
    should "should get new" do
      get :new
      assert_response :success
      assert_not_nil assigns(:user)
    end
  end

  context "CREATE" do
    context "when user params are valid" do
      setup do
        @valid_params = {
          email: "dphaener@gmail.com",
          first_name: "darin",
          last_name: "haener",
          password: "foobar$32"
        }
        post :create, { user: @valid_params }
      end

      should "create user" do
        assert_equal 1, User.count
      end

      should "log user in" do
        assert assigns(:current_user)
      end

      should "redirect user to the projects path" do
        assert_redirected_to projects_path
      end
    end

    context "when user params are invalid" do
      setup do
        @invalid_params = {
          email: "dp",
          first_name: "darin",
          last_name: "haener",
          password: "foo"
        }
        post :create, { user: @invalid_params }
      end

      should "not create user" do
        assert_equal 0, User.count
      end

      should "render the user new template" do
        assert_template :new
      end
    end
  end
end
