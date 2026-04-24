defmodule Jugador do
  defstruct nombre: "", identificacion: "", contraseña: "", tarjetaCredito: ""

  #Función para crear un jugador
  def crear(nombre, identificacion, contraseña, tarjetaCredito) do
    %Jugador{nombre: nombre, identificacion: identificacion, contraseña: contraseña, tarjetaCredito: tarjetaCredito}

  end

  def ingresar(mensaje) do

    Util.mostrar_mensaje(mensaje)

    nombre = "Ingrese su nombre completo: "
    |> Util.ingresar(:texto)

    identificacion = "Ingrese su número de identificación: "
    |> Util.ingresar(:texto)

    contraseña = "Ingrese su contraseña: "
    |> Util.ingresar(:texto)

    tarjetaCredito = "Ingrese el número de su tarjeta de crédito: "
    |> Util.ingresar(:texto)

    crear(nombre, identificacion, contraseña, tarjetaCredito)

  end

  def ingresar(mensaje, :jugadores)do
    ingresar(mensaje, [], :jugadores)
  end

  defp ingresar(mensaje, lista, :jugadores)do
  jugador = ingresar(mensaje)

    nueva_lista = lista ++ [jugador]
    mas_jugadores = "\nDesea ingresar más jugadores (si/no)?: "
    |> Util.ingresar(:boolean)

    case mas_jugadores do
      true -> ingresar(mensaje, nueva_lista, :jugadores)

      false -> nueva_lista

    end
    end

    def escribir_json(jugadores, nombre) do
      jugadores
      |> Enum.map(&Map.from_struct/1)
      |> Jason.encode!()
      |> (&File.write(nombre, &1)).()
    end
  end
