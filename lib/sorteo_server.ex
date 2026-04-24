defmodule Azar.SorteoServer do
  use GenServer
  alias AzarSorteo
  alias Azar.Logger

  # --- Interfaz ---

  def start_link(%AzarSorteo{} = datos) do
    GenServer.start_link(__MODULE__, datos, name: {:global, datos.id})
  end

  def obtener_info(id_sorteo) do
    GenServer.call({:global, id_sorteo}, :consultar)
  end

  # --- Servidor ---

  @impl true
  def init(%AzarSorteo{} = sorteo) do
    File.mkdir_p!("sorteos")
    path = "sorteos/#{sorteo.id}.json"

    estado_actual =
      case File.read(path) do
        {:ok, contenido} ->
          contenido
          |> Jason.decode!(keys: :atoms)
          |> struct(AzarSorteo)

        {:error, _} ->
          guardar_json(sorteo)
          sorteo
      end

    {:ok, estado_actual}
  end

  @impl true
  def handle_call(:consultar, _from, estado) do
    Logger.registrar("Consulta de datos sorteo: #{estado.nombre}", "ok")
    {:reply, estado, estado}
  end

  # --- Persistencia ---

  defp guardar_json(estado) do
    path = "sorteos/#{estado.id}.json"

    estado
    |> Map.from_struct()
    |> Jason.encode!()
    |> (&File.write!(path, &1)).()
  end
end
