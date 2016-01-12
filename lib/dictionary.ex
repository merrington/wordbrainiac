defmodule Wordbrainiac.Dictionary do
  def get_dict_trie(dictionary) do
    dict_file = File.stream!(dictionary, [:read], :line)
    Enum.reduce(dict_file, :trie.new, fn word, dict_trie ->
      :trie.store(to_char_list(String.downcase(String.strip(word))), dict_trie)
    end)
  end

  def check_words(word_list, dict_trie) do
    Enum.filter(word_list, fn %{:path => path, :word => word} ->
      if String.length(word) > 0 do
        case :trie.find(String.to_char_list(word), dict_trie) do
          {:ok, _} -> true
          _ -> false
        end
      end
    end)
  end
end
