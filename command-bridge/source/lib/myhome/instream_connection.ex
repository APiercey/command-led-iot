defmodule Myhome.InstreamConnection do
  use Instream.Connection,
    otp_app: :my_app,
    config: [
      host: "influxdb",
      port: 8086
    ]
end
