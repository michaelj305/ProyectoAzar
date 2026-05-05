defmodule Azar.Jugador do
  defstruct nombre: "", identificacion: "", contraseña: "", tarjetaCredito: ""

  alias Azar.Util

  # Función para crear un jugador
  def crear(nombre, identificacion, contraseña, tarjetaCredito) do
    %__MODULE__{
      nombre: nombre,
      identificacion: identificacion,
      contraseña: contraseña,
      tarjetaCredito: tarjetaCredito
    }
  end

  def ingresar(mensaje) do
    Util.mostrar_mensaje(mensaje)

    nombre = Util.ingresar("Ingrese su nombre completo: ", :texto)
    identificacion = Util.ingresar("Ingrese su número de identificación: ", :texto)
    contraseña = Util.ingresar("Ingrese su contraseña: ", :texto)
    tarjetaCredito = Util.ingresar("Ingrese el número de su tarjeta de crédito: ", :texto)

    crear(nombre, identificacion, contraseña, tarjetaCredito)
  end

  def ingresar(mensaje, :jugadores) do
    ingresar(mensaje, [], :jugadores)
  end

  defp ingresar(mensaje, lista, :jugadores) do
    jugador = ingresar(mensaje)
    nueva_lista = lista ++ [jugador]

    mas_jugadores = Util.ingresar("\nDesea ingresar más jugadores (si/no)?: ", :boolean)

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

  def cargar_jugadores(nombre_archivo \\ "jugadores.json") do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        contenido
        |> Jason.decode!()
        |> Enum.map(fn mapa ->
          # Convertimos el mapa en nuestra estructura %Azar.Jugador{}
          struct(__MODULE__, for({k, v} <- mapa, into: %{}, do: {String.to_atom(k), v}))
        end)

      {:error, :enoent} ->
        # Si el archivo no existe, devolvemos lista vacía para que el programa siga
        []
    end
  end

 #Validar que no haya jugadores con la misma identificación y que no haya campos vacíos o jugadores que no existen

  def validar_lista(jugadores) do
    jugadores
    |> Enum.uniq_by(fn j -> j.identificacion end) # Quita duplicados por cédula
    |> Enum.filter(fn j -> j.nombre != "" and j.identificacion != "" end) # Quita vacíos
  end


end
