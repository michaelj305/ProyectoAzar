defmodule Azar.Sorteo do
  defstruct [:nombre, :fecha, :valor_billete, :cant_fracciones, :cant_billetes]

  def main do
    "\n=== GESTIÓN DE SORTEOS (ADMIN) ==="
    |> Util.mostrar_mensaje()
    menu()
  end

  defp menu do
    "\n1. Crear sorteo\n2. Salir"
    |> Util.mostrar_mensaje()

    opcion = "Seleccione una opción: "
    |> Util.ingresar(:texto)

    case opcion do
      "1" -> crear_sorteo(); menu()
      "2" -> "Cerrando sesión de administrador..." |> Util.mostrar_mensaje()
      _   -> "Opción inválida, intenta de nuevo." |> Util.mostrar_mensaje(); menu()
    end
  end

  defp crear_sorteo do
    "\n--- Ingrese los datos del nuevo sorteo ---"
    |> Util.mostrar_mensaje()

    nombre     = "Nombre del sorteo: "      |> Util.ingresar(:texto)
    fecha      = "Fecha (DD/MM/AAAA): "     |> Util.ingresar(:texto)
    valor      = "Valor del billete ($): "  |> Util.ingresar(:entero)
    fracciones = "Cantidad de fracciones: " |> Util.ingresar(:entero)
    billetes   = "Cantidad de billetes: "   |> Util.ingresar(:entero)

    sorteo = %Azar.Sorteo{
      nombre: nombre,
      fecha: fecha,
      valor_billete: valor,
      cant_fracciones: fracciones,
      cant_billetes: billetes
    }

    guardar_sorteo(sorteo)

    """
    \n[ÉXITO] Sorteo creado exitosamente:
      - Nombre: #{sorteo.nombre}
      - Fecha: #{sorteo.fecha}
      - Valor del billete: $#{sorteo.valor_billete}
      - Fracciones: #{sorteo.cant_fracciones}
      - Cantidad de billetes: #{sorteo.cant_billetes}
    """
    |> Util.mostrar_mensaje()
  end

  defp guardar_sorteo(sorteo) do
    ruta = "sorteos.json"

    sorteos_existentes = case File.read(ruta) do
      {:ok, contenido} ->
        case Jason.decode(contenido) do
          {:ok, lista} -> lista
          _ -> []
        end
      _ -> []
    end

    nuevo = %{
      "nombre" => sorteo.nombre,
      "fecha" => sorteo.fecha,
      "valor_billete" => sorteo.valor_billete,
      "cant_fracciones" => sorteo.cant_fracciones,
      "cant_billetes" => sorteo.cant_billetes
    }

    actualizado = sorteos_existentes ++ [nuevo]

    case Jason.encode(actualizado, pretty: true) do
      {:ok, json} -> File.write(ruta, json)
      _ -> "Error al guardar" |> Util.mostrar_mensaje()
    end
  end
end
