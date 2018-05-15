defmodule ShopifyApi.Rest.PriceRule do
  @moduledoc """
  ShopifyApi REST API PriceRule resource
  """

  alias ShopifyApi.AuthToken
  alias ShopifyApi.Rest.Request

  @doc """
  Create a price rule.

  ## Example

      iex> ShopifyApi.Rest.PriceRule.create(auth, map)
      {:ok, { "price_rule" => %{} }}
  """
  def create(%AuthToken{} = auth, %{price_rule: %{}} = price_rule) do
    Request.post(auth, "price_rules.json", price_rule)
  end

  @doc """
  Update an existing price rule.

  ## Example

      iex> ShopifyApi.Rest.PriceRule.update(auth, map)
      {:ok, { "price_rule" => %{} }}
  """
  def update(%AuthToken{} = auth, %{price_rule: %{id: price_rule_id}} = price_rule) do
    Request.put(auth, "price_rules/#{price_rule_id}.json", price_rule)
  end

  @doc """
  Return a list of all price rules.

  ## Example

      iex> ShopifyApi.Rest.PriceRule.all(auth)
      {:ok, { "price_rules" => [] }}
  """
  def all(%AuthToken{} = auth) do
    Request.get(auth, "price_rules.json")
  end

  @doc """
  Get a single price rule.

  ## Example

      iex> ShopifyApi.Rest.PriceRule.get(auth, integer)
      {:ok, { "price_rule" => %{} }}
  """
  def get(%AuthToken{} = auth, price_rule_id) do
    Request.get(auth, "price_rules/#{price_rule_id}.json")
  end

  @doc """
  Delete a price rule.

  ## Example

      iex> ShopifyApi.Rest.PriceRule.delete(auth, string)
      {:ok, 204 }}
  """
  def delete(%AuthToken{} = auth, price_rule_id) do
    Request.delete(auth, "price_rules/#{price_rule_id}.json")
  end
end
