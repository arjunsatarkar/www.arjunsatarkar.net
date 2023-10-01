defmodule WwwArjunsatarkarNet.Template do
  require EEx
  require Logger
  @spec compile_templates :: nil
  def compile_templates do
    {:ok, template_file_names} =
      Application.fetch_env(:www_arjunsatarkar_net, :templates_to_compile)

    parent = self()
    # Let's use a separate process that sleeps forever when done to ensure that the only thing
    # that inserts into our :compiled_templates ETS table is this function (not eg. the caller.)
    pid =
      spawn_link(fn ->
        :ets.new(:compiled_templates, [:named_table, {:read_concurrency, true}])

        for file_name <- template_file_names do
          Logger.debug("Compiling template #{file_name} ...")
          :ets.insert(:compiled_templates, {file_name, EEx.compile_file(file_name)})
        end

        send(parent, {:compile_templates_done, self()})

        Process.sleep(:infinity)
      end)

    receive do
      {:compile_templates_done, ^pid} -> nil
    end
  end

  @spec eval_compiled(String.t(), Code.binding(), Macro.Env.t() | keyword()) :: String.t()
  def eval_compiled(file_name, binding \\ [], env_or_opts \\ []) do
    [{_file_name, compiled}] = :ets.lookup(:compiled_templates, file_name)
    {page, _bindings} = Code.eval_quoted(compiled, binding, env_or_opts)
    page
  end
end
