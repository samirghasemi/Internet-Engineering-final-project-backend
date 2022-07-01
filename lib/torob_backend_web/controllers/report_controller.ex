defmodule TorobBackendWeb.ReportController do
  use TorobBackendWeb, :controller

  alias TorobBackend.Stores
  alias TorobBackend.Stores.Report

  action_fallback TorobBackendWeb.FallbackController

  plug :report_exists when action in [:edit, :update, :delete, :show]
  plug :check_user when action in [:update, :edit, :delete]
  plug :product_exists when action in [:create]
  plug :shop_exists when action in [:create]

  def report_exists(%{params: %{"id" => report_id}} = conn, _) do
    report_id = String.to_integer(report_id)
    report = Stores.get_report(report_id)
    if report == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this report is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def product_exists(%{params: %{"product_id" => product_id}} = conn, _) do
    product_id = String.to_integer(product_id)
    product = Stores.get_model(product_id)
    if product == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this product is not exists!"})
      |> halt()
    else
      conn
    end
  end


  def shop_exists(%{params: %{"shop_id" => shop_id}} = conn, _) do
    shop_id = String.to_integer(shop_id)
    shop = Stores.get_shop(shop_id)
    if shop == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "this shop is not exists!"})
      |> halt()
    else
      conn
    end
  end

  def check_user(%{params: %{"id" => report_id}} = conn, _) do
    report_id = String.to_integer(report_id)
    report = Stores.get_report!(report_id)
    if (report.user_id == load_current_user(conn).id) do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "you can not see this!"})
      |> halt()
    end
  end

  def load_current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end

  def index(conn, _params) do
    reports = Stores.list_reports()
    render(conn, "index.json", reports: reports)
  end

  def create(conn, %{"report" => report_params}) do
    with {:ok, %Report{} = report} <- Stores.create_report(report_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.report_path(conn, :show, report))
      |> render("show.json", report: report)
    end
  end

  def show(conn, %{"id" => id}) do
    report = Stores.get_report!(id)
    render(conn, "show.json", report: report)
  end

  def update(conn, %{"id" => id, "report" => report_params}) do
    report = Stores.get_report!(id)

    with {:ok, %Report{} = report} <- Stores.update_report(report, report_params) do
      render(conn, "show.json", report: report)
    end
  end

  def delete(conn, %{"id" => id}) do
    report = Stores.get_report!(id)

    with {:ok, %Report{}} <- Stores.delete_report(report) do
      send_resp(conn, :no_content, "")
    end
  end
end
