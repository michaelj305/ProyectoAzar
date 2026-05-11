defmodule Azar.Logger do

  def registrar(solicitud, resultado) do
    registrar(:info, "Sistema", solicitud, resultado)
  end

  @doc """
  Registra un evento con nivel, módulo, solicitud y resultado.
  Niveles válidos: :info, :warning, :error
  Formato: [NIVEL] FECHA HORA - Módulo - Solicitud - Resultado
  """
  def registrar(nivel, modulo, solicitud, resultado) do
    tiempo = DateTime.utc_now()
    fecha = DateTime.to_date(tiempo) |> Date.to_string()
    hora = DateTime.to_time(tiempo) |> Time.to_string()

    nivel_str = nivel |> Atom.to_string() |> String.upcase()

    linea = "[#{nivel_str}] #{fecha} #{hora} - #{modulo} - #{solicitud} - #{resultado}"

    IO.puts(linea)

    File.write("lib/bitacora.txt", linea <> "\n", [:append])
  end
end
