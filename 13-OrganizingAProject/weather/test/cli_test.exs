defmodule CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Weather

  @received_weather %{
    current_observation: %{
      latitude: 33.20505,
      location: "Denton Enterprise Airport, TX",
      longitude: -97.20061,
      station_id: "KDTO",
      temp_c: 2.2,
      temp_f: 36.0,
      weather: "Fair",
      wind_string: "Northwest at 5.8 MPH (5 KT)"
    }
  }

  test "Display weather" do
    output = capture_io fn -> Wheather.CLI.display(@received_weather) end
    assert output == """
    Station: KDTO
    Location: Denton Enterprise Airport, TX
    Wheather: Fair
    Temp (C): 2.2
    Temp (f): 36.0
    Wind: Northwest at 5.8 MPH (5 KT)
    """
  end

end
