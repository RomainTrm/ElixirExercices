defmodule ControlFlow do
  def ok!(content) do
    case content do
      {:ok, data} -> data
      {:error, message} -> raise "Fail to open file: #{message}"
    end
  end
end
