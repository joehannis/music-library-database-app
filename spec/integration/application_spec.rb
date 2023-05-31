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
  context 'GET /artist/:id' do
    it 'retrieve artist by artist id' do
      response = get('/artists/1')
      expect(response.body).to include("Rock")
      expect(response.body).to include("Pixies")
    end
  end
  context 'Get /albums' do
    it 'returns a list of albums as HTML links' do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a><br />')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a><br />')
      expect(response.body).to include('<a href="/albums/4">Super Trouper</a><br />')
    end
  end
  context 'Get /artists' do
    it 'returns a list of artists as HTML links' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/artists/2">ABBA</a><br />')
      expect(response.body).to include('<a href="/artists/3">Taylor Swift</a><br />')
      expect(response.body).to include('<a href="/artists/4">Nina Simone</a><br />')
    end
  end
end