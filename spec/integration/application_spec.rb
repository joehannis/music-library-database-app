require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context 'POST /album' do
    it 'should create a new album' do
      response = post('/albums', title: 'OK Computer', release_year: '1997', artist_id: '1')
      expect(response.status).to eq(200)
      expect(response.body).to eq ('Your album has been added!')

      response = get('/albums')
      expect(response.body).to include("OK Computer")

    end
  end
  context 'GET /artists' do
    it 'retrieve all artists' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include("Pixies, ABBA, Taylor Swift, Nina Simone")
    end
  end
  context 'POST /artist' do
    it 'should create a new artist' do
      response = post('/artists', name: 'Wild Thing', genre: 'Indie')
      expect(response.status).to eq(200)
      expect(response.body).to eq ('Your album has been added!')

      response = get('/artists')
      expect(response.body).to include("Wild Thing")

    end
  end
  context 'GET /albums/:id' do
    it 'retrieve artist by album id' do
      response = get('/albums/1')
      expect(response.body).to include("Doolittle")
      expect(response.body).to include("Pixies")
    end
  end
  context 'Get /albums' do
    it 'returns a list of albums' do
      response = get('/albums')
      expect(response.body).to include("Title: Waterloo")
      expect(response.body).to include("Title: Surfer Rosa")
    end
  end
end