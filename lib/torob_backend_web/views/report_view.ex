defmodule TorobBackendWeb.ReportView do
  use TorobBackendWeb, :view
  alias TorobBackendWeb.ReportView

  def render("index.json", %{reports: reports}) do
   render_many(reports, ReportView, "report.json")
  end

  def render("show.json", %{report: report}) do
    render_one(report, ReportView, "report.json")
  end
  def render("show1.json", %{report: report}) do
    render_one(report, ReportView, "report1.json")
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

  def render("report1.json", %{report: report}) do
    %{
      id: report.id,
      message: report.message,
      desc: report.desc,
      user_id: report.user_id,
      shop_id: report.shop_id,
      products: render_one(report.products, ProductView, "product1.json")
    }
  end
end
