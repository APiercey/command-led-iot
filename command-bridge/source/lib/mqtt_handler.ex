defmodule MqttHandler do
  use Tortoise.Handler

  def init(args), do: {:ok, args}
  def connection(_status, state), do: {:ok, state}
  def terminate(_reason, _state), do: :ok
  def subscription(_status, _topic_filter, state), do: {:ok, state}

  def handle_message(["home"], "luminosity=" <> luminosity, state) do
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

    {:ok, state}
  end

  def handle_message(_t, _message, state), do: {:ok, state}
end
