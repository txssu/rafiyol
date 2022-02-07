defmodule RafiyolWeb.DeckLive.FormComponent do
  use RafiyolWeb, :live_component

  alias Rafiyol.Decks

  @impl true
  def update(%{deck: deck, user: user} = assigns, socket) do
    changeset = Decks.change_deck(deck)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:user, user)}
  end

  @impl true
  def handle_event("validate", %{"deck" => deck_params}, socket) do
    changeset =
      socket.assigns.deck
      |> Decks.change_deck(deck_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"deck" => deck_params}, socket) do
    save_deck(socket, socket.assigns.action, deck_params)
  end

  defp save_deck(socket, :edit, deck_params) do
    case Decks.update_deck(socket.assigns.deck, deck_params) do
      {:ok, _deck} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deck updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_deck(socket, :new, deck_params) do
    case Decks.create_deck(socket.assigns.user.id, deck_params) do
      {:ok, _deck} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deck created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
