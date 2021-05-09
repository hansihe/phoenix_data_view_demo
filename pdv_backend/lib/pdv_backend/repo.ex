defmodule PdvBackend.Repo do
  use Ecto.Repo,
    otp_app: :pdv_backend,
    adapter: Ecto.Adapters.Postgres
end
