defmodule SbWeb.PromotionView do
  use SbWeb, :view
  alias SbWeb.PromotionView

  def render("index.json", %{promotions: promotions}) do
    %{data: render_many(promotions, PromotionView, "promotion.json")}
  end

  def render("show.json", %{promotion: promotion}) do
    %{data: render_one(promotion, PromotionView, "promotion.json")}
  end

  def render("promotion.json", %{promotion: promotion}) do
    %{
      id: promotion.id,
      code: promotion.code,
      ammount: CurrencyFormatter.format(promotion.ammount, :eur),
      expiration: promotion.expiration,
      state: promotion.state
    }
  end

  def render("not_found_event.json", _assigns) do
    %{code: 404, message: "event not found"}
  end
end
