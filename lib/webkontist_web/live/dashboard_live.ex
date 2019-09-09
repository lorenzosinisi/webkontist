defmodule WebKontistWeb.DashboardLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div class="dashboard">
    <%= if @token do %>
    <%= for account <- @accounts do %>
      <button phx-click="select_account" phx-value="<%= Map.get(account, "id") %>"><%= Map.get(account, "iban") %></button>
    <% end %>
      <%= for transaction <- Map.get(@transactions, "results") do %>
        <div>
        <br />
        <%= Map.get(transaction, "amount") / 100 %> for
       <strong> <%= Map.get(transaction, "name") %> </strong> at 
        <%= Map.get(transaction, "bookingDate") %>
        </div>
    <% end %>
    <% else %>
      <form phx-change="login_change" phx-submit="login">
      <div class="container">
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="email" required>

      <label for="psw"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="password" required>
      <button type="submit">Login</button>
      </div>
      </form>
    <% end %>
    </div>
    """
  end

  def mount(_session, socket) do
    {:ok,
     assign(socket,
       token: nil,
       error: nil,
       accounts: [],
       current_account: nil,
       transactions: %{"results" => []}
     )}
  end

  def handle_event("login_change", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("login", %{"email" => email, "password" => password}, socket) do
    {:ok, %{"token" => token}} = Exkontist.Client.login(email, password)
    send(self(), :fetch_accounts)
    socket = assign(socket, token: token)
    {:noreply, socket}
  end

  def handle_event("select_account", account_id, socket) do
    send(self(), :fetch_transactions)
    socket = assign(socket, current_account: account_id)
    {:noreply, socket}
  end

  def handle_info(:fetch_transactions, socket) do
    %{token: token, current_account: account_id} = socket.assigns
    {:ok, transactions} = Exkontist.Client.account_transactions(account_id, token)
    socket = assign(socket, transactions: transactions)
    IO.inspect(transactions)
    {:noreply, socket}
  end

  def handle_info(:fetch_accounts, socket) do
    {:ok, accounts} = Exkontist.Client.accounts(socket.assigns.token)
    socket = assign(socket, accounts: accounts)
    {:noreply, socket}
  end
end
