require "sinatra"
require "sinatra/reloader"

require "dotenv/load"

require "http"

get("/") do
  
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  
  @raw_response = HTTP.get(api_url)

  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @currencies = @parsed_data.fetch("currencies")

  erb(:homepage)

end

get("/:from_currency") do
  @the_symbol = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  @raw_response = HTTP.get(api_url)

  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @currencies = @parsed_data.fetch("currencies")

  erb(:step_one)

end

get("/:from_currency/:to_currency") do
  @from = params.fetch("from_currency")
  @to = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?from=#{@from}&to=#{@to}&amount=1&access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  @raw_response = HTTP.get(api_url)

  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @amount = @parsed_data.fetch("result")
  
  erb(:step_two)

end

# get("/:from_currency") do
#   @original_currency = params.fetch("from_currency")

#   api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  
# end

# get("/:from_currency/:to_currency") do
#   @original_currency = params.fetch("from_currency")
#   @destination_currency = params.fetch("to_currency")

#   api_url = "https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  
# end
