defmodule ShopifyAPI.EventPipe.EventQueue do
  require Logger
  alias ShopifyAPI.AuthToken
  alias ShopifyAPI.EventPipe.Event

  @doc """
  Event enqueue end point, takes the event and the options to be passed on to Exq.

  options: [max_retries: #] or any Exq valid enqueue option.
  """
  @spec enqueue(Event.t(), keyword()) :: {:ok} | {:error, String.t()}
  def enqueue(event, opts \\ [])

  def enqueue(%Event{destination: "application"} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.ApplicationWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{fulfillment: %{}}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.FulfillmentWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{inventory_level: %{}}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.InventoryLevelWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{location: %{}}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.LocationWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{metafield: %{}}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.MetafieldWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{product: %{}}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.ProductWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{tender_transaction: _}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.TenderTransactionWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{transaction: %{}}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.TransactionWorker, event, opts)

  def enqueue(%Event{destination: "shopify", object: %{variant: %{}}} = event, opts),
    do: enqueue_event(ShopifyAPI.EventPipe.VariantWorker, event, opts)

  def enqueue(event, _opts) do
    Logger.warn(fn ->
      "#{__MODULE__} does not know what worker should handle #{inspect(event)}"
    end)

    {:error, "No worker to handle this event"}
  end

  defp enqueue_event(worker, %{token: %AuthToken{} = token} = event, opts) do
    Logger.info(fn -> "Enqueueing[#{inspect(token)}] #{inspect(event)}" end)
    background_job_enqueue(AuthToken.create_key(token), worker, [event], opts)
    {:ok}
  end

  defp enqueue_event(_worker, %{token: token} = _event, _) do
    Logger.error(fn -> "Unable to create token from #{inspect(token)}" end)
    {:error, "Token needs to be an AuthToken.t"}
  end

  defp enqueue_event(worker, event, opts) do
    Logger.warn(fn -> "Enqueueing in default queue #{inspect(event)}" end)
    background_job_enqueue("default", worker, [event], opts)
    {:ok}
  end

  def subscribe(token) do
    background_job_impl().subscribe(token)
  end

  defp background_job_enqueue(queue_name, worker, events, opts) do
    background_job_impl().enqueue(queue_name, worker, events, opts)
  end

  defp background_job_impl do
    Application.get_env(
      :shopify_api,
      :background_job_implementation,
      ShopifyAPI.EventPipe.ExqBackgroundJob
    )
  end
end
