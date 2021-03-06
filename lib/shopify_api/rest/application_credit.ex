defmodule ShopifyAPI.REST.ApplicationCredit do
  @moduledoc """
  ShopifyAPI REST API ApplicationCredit resource
  """

  alias ShopifyAPI.AuthToken
  alias ShopifyAPI.REST

  @doc """
  Create an application credit.

  ## Example

      iex> ShopifyAPI.REST.ApplicationCredit.create(auth, map)
      {:ok, { "application_credit" => %{} }}
  """
  def create(%AuthToken{} = auth, %{application_credit: %{}} = application_credit),
    do: REST.post(auth, "application_credits.json", application_credit)

  @doc """
  Get a single application credit.

  ## Example

      iex> ShopifyAPI.REST.ApplicationCredit.get(auth, integer)
      {:ok, %{} = application_credit}
  """
  def get(%AuthToken{} = auth, application_credit_id, params \\ [], options \\ []),
    do:
      REST.get(
        auth,
        "application_credits/#{application_credit_id}.json",
        params,
        Keyword.merge([pagination: :none], options)
      )

  @doc """
  Get a list of all application credits.

  ## Example

      iex> ShopifyAPI.REST.ApplicationCredit.all(auth)
      {:ok, [%{}, ...] = application_credits}
  """
  def all(%AuthToken{} = auth, params \\ [], options \\ []),
    do:
      REST.get(
        auth,
        "application_credits.json",
        params,
        Keyword.merge([pagination: :none], options)
      )
end
