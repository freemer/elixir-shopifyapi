defmodule ShopifyApi.AuthTokenServer do
  use GenServer
  import Logger, only: [info: 1]

  @name :shopify_api_auth_token_server

  def start_link do
    info("Starting #{__MODULE__}...")
    GenServer.start_link(__MODULE__, %{}, name: @name)
  end

  def all do
    GenServer.call(@name, :all)
  end

  def get(app_name) do
    GenServer.call(@name, {:get, app_name})
  end

  @spec count :: integer
  def count do
    GenServer.call(@name, :count)
  end

  def set(app_name, new_values) do
    GenServer.cast(@name, {:set, app_name, new_values})
  end

  #
  # Callbacks
  #

  def init(state), do: {:ok, state}

  @callback handle_cast(map, map) :: tuple
  def handle_cast({:set, app_name, new_values}, %{} = state) do
    new_state =
      update_in(state, [app_name], fn t ->
        case t do
          nil -> Map.merge(%ShopifyApi.AuthToken{}, new_values)
          _ -> Map.merge(t, new_values)
        end
      end)

    {:noreply, new_state}
  end

  def handle_call(:all, _caller, state) do
    {:reply, state, state}
  end

  def handle_call({:get, app_name}, _caller, state) do
    {:reply, Map.fetch(state, app_name), state}
  end

  def handle_call(:count, _caller, state) do
    {:reply, Enum.count(state), state}
  end
end
