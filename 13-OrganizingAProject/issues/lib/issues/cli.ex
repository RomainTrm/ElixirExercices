defmodule Issues.CLI do

  @default_count 4

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
      OptionParser.parse(argv, switches: [help: :boolean],
                               aliases: [h: :help])
      |> elem(1)
      |> args_to_internal_representation
  end

  defp args_to_internal_representation([user, project, count]) do
    { user, project, String.to_integer(count) }
  end

  defp args_to_internal_representation([user, project]) do
    { user, project, @default_count }
  end

  defp args_to_internal_representation(_), do: :help

  def process(:help) do
    IO.puts("""
    usage: issues <user> <project> [count | #{@default_count}]
    """)
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> sort_into_descending_order
    |> last(count)
    |> Issues.TableFormatter.print_table(["number", "created_at", "title"])
  end

  defp decode_response({:ok, body}), do: body
  defp decode_response({:error, error}) do
    IO.puts "Error fetching from Github: #{error["message"]}"
    System.halt(2)
  end

  def sort_into_descending_order(issues) do
    issues
    |> Enum.sort(fn l, r -> l["created_at"] >= r["created_at"] end)
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse
  end
end
