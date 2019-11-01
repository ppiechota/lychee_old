defmodule Lychee.Repo do
  use Ecto.Repo,
    otp_app: :lychee,
    adapter: Ecto.Adapters.Postgres
end
