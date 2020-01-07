defmodule FetcherTest do
  use ExUnit.Case
  doctest Weather


  @received_weather """
  <?xml version="1.0" encoding="ISO-8859-1"?>
  <?xml-stylesheet href="latest_ob.xsl" type="text/xsl"?>
  <current_observation version="1.0"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="http://www.weather.gov/view/current_observation.xsd">
        <credit>NOAA's National Weather Service</credit>
        <credit_URL>http://weather.gov/</credit_URL>
        <image>
                <url>http://weather.gov/images/xml_logo.gif</url>
                <title>NOAA's National Weather Service</title>
                <link>http://weather.gov</link>
        </image>
        <suggested_pickup>15 minutes after the hour</suggested_pickup>
        <suggested_pickup_period>60</suggested_pickup_period>
        <location>Denton Enterprise Airport, TX</location>
        <station_id>KDTO</station_id>
        <latitude>33.20505</latitude>
        <longitude>-97.20061</longitude>
        <observation_time>Last Updated on Jan 7 2020, 2:53 am CST</observation_time>
        <observation_time_rfc822>Tue, 07 Jan 2020 02:53:00 -0600</observation_time_rfc822>
        <weather>Fair</weather>
        <temperature_string>36.0 F (2.2 C)</temperature_string>
        <temp_f>36.0</temp_f>
        <temp_c>2.2</temp_c>
        <relative_humidity>62</relative_humidity>
        <wind_string>Northwest at 5.8 MPH (5 KT)</wind_string>
        <wind_dir>Northwest</wind_dir>
        <wind_degrees>300</wind_degrees>
        <wind_mph>5.8</wind_mph>
        <wind_kt>5</wind_kt>
        <pressure_string>1027.5 mb</pressure_string>
        <pressure_mb>1027.5</pressure_mb>
        <pressure_in>30.35</pressure_in>
        <dewpoint_string>24.1 F (-4.4 C)</dewpoint_string>
        <dewpoint_f>24.1</dewpoint_f>
        <dewpoint_c>-4.4</dewpoint_c>
        <windchill_string>31 F (-1 C)</windchill_string>
        <windchill_f>31</windchill_f>
        <windchill_c>-1</windchill_c>
        <visibility_mi>10.00</visibility_mi>
        <icon_url_base>http://forecast.weather.gov/images/wtf/small/</icon_url_base>
        <two_day_history_url>http://www.weather.gov/data/obhistory/KDTO.html</two_day_history_url>
        <icon_url_name>nskc.png</icon_url_name>
        <ob_url>http://www.weather.gov/data/METAR/KDTO.1.txt</ob_url>
        <disclaimer_url>http://weather.gov/disclaimer.html</disclaimer_url>
        <copyright_url>http://weather.gov/disclaimer.html</copyright_url>
        <privacy_policy_url>http://weather.gov/notice.html</privacy_policy_url>
  </current_observation>
  """

  test "Parse datas" do
    data = Weather.Fetcher.parse_response({:ok, @received_weather})
    assert data == %{
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
  end

end
