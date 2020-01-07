defmodule Weather.Fetcher do
  require Logger

  import SweetXml

  @wheather_url "https://w1.weather.gov/xml/current_obs/KDTO.xml"

  def fetch() do
    Logger.info("Fetching weather.")

    @wheather_url
    |> HTTPoison.get
    |> handle_response
    |> parse_response
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Response received: status code = #{status_code}")
    Logger.debug("Response received: body = #{body}")

    {
      status_code |> check_status,
      body
    }
  end

  defp check_status(200), do: :ok
  defp check_status(_), do: :error

  def parse_response({:error, error}) do
    Logger.info("Failure: #{error}")
    System.halt(2)
  end

  def parse_response({:ok, body}) do
    body |> xmap(
      current_observation: [
        ~x[//current_observation],
        location: ~x[./location/text()]s,
        station_id: ~x[./station_id/text()]s,
        latitude: ~x[./latitude/text()]f,
        longitude: ~x[./longitude/text()]f,
        temp_f: ~x[./temp_f/text()]f,
        temp_c: ~x[./temp_c/text()]f,
        weather: ~x[./weather/text()]s,
        wind_string: ~x[./wind_string/text()]s
      ])
  end

end
