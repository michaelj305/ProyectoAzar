defmodule Estructura do
  def main do
    jugadores =
      Jugador.ingresar("Registro de jugadores", :jugadores)

    jugadores
    |> Jugador.escribir_json("jugadores.json")

  end
  end
