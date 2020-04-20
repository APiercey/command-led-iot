defmodule Myhome.ProjectLuminosity do
  def call(luminosity) do
    :ok =
      %{
        points: [
          %{
            measurement: "led",
            fields: %{luminosity: luminosity}
          }
        ],
        database: "devices"
      }
      |> Myhome.InstreamConnection.write()

    {:ok, "Projected"}
  end
end
