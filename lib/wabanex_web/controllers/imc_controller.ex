defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller

  # criar "apelido"
  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  defp handle_response({:ok, result}, conn), do: reder_reponse(conn, result, :ok)

  defp handle_response({:error, result}, conn), do: reder_reponse(conn, result, :bad_request)

  defp reder_reponse(conn, result, status) do
    conn
    |> put_status(status)
    |> json(%{result: result})
  end

end
