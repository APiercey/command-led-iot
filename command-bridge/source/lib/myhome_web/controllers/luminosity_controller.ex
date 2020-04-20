defmodule MyhomeWeb.LuminosityController do
  use MyhomeWeb, :controller

  def update(conn, %{"luminosity" => luminosity}) do
    {:ok, _} = Myhome.SetLuminosity.call(luminosity)
    send_resp(conn, :ok, "Luminosity of #{luminosity} has been set")
  end
end
