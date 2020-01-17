defprotocol Caesar do
  def root13(string)
end

defmodule Caesar.Cypher do
  def encrypt(string, shift) do
    string |> Enum.map(&cypher(&1, shift)) |> to_string
  end

  defp cypher(letter, 0), do: letter
  defp cypher(?', n), do: cypher(?', n - 1)
  defp cypher(?z, n), do: cypher(?a, n - 1)
  defp cypher(letter, n), do: cypher(letter + 1, n - 1)
end

defimpl Caesar, for: BitString do
  def root13(string), do: string |> to_char_list |> Caesar.Cypher.encrypt(13)
end

defmodule Words do
  def find_root13_words_in_file do
    filepath = "words"
    root13 = get_root13(filepath)
    words = get_words(filepath)

    words
    |> Stream.filter(fn word -> Map.get(root13, word, nil) end)
    |> Enum.map(fn word -> "The word \"#{word}\" is the root13 of \"#{Map.get(root13, word)}\"" end)
  end

  defp get_root13(filepath) do
    filepath
    |> get_words
    |> Stream.map(fn word -> { Caesar.root13(word), word } end)
    |> Map.new
  end

  defp get_words(filepath) do
    File.stream!(filepath, [], :line)
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(&String.downcase/1)
  end
end

IO.inspect Words.find_root13_words_in_file()
