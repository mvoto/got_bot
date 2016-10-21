defmodule GotBot.Command do
  def perform_char(query) do
    json = got_api_request("characters", "name=#{query}")

    if is_nil json do
      "Sorry Lord Commander, your therm failed, please try another one"
    else
      {:ok, name}  = Map.fetch(json, "name")
      {:ok, title} = Map.fetch(json, "titles")

      "#{name}, famous as #{hd(title)}"
    end
  end

  def perform_house(query) do
    json = got_api_request("houses", "name=#{query}")

    if is_nil json do
      "Sorry Lord Commander, your therm failed, please try another one"
    else
      {:ok, name}   = Map.fetch(json, "name")
      {:ok, words}  = Map.fetch(json, "words")
      {:ok, region} = Map.fetch(json, "region")

      "#{name}, from #{region} says #{words}"
    end
  end

  def perform_gif(query) do
    url = "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{query}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url)

    Poison.decode(body) |> elem(1) |> Map.fetch!("data") |> Map.fetch!("image_url")
  end

  defp got_api_request(endpoint, query_string) do
    url = "http://www.anapioficeandfire.com/api/#{endpoint}?#{query_string}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(url)

    Poison.decode(body) |> elem(1) |> List.first
  end
end
