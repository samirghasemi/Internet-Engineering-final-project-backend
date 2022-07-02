defmodule TorobBackendWeb.ReportView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ReportView

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, ReportView, "report.json")}
  end

  def render("show.json", %{report: report}) do
    %{data: render_one(report, ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{
      id: report.id,
      message: report.message,
      desc: report.desc,
      user_id: report.user_id,
      shop_id: report.shop_id,
      product_id: report.product_id
    }
  end
end
