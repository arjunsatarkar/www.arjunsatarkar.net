defmodule WwwArjunsatarkarNet.Cache do
  require Logger
  @spec init :: nil
  def init do
    :ets.new(:cache, [:named_table, :public, {:read_concurrency, true}])
    nil
  end

  @spec insert(String.t(), any) :: nil
  def insert(location, content) do
    :ets.insert_new(:cache, {location, content})
    nil
  end

  @spec lookup(String.t()) :: {:ok, any} | :error
  def lookup(location) do
    case :ets.lookup(:cache, location) do
      [{^location, content}] ->
        Logger.debug("Fetched #{location} from cache.")
        {:ok, content}

      [] ->
        :error
    end
  end

  @spec try_cache(String.t(), [{:else, any}]) :: Macro.t()
  defmacro try_cache(location, else: content) do
    quote do
      case WwwArjunsatarkarNet.Cache.lookup(unquote(location)) do
        {:ok, cached_content} ->
          cached_content

        :error ->
          :ets.insert_new(:cache, {unquote(location), unquote(content)})
          unquote(content)
      end
    end
  end
end
