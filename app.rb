# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums/new' do
    return erb(:albums_form)
  end

  get '/artists/new' do
    return erb(:artists_form)
  end


  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:all_albums)

  end
  
  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:all_artists)
  end

  post '/albums' do
    def invalid_request_parameters?
      # Are the params nil?
      return true if params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
    
      # Are they empty strings?
      return true if params[:title] == "" || params[:release_year] == "" || params[:artist_id] == ""
    
      return false
    end
    if invalid_request_parameters?
      status 400
  
      return ''
    end
  
    # Parameters are valid,
    # the rest of the route can execute.
  repo = AlbumRepository.new
  new_album = Album.new
  new_album.title = params[:title]
  new_album.release_year = params[:release_year]
  new_album.artist_id = params[:artist_id]

  repo.create(new_album)
  return 'Your album has been added!'
end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artists = ArtistRepository.new

    @album = repo.find(params[:id])
    @artist = artists.find(@album.artist_id)
    return erb(:album)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])
    return erb(:artist)
  end

  
  post '/artists' do
    repo = ArtistRepository.new
    new_artist = Artist.new
    new_artist.name = params[:name]
    new_artist.genre = params[:genre]

    repo.create(new_artist)
    return 'Your album has been added!'
  end
end