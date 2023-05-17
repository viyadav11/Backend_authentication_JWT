require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do  

  describe 'Post/login' do 
    
    before do
      user=User.create(username:"vikas",email: 'vikas@gamil.com',password: 'yadav')  
      post :login, params: { email: 'vikas@gamil.com',password: 'yadav'}
    
      #   def user_login(user)
      #     secret = Rails.application.secrets.json_web_token_secret
      #     exp = 7.days.from_now
      #     encoding = 'HS256'
      #     payload = {user_id: user.id }
      #     payload[:exp] = exp.to_i
      #     request.headers["Authorization"] = JWT.encode(payload, secret)
      #   end
      #   byebug
      #   tokn= user_login(user)

    end

    it 'gives output of username' do
      user=JSON.parse(response.body)
      expect(user["username"]).to eq("vikas")
    end
    it 'show success of login page' do
      expect(response.status).to eq(200)
    end
  end
end

