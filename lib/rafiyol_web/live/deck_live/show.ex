defmodule RafiyolWeb.DeckLive.Show do
  use RafiyolWeb, :live_view

  alias Rafiyol.Decks

  @impl true
  def mount(_params, session, socket) do
    user = Rafiyol.Accounts.get_user_by_session_token(session["user_token"])

    {:ok, assign(socket, :user, user)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:deck, Decks.get_deck!(id))}
  end

  defp page_title(:show), do: "Show Deck"
  defp page_title(:edit), do: "Edit Deck"
end
