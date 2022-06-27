defmodule TorobBackend.Repo do
  use Ecto.Repo,
    otp_app: :torob_backend,
    adapter: Ecto.Adapters.Postgres
end
