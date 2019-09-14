defmodule HasManyLiveView.Repo do
  use Ecto.Repo,
    otp_app: :has_many_live_view,
    adapter: Ecto.Adapters.Postgres
end
