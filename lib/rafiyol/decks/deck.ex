defmodule Rafiyol.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "decks" do
    field :name, :string
    belongs_to :owner, Rafiyol.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  @doc false
  def assoc_with(deck, user_id) do
    deck
    |> put_change(:owner_id, user_id)
    |> assoc_constraint(:owner)
  end
end
