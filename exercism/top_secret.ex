defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({fun_def, _, [{:when, _, [{fun_name, _, _ = arg_list}, _]}, _]} = ast, acc) when fun_def in [:def, :defp] do
    decode_fun(ast, arg_list, fun_name, acc)
  end

  def decode_secret_message_part({fun_def, _, [{fun_name, _, _ = arg_list}, _]} = ast, acc) when fun_def in [:def, :defp] do
    decode_fun(ast, arg_list, fun_name, acc)
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> search()
    |> Enum.reduce([], fn ast, acc ->
      {_ast, acc} = decode_secret_message_part(ast, acc)
      acc
    end)
    |> Enum.join("")
  end

  defp search(ast) do
    {_ast, acc} = Macro.prewalk(ast, [], fn
      {:def, _, _} = definition, acc -> {definition, [definition | acc]}
      {:defp, _, _} = definition, acc -> {definition, [definition | acc]}
      other, acc -> {other, acc}
    end)
    acc
  end

  defp decode_fun(ast, arg_list, fun_name, acc) do
    arg_list_size = if is_nil(arg_list), do: 0, else: Enum.count(arg_list)

    fun_name = fun_name
      |> Atom.to_string()
      |> String.slice(0, arg_list_size)

    {ast, [fun_name] ++ acc}
  end
end
