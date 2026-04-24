defmodule Util do
  @moduledoc """
  Módulo con funciones que se reutilizan
  - autor: Natalia Burbano
  - fecha: Febrero del 2026
  - Licencia: GNU GPL v3
  """

  @doc """
  Función para mostrar un mensaje en pantalla.
  ## Parámetro
  - mensaje: texto que se le presenta al usuario
  ## Ejemplo
  iex> Util.mostrar_mensaje("Hola mundo")

  o puede usar

  "Hola Mundo"
  |> Util.mostrar_mensaje()
  """
  def mostrar_mensaje (mensaje) do
    mensaje
    |> IO.puts()
  end

def ingresar_texto(mensaje) do
 mensaje
 |>IO.gets()
 |>String.trim()
 |>String.downcase()
end

def ingresar(mensaje, :texto) do
  mensaje
  |>IO.gets()
  |> String.trim()
  |> String.downcase()
end

def ingresar(mensaje, :entero) do
      #intenta convertir el texto ingresado a un entero
      try do
        mensaje
      |>Util.ingresar(:texto)
      |>String.to_integer()
      rescue
        ArgumentError ->
        "Error, se espera que ingrese un numero entero\n"
        |>mostrar_error()

        mensaje
        #vuelve y se llama a si misma para volver a funcionar
        |>ingresar(:entero)
      end
    end

def ingresar(mensaje, :real) do
      #intenta convertir el texto ingresado a un entero
      try do
        mensaje
      |>Util.ingresar(:texto)
      |>String.to_float()
      rescue
        ArgumentError ->
        "Error, se espera que ingrese un numero entero\n"
        |>mostrar_error()

        mensaje
        #vuelve y se llama a si misma para volver a funcionar
        |>ingresar(:real)
      end
    end

def mostrar_error(mensaje) do
  IO.puts(:standard_error, mensaje)
end

def ingresar(mensaje, :entero), do: ingresar(mensaje, &String.to_integer/1, :entero)

def ingresar(mensaje, :real), do: ingresar(mensaje, &String.to_float/1, :real)

defp ingresar(mensaje, parser, tipo_dato) do
  try do
    mensaje
    |>ingresar(:texto)
    |>parser.()
  rescue
    ArgumentError ->
      "Error, se espera que ingrese un numero #{tipo_dato}\n"
      |>mostrar_error()

      mensaje
      |>ingresar(parser,tipo_dato)
  end
end

def calcular_permutaciones_circulares(0), do: 0

def calcular_permutaciones_circulares(n) do
  (n-1)
  |> calcular_factorial()
end
def calcular_factorial(0), do: 1
def calcular_factorial(m), do: m* calcular_factorial(m-1)

def ingresar(mensaje, :atom) do
  mensaje
  |> IO.gets()
  |> String.trim()
  |> String.to_atom()
end

def ingresar(mensaje, :boolean) do
  valor=
    mensaje
    |> ingresar(:texto)
    |>String.downcase()

  Enum.member?(["si","sí", "s", "sisas", "sisas mi perro"], valor)

end

end
