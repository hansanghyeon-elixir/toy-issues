defmodule ToyIssues.CLI do
  import ToyIssues.TableFormatter, only: [print_table_for_columns: 2]

  @default_count 4
  @moduledoc """
  명령줄 파싱을 수행한 뒤, 각종 함수를 호출해
  깃허브 프로젝트의 최근 _n_개 이슈를 표 형식으로 만들어 출력한다.
  """
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  'argv'는 -h 또는 --help(이 경우 :help를 반환)이거나,
  깃허브 사용자 이름, 프로젝트 이름, (선택적으로) 가져올 이슈 개수여야 한다.

  '{사용자명, 프로젝트명, 이슈 개수}'또는 :help를 반환한다.
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal_representation([user, project]) do
    {user, project, @default_count}
  end

  # 잘못된 인자 또는 --help
  def args_to_internal_representation(_) do
    :help
  end

  def process(:help) do
    IO.puts("""
    usage: issues <user> <project> [count | #{@default_count}]
    """)

    System.halt(0)
  end

  def process({user, project, count}) do
    ToyIssues.GithubIssues.fetch(user, project)
    |> decode_response
    |> sort_into_descending_order
    |> last(count)
    |> print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:erro, error}) do
    IO.puts("Error fetching for Github: #{error["message"]}")

    _c = """
    System.halt(2)은 현재 실행 중인 프로세스를
    종료하면서 종료 코드를 2로 지정하는 명령어입니다.
    일반적으로 이 종료 코드는 운영 체제에게 프로그램이
    비정상적으로 종료되었음을 나타내는 데 사용됩니다.

    - `System.halt()` 함수는 인수를 전달하지 않으면
      기본적으로 0으로 종료하며, 이는 성공적으로 종료되었음을
      의미합니다.
    - 특정 오류 또는 실패 상태를 알리기 위해
      `System.halt(2)` 와 같이 0이 아닌 종료 코드를
      사용할 수 있습니다.

    종료 코드 2는 특정한 규약에 따라 사용자가 설정할 수 있는
    값이므로, 이 코드를 통해 다른 프로세스나 스크립트에서
    프로그램이 비정상 종료되었음을 감지할 수 있습니다.
    """

    System.halt(2)
  end

  def sort_into_descending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 ->
      i1["created_at"] >= i2["created_at"]
    end)
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end
end
