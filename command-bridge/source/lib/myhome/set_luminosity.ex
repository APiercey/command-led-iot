defmodule Myhome.SetLuminosity do
  def call(luminosity) do
    :ok = Tortoise.publish("myhome", "command", Jason.encode!(%{"luminosity" => luminosity}))
    {:ok, "Set"}
  end
end
