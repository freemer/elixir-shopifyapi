defmodule ShopifyApi.Request do
  @moduledoc """
  Provides basic REST actions for hitting the Shopify API. Don't use this
  directly instead use one of the helper modules such as `ShopifyApi.Product`.

  Actons provided, the names correspond to the HTTP Action called.
    - get
    - put
    - post
    - delete
  """

  use HTTPoison.Base

  @transport "https://"
  if Mix.env() == :test do
    @transport "http://"
  end

  def get(auth, path) do
    shopify_request(:get, url(auth, path), "", headers(auth))
  end

  def put(auth, path, object) do
    shopify_request(:put, url(auth, path), Poison.encode!(object), headers(auth))
  end

  def post(auth, path, object) do
    shopify_request(:post, url(auth, path), Poison.encode!(object), headers(auth))
  end

  def delete(auth, path) do
    shopify_request(:delete, url(auth, path), "", headers(auth))
  end

  defp shopify_request(action, url, body, headers) do
    case request(action, url, body, headers) do
      {:ok, %{status_code: 200} = response} ->
        {:ok, fetch_body(response)}

      {:ok, response} ->
        {:error, fetch_body(response)}

      _ ->
        {:error, %{}}
    end
  end

  defp url(%{shop: domain}, path) do
    "#{@transport}#{domain}/admin/#{path}"
  end

  defp headers(%{token: access_token}) do
    [
      {"Content-Type", "application/json"},
      {"X-Shopify-Access-Token", access_token}
    ]
  end

  defp fetch_body(http_response) do
    with {:ok, map_fetched} <- http_response |> Map.fetch(:body),
         {:ok, body} <- map_fetched,
         do: body
  end

  defp process_response_body(body) do
    body |> Poison.decode()
  end
end
