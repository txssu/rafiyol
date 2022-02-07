defmodule Rafiyol.Decks do
  @moduledoc """
  The Decks context.
  """

  import Ecto.Query, warn: false
  alias Rafiyol.Repo

  alias Rafiyol.Decks.Deck

  @doc """
  Returns the list of user's decks.

  ## Examples

      iex> list_decks(user_id)
      [%Deck{}, ...]

  """
  def list_decks(user_id) do
    query =
      from d in Deck,
        where: d.owner_id == ^user_id

    Repo.all(query)
  end

  @doc """
  Gets a single deck.

  Raises `Ecto.NoResultsError` if the Deck does not exist.

  ## Examples

      iex> get_deck!(123)
      %Deck{}

      iex> get_deck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deck!(id), do: Repo.get!(Deck, id)

  @doc """
  Creates a deck.

  ## Examples

      iex> create_deck(user.id, %{field: value})
      {:ok, %Deck{}}

      iex> create_deck(user.id, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deck(user_id, attrs \\ %{}) do
    %Deck{}
    |> Deck.changeset(attrs)
    |> Deck.assoc_with(user_id)
    |> Repo.insert()
  end

  @doc """
  Updates a deck.

  ## Examples

      iex> update_deck(deck, %{field: new_value})
      {:ok, %Deck{}}

      iex> update_deck(deck, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deck(%Deck{} = deck, attrs) do
    deck
    |> Deck.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deck.

  ## Examples

      iex> delete_deck(deck)
      {:ok, %Deck{}}

      iex> delete_deck(deck)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deck(%Deck{} = deck) do
    Repo.delete(deck)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deck changes.

  ## Examples

      iex> change_deck(deck)
      %Ecto.Changeset{data: %Deck{}}

  """
  def change_deck(%Deck{} = deck, attrs \\ %{}) do
    Deck.changeset(deck, attrs)
  end
end
