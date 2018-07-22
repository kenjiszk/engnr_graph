namespace :connpass_master_data do
  def get_event_data_default_params
    {
      ym: "201801",
      order: 2,
      count: get_count,
      start: 1,
    }
  end

  def base_url
    "https://connpass.com/api/v1/event/"
  end

  def get_count
    100
  end

  desc "get connpass event data from api"
  task :get_event_data do
    client = HTTPClient.new
    next_loop = true
    params = get_event_data_default_params
    while next_loop do
      request = client.get(base_url, params)
      response = JSON.parse(request.body)
      response["events"].each do |event|
        p event["event_id"]
      end
      params[:start] += get_count
      if params[:start] > response["results_available"]
        next_loop = false
      end
    end
  end
end
