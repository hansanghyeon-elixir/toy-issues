defmodule ToyIssues.GithubIssues do
  @user_agent [{"User-agent", "Elixir 999@hyeon.pro"}]
  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  # 컴파일 시점에 값을 가져오기 위해 모듈 속성을 사용한다.
  @github_url Application.get_env(:toy_issues, :github_url)
  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error,
      body |> Poison.Parser.parse!(%{})
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
