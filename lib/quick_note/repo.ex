defmodule QuickNote.Repo do
  use Ecto.Repo,
    otp_app: :quick_note,
    adapter: Ecto.Adapters.Postgres
end
