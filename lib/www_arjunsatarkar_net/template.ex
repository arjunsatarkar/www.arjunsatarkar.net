defmodule WwwArjunsatarkarNet.Template do
  require EEx
  require Logger
  @spec compile :: nil
  def compile do
    {:ok, template_file_names} =
      Application.fetch_env(:www_arjunsatarkar_net, :template_file_names)

    Logger.info("Compiling templates...")
    parent = self()
    # Let's use a separate process that sleeps forever when done to ensure that the only thing
    # that inserts into our :compiled_templates ETS table is this function (not eg. the caller.)
    pid =
      spawn_link(fn ->
        :ets.new(:compiled_templates, [:named_table, {:read_concurrency, true}])

        for file_name <- template_file_names do
          Logger.info("Compiling template #{file_name} ...")
          :ets.insert(:compiled_templates, {file_name, EEx.compile_file(file_name)})
        end

        Logger.info("Finished compiling templates.")

        send(parent, {:compile_templates_done, self()})

        Process.sleep(:infinity)
      end)

    receive do
      {:compile_templates_done, ^pid} -> nil
    end
  end

  @spec get_compiled(binary()) :: any
  def get_compiled(file_name) do
    [{_file_name, page}] = :ets.lookup(:compiled_templates, file_name)
    page
  end
end
