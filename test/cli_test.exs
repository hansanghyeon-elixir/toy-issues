defmodule CliTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!
  doctest ToyIssues

  import ToyIssues.CLI, only: [parse_args: 1, sort_into_descending_order: 1, format_table: 1]

  test "`-h`나 `--help`를 받으면 :help를 반환한다" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "값을 3개 전달하면 값 3개가 반환된다." do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "값을 2개 전달하면 개수에 기본값을 사용한다." do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "내림차순 정렬이 잘 수행된다." do
    result = sort_into_descending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{ c b a }
  end

  @github_issues_mock [
    %{
      "active_lock_reason" => nil,
      "assignee" => nil,
      "assignees" => [],
      "author_association" => "CONTRIBUTOR",
      "body" => nil,
      "closed_at" => nil,
      "closed_by" => nil,
      "comments" => 0,
      "comments_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/4/comments",
      "created_at" => "2024-11-15T10:58:07Z",
      "events_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/4/events",
      "html_url" => "https://github.com/hansanghyeon-elixir/toy-issues/issues/4",
      "id" => 2_661_634_342,
      "labels" => [],
      "labels_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/4/labels{/name}",
      "locked" => false,
      "milestone" => nil,
      "node_id" => "I_kwDONPDC-c6epVEm",
      "number" => 4,
      "performed_via_github_app" => nil,
      "reactions" => %{
        "+1" => 0,
        "-1" => 0,
        "confused" => 0,
        "eyes" => 0,
        "heart" => 0,
        "hooray" => 0,
        "laugh" => 0,
        "rocket" => 0,
        "total_count" => 0,
        "url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/4/reactions"
      },
      "repository_url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues",
      "state" => "open",
      "state_reason" => nil,
      "timeline_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/4/timeline",
      "title" => "fp!! awesome!",
      "updated_at" => "2024-11-15T10:58:07Z",
      "url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/4",
      "user" => %{
        "avatar_url" => "https://avatars.githubusercontent.com/u/42893446?v=4",
        "events_url" => "https://api.github.com/users/Hansanghyeon/events{/privacy}",
        "followers_url" => "https://api.github.com/users/Hansanghyeon/followers",
        "following_url" => "https://api.github.com/users/Hansanghyeon/following{/other_user}",
        "gists_url" => "https://api.github.com/users/Hansanghyeon/gists{/gist_id}",
        "gravatar_id" => "",
        "html_url" => "https://github.com/Hansanghyeon",
        "id" => 42_893_446,
        "login" => "Hansanghyeon",
        "node_id" => "MDQ6VXNlcjQyODkzNDQ2",
        "organizations_url" => "https://api.github.com/users/Hansanghyeon/orgs",
        "received_events_url" => "https://api.github.com/users/Hansanghyeon/received_events",
        "repos_url" => "https://api.github.com/users/Hansanghyeon/repos",
        "site_admin" => false,
        "starred_url" => "https://api.github.com/users/Hansanghyeon/starred{/owner}{/repo}",
        "subscriptions_url" => "https://api.github.com/users/Hansanghyeon/subscriptions",
        "type" => "User",
        "url" => "https://api.github.com/users/Hansanghyeon",
        "user_view_type" => "public"
      }
    },
    %{
      "active_lock_reason" => nil,
      "assignee" => nil,
      "assignees" => [],
      "author_association" => "CONTRIBUTOR",
      "body" => nil,
      "closed_at" => nil,
      "closed_by" => nil,
      "comments" => 0,
      "comments_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/comments",
      "created_at" => "2024-11-15T10:58:18Z",
      "events_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/events",
      "html_url" => "https://github.com/hansanghyeon-elixir/toy-issues/issues/5",
      "id" => 2_661_634_859,
      "labels" => [],
      "labels_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/labels{/name}",
      "locked" => false,
      "milestone" => nil,
      "node_id" => "I_kwDONPDC-c6epVMr",
      "number" => 5,
      "performed_via_github_app" => nil,
      "reactions" => %{
        "+1" => 0,
        "-1" => 0,
        "confused" => 0,
        "eyes" => 0,
        "heart" => 0,
        "hooray" => 0,
        "laugh" => 0,
        "rocket" => 0,
        "total_count" => 0,
        "url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/reactions"
      },
      "repository_url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues",
      "state" => "open",
      "state_reason" => nil,
      "timeline_url" =>
        "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/timeline",
      "title" => "동시성처리 미쳤다",
      "updated_at" => "2024-11-15T10:58:18Z",
      "url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5",
      "user" => %{
        "avatar_url" => "https://avatars.githubusercontent.com/u/42893446?v=4",
        "events_url" => "https://api.github.com/users/Hansanghyeon/events{/privacy}",
        "followers_url" => "https://api.github.com/users/Hansanghyeon/followers",
        "following_url" => "https://api.github.com/users/Hansanghyeon/following{/other_user}",
        "gists_url" => "https://api.github.com/users/Hansanghyeon/gists{/gist_id}",
        "gravatar_id" => "",
        "html_url" => "https://github.com/Hansanghyeon",
        "id" => 42_893_446,
        "login" => "Hansanghyeon",
        "node_id" => "MDQ6VXNlcjQyODkzNDQ2",
        "organizations_url" => "https://api.github.com/users/Hansanghyeon/orgs",
        "received_events_url" => "https://api.github.com/users/Hansanghyeon/received_events",
        "repos_url" => "https://api.github.com/users/Hansanghyeon/repos",
        "site_admin" => false,
        "starred_url" => "https://api.github.com/users/Hansanghyeon/starred{/owner}{/repo}",
        "subscriptions_url" => "https://api.github.com/users/Hansanghyeon/subscriptions",
        "type" => "User",
        "url" => "https://api.github.com/users/Hansanghyeon",
        "user_view_type" => "public"
      }
    }
  ]

  test "최근 1개의 이슈 표시" do
    ToyIssues.GithubIssuesMock
    |> expect(:fetch, fn _user, _project ->
      {:ok, @github_issues_mock}
    end)

    argv = ["user", "prject", "1"]
    result = ToyIssues.CLI.run(argv, ToyIssues.GithubIssuesMock)

    assert result == [
             %{
               "active_lock_reason" => nil,
               "assignee" => nil,
               "assignees" => [],
               "author_association" => "CONTRIBUTOR",
               "body" => nil,
               "closed_at" => nil,
               "closed_by" => nil,
               "comments" => 0,
               "comments_url" =>
                 "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/comments",
               "created_at" => "2024-11-15T10:58:18Z",
               "events_url" =>
                 "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/events",
               "html_url" => "https://github.com/hansanghyeon-elixir/toy-issues/issues/5",
               "id" => 2_661_634_859,
               "labels" => [],
               "labels_url" =>
                 "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/labels{/name}",
               "locked" => false,
               "milestone" => nil,
               "node_id" => "I_kwDONPDC-c6epVMr",
               "number" => 5,
               "performed_via_github_app" => nil,
               "reactions" => %{
                 "+1" => 0,
                 "-1" => 0,
                 "confused" => 0,
                 "eyes" => 0,
                 "heart" => 0,
                 "hooray" => 0,
                 "laugh" => 0,
                 "rocket" => 0,
                 "total_count" => 0,
                 "url" =>
                   "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/reactions"
               },
               "repository_url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues",
               "state" => "open",
               "state_reason" => nil,
               "timeline_url" =>
                 "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5/timeline",
               "title" => "동시성처리 미쳤다",
               "updated_at" => "2024-11-15T10:58:18Z",
               "url" => "https://api.github.com/repos/hansanghyeon-elixir/toy-issues/issues/5",
               "user" => %{
                 "avatar_url" => "https://avatars.githubusercontent.com/u/42893446?v=4",
                 "events_url" => "https://api.github.com/users/Hansanghyeon/events{/privacy}",
                 "followers_url" => "https://api.github.com/users/Hansanghyeon/followers",
                 "following_url" =>
                   "https://api.github.com/users/Hansanghyeon/following{/other_user}",
                 "gists_url" => "https://api.github.com/users/Hansanghyeon/gists{/gist_id}",
                 "gravatar_id" => "",
                 "html_url" => "https://github.com/Hansanghyeon",
                 "id" => 42_893_446,
                 "login" => "Hansanghyeon",
                 "node_id" => "MDQ6VXNlcjQyODkzNDQ2",
                 "organizations_url" => "https://api.github.com/users/Hansanghyeon/orgs",
                 "received_events_url" =>
                   "https://api.github.com/users/Hansanghyeon/received_events",
                 "repos_url" => "https://api.github.com/users/Hansanghyeon/repos",
                 "site_admin" => false,
                 "starred_url" =>
                   "https://api.github.com/users/Hansanghyeon/starred{/owner}{/repo}",
                 "subscriptions_url" => "https://api.github.com/users/Hansanghyeon/subscriptions",
                 "type" => "User",
                 "url" => "https://api.github.com/users/Hansanghyeon",
                 "user_view_type" => "public"
               }
             }
           ]
  end

  test "테이블 포맷팅" do
    assert @github_issues_mock |> format_table === """
           #   | create_at            | title
           ----+----------------------+---------------------------------
           4   | 2024-11-15T10:58:07Z | fp!! awesome!
           5   | 2024-11-15T10:58:18Z | 동시성처리 미쳤다
           """
  end

  defp fake_created_at_list(values) do
    for value <- values do
      %{"created_at" => value, "other_data" => "xxx"}
    end
  end
end
