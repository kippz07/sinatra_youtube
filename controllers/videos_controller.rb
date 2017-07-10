class VideosController < Sinatra::Base
  # Sets toor as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # Sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }

  configure :development do
      register Sinatra::Reloader
  end

  $videos = [{
    id: 0,
    name: "Banana Shoes",
    description: "Slippin around in some banana shoes",
    url: "K4m5mr41g4c"
  },
  {
    id: 1,
    name: "We Are Number One but with Pokemon",
    description: "The meme of the year 2k16 but made with Pokemon cries",
    url: "MH_BxlSG2GM"
  }]

  # Index
  get "/videos" do
    @videos = $videos
    @count = $videos.length
    erb :index
  end

  # New
  get "/videos/new" do
    erb :new
  end

  # Show
  get "/videos/:id" do
    id = params[:id].to_i
    @video = $videos[id]
    erb :show
  end

  # Create
  post "/videos" do
    name = params[:name]
    description = params[:description]
    url = params[:url]
    new_video = {
      id: $videos.length,
      name: name,
      description: description,
      url: url
    }
    $videos.push new_video
    redirect :"/videos"
  end

  # Edit
  get "/videos/:id/edit" do
    id = params[:id].to_i
    @video = $videos[id]
    erb :edit
  end

  # Update
  put "/videos/:id" do
    id = params[:id].to_i
    video = $videos[id]
    video[:name] = params[:name]
    video[:description] = params[:description]
    video[:url] = params[:url]
    $videos[id] = video
    redirect :"/videos"
  end

  # Delete
  delete "/videos/:id" do
    id = params[:id].to_i
    video = $videos[id]
    $videos.delete video
    redirect :"/videos"
  end
end