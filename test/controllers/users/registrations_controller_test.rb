require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  # TODO: uncomment when you reenable user :registerable
  # test "create should send mail and redirect to login" do
  #   email = Faker::Internet.email
  #   password = Faker::Internet.password
  #   sign_up_params = { email: email, username: Faker::Internet.username, password: password, password_confirmation: password }

  #   post user_registration_path(user: sign_up_params)
  #   assert_redirected_to new_user_session_path

  #   user = User.find_by(email: email)
  #   mail = ActionMailer::Base.deliveries.last

  #   assert_equal [sign_up_params[:email]], mail.to
  #   assert_equal [Devise.mailer_sender], mail.from
  #   assert_equal 'Confirmation instructions', mail.subject
  #   assert mail.decoded.include?(user_confirmation_path(confirmation_token: user.confirmation_token))
  # end

  # test "create without username should fail" do
  #   email = Faker::Internet.email
  #   password = Faker::Internet.password
  #   sign_up_params = { email: email, password: password, password_confirmation: password }

  #   assert_difference 'User.count', 0 do
  #     post user_registration_path(user: sign_up_params)
  #   end

  #   assert_not User.find_by(email: email)
  # end
end
