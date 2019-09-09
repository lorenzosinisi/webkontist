defmodule WebKontistWeb.PageController do
  use WebKontistWeb, :controller

  alias Phoenix.LiveView

  def index(conn, _) do
    LiveView.Controller.live_render(conn, WebKontistWeb.DashboardLive, session: %{})
  end
end
