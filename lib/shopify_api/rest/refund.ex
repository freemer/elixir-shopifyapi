defmodule ShopifyAPI.REST.Refund do
  @moduledoc """
  ShopifyAPI REST API Refund resource
  """

  alias ShopifyAPI.AuthToken
  alias ShopifyAPI.REST

  @doc """
  Return a list of all refunds for an order.

  ## Example

      iex> ShopifyAPI.REST.Refund.all(auth, string)
      {:ok, [] = refunds}
  """
  def all(%AuthToken{} = auth, order_id, params \\ [], options \\ []),
    do: REST.get(auth, "orders/#{order_id}/refunds.json", params, options)

  @doc """
  Get a specific refund.

  ## Example

      iex> ShopifyAPI.REST.Refund.get(auth, string, string)
      {:ok, %{} = refund}
  """
  def get(%AuthToken{} = auth, order_id, refund_id, params \\ [], options \\ []),
    do:
      REST.get(
        auth,
        "orders/#{order_id}/refunds/#{refund_id}.json",
        params,
        Keyword.merge([pagination: :none], options)
      )

  @doc """
  Calculate a refund.

  ## Example

      iex> ShopifyAPI.REST.Refund.calculate(auth, integer, map)
      {:ok, %{} = refund}
  """
  def calculate(%AuthToken{} = auth, order_id, %{refund: %{}} = refund),
    do: REST.post(auth, "orders/#{order_id}/refunds/calculate.json", refund)

  @doc """
  Create a refund.

  ## Example

      iex> ShopifyAPI.REST.Refund.create(auth, integer, map)
      {:ok, %{} = refund}
  """
  def create(%AuthToken{} = auth, order_id, %{refund: %{}} = refund),
    do: REST.post(auth, "orders/#{order_id}/refunds.json", refund)
end
