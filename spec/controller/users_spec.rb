require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  SECRET_KEY=Rails.application.secret_key_base
  before do
    user=User.create(username:"vikas",email: 'vikas@gmail.com',password: '123456') 
    def user_login(user)
      payload = {user_id: user.id }
      token = JWT.encode(payload,SECRET_KEY)
      request.headers["Authorization"] = token
    end
    user_login(user)
  end
 
  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post :create, params:{
                                username: 'manish',
                                email: 'manish@gmail.com',
                                password: 'vikas',
                              }  
      end
      it 'returns the user name' do
        expect(JSON.parse(response.body)['username']).to eq('manish')
      end

      it 'returns the username' do
        expect(JSON.parse(response.body)['email']).to eq('manish@gmail.com')
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end  
  end

  describe 'GET method of check' do 
 
    it 'render towards the check page' do 
      get :check
      expect(response.body).to eq("check method ahs been hit")
    end
    it 'show status code' do
      get :check
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe 'GET method of index' do 
    it 'render towards the username of index page' do 
      get :index
      user=JSON.parse(response.body).first
      expect(user['username']).to eq("vikas")
    end
    it 'render towards the email of index page' do 
      get :index
      user=JSON.parse(response.body).first
      expect(user['email']).to eq("vikas@gmail.com")
    end
    it 'render towards the username of index page' do 
      get :index
      expect(response).to have_http_status(:ok)
    end
    
  end

  describe 'GET method of show' do 
    let(:user) {User.create(username:"vikas",email: 'vikas@gamil.com',password: 'yadav')}  
    it 'render towards the show page' do 
    
      get :show, params: {_username:user.username}
    
      user=JSON.parse(response.body)
      expect(user['username']).to eq("vikas")
    end   
  end

  describe 'DELETE method of destroy' do 
    it 'delete method has been hit' do 
      user=User.create(username:"shreesh",email: 'shreesh@gamil.com',password: 'yadav')  
      delete :destroy, params: {_username:user.username}
      expect(response.status).to eq(204)
    end
  end

end