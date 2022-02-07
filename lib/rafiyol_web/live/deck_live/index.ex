defmodule RafiyolWeb.DeckLive.Index do
  use RafiyolWeb, :live_view

  alias Rafiyol.Decks
  alias Rafiyol.Decks.Deck

  @impl true
  def mount(_params, session, socket) do
    user = Rafiyol.Accounts.get_user_by_session_token(session["user_token"])
    socket = assign(socket, :user, user)
    {:ok, assign(socket, :decks, list_decks(user))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Deck")
    |> assign(:deck, Decks.get_deck!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deck")
    |> assign(:deck, %Deck{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Decks")
    |> assign(:deck, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deck = Decks.get_deck!(id)
    {:ok, _} = Decks.delete_deck(deck)

    {:noreply, assign(socket, :decks, list_decks(socket.assigns.user))}
  end

  defp list_decks(user) do
    Decks.list_decks(user.id)
  end
end
