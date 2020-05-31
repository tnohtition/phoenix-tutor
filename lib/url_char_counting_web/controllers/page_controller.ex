defmodule UrlCharCountingWeb.PageController do
  use UrlCharCountingWeb, :controller

  def index(conn, params) do
    query = Map.get(params, "query", "")

    # Process the url
    character_map = process(query)

    render(conn, "index.html", character_map: character_map)
  end

  # Process the query
  defp process(nil) do
    %{}
  end

  defp process("") do
    %{}
  end

  # TODO: need to find a way to move this proces to separate Service
  defp process(query) do
    case fetch_url(query) do
      {:ok, %HTTPoison.Response{body: body}} -> truncate_html(body) |> character_counter()
      {:error, _} -> process(nil)
    end
  end

  # Fetch url base on HTTPoison
  defp fetch_url(url) do
    HTTPoison.get(url, [], [hackney: [{:follow_redirect, true}]])
  end

  # Truncate html tag
  defp truncate_html(content) do
    String.replace(content, ~r"<[^>]*>", "")
  end

  # Charter counter
  defp character_counter(content) do
    content |> String.graphemes() |> Enum.reduce(%{}, fn(char, acc) -> Map.update(acc, char, 1, &(&1 + 1)) end)
  end
end
