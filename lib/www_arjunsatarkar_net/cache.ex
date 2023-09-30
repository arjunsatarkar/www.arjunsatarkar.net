defmodule WwwArjunsatarkarNet.Cache do
  @spec init :: nil
  def init do
    :ets.new(:cache, [:named_table, :public, {:read_concurrency, true}])
    nil
  end

  @spec get_cached(binary(), [{:else, any}]) :: Macro.t()
  defmacro get_cached(location, else: content) do
    quote do
      case :ets.lookup(:cache, unquote(location)) do
        [{unquote(location), cached_content}] ->
          Logger.bare_log(:debug, "Fetched #{unquote(location)} from the cache.")
          cached_content

        _ ->
          Logger.bare_log(:debug, "Cache miss for #{unquote(location)}, adding it...")
          :ets.insert_new(:cache, {unquote(location), unquote(content)})
          unquote(content)
      end
    end
  end
end
