defmodule Weather.CLI do
  def main(argv) do
    Weather.Fetcher.fetch
    |> display
  end

  def display(weather) do
    """
    Station: #{weather.current_observation.station_id}
    Location: #{weather.current_observation.location}
    Wheather: #{weather.current_observation.weather}
    Temp (C): #{weather.current_observation.temp_c}
    Temp (f): #{weather.current_observation.temp_f}
    Wind: #{weather.current_observation.wind_string}
    """
    |> IO.write
  end
end
