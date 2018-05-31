defmodule ShopifyApi.Rest.DiscountCode do
  @moduledoc """
  ShopifyApi REST API DiscountCode resource
  """

  alias ShopifyApi.AuthToken
  alias ShopifyApi.Rest.Request

  @doc """
  Create a discount code.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.create(auth, map)
      {:ok, { "discount_code" => %{} }}
  """
  def create(
        %AuthToken{} = auth,
        %{discount_code: %{price_rule_id: price_rule_id}} = discount_code
      ) do
    Request.post(auth, "price_rules/#{price_rule_id}/discount_codes.json", discount_code)
  end

  @doc """
  Update an existing discount code.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.update(auth, integer, map)
      {:ok, { "discount_code" => %{} }}
  """
  def update(
        %AuthToken{} = auth,
        price_rule_id,
        %{discount_code: %{id: discount_code_id}} = discount_code
      ) do
    Request.put(
      auth,
      "price_rules/#{price_rule_id}/discount_codes/#{discount_code_id}.json",
      discount_code
    )
  end

  @doc """
  Return all the discount codes.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.all(auth, integer)
      {:ok, { "discount_codes" => [] }}
  """
  def all(%AuthToken{} = auth, price_rule_id) do
    Request.get(auth, "price_rules/#{price_rule_id}/discount_codes.json")
  end

  @doc """
  Get a single discount code.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.get(auth, integer, integer)
      {:ok, { "discount_code" => %{} }}
  """
  def get(%AuthToken{} = auth, price_rule_id, discount_code_id) do
    Request.get(auth, "price_rules/#{price_rule_id}/discount_codes/#{discount_code_id}.json")
  end

  @doc """
  Retrieve the location of a discount code.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.query(auth, string)
      {:ok, { "location" => "" }}
  """
  def query(%AuthToken{} = auth, coupon_code) do
    Request.get(auth, "discount_codes/lookup.json?code=#{coupon_code}")
  end

  @doc """
  Delete a discount code.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.delete(auth, integer, integer)
      {:ok, 204 }}
  """
  def delete(%AuthToken{} = auth, price_rule_id, discount_code_id) do
    Request.delete(auth, "price_rules/#{price_rule_id}/discount_codes/#{discount_code_id}.json")
  end

  @doc """
  Creates a discount code creation job.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.createBatch(auth, list)
      {:ok, "discount_codes" => [] }}
  """
  def create_batch(auth, price_rule_id, %{discount_codes: []} = discount_codes) do
    Request.post(auth, "price_rules/#{price_rule_id}/batch.json", discount_codes)
  end

  @doc """
  Get a discount code creation job.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.get_batch(auth, integer, integer)
      {:ok, "discount_code_creation" => %{} }
  """
  def get_batch(%AuthToken{} = auth, price_rule_id, batch_id) do
    Request.get(auth, "price_rules/#{price_rule_id}/batch/#{batch_id}.json")
  end

  @doc """
  Return a list of discount codes for a discount code creation job.

  ## Example

      iex> ShopifyApi.Rest.DiscountCode.all_batch(auth, integer, integer)
      {:ok, "discount_codes" => [] }
  """
  def all_batch(%AuthToken{} = auth, price_rule_id, batch_id) do
    Request.get(auth, "price_rules/#{price_rule_id}/batch/#{batch_id}/discount_code.json")
  end
end