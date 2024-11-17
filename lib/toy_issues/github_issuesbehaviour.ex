defmodule ToyIssues.GithubIssuesBehaviour do
  @callback fetch(String.t(), String.t()) :: {:ok, any()} | {:error, any()}
end
