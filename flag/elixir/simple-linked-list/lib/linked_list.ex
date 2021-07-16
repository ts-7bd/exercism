defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({}), do: 0
  def length({_head, tail}), do: 1 + LinkedList.length(tail)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(list), do: LinkedList.length(list) == 0

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: {:error, :empty_list}
  def peek({head, _}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: {:error, :empty_list}
  def tail({_, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: {:error, :empty_list}

  def pop(list) do
    {_, top} = LinkedList.peek(list)
    {_, tail} = LinkedList.tail(list)
    {:ok, top, tail}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(LinkedList.new(), &LinkedList.push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({}), do: []
  def to_list({head, tail}), do: [head] ++ to_list(tail)

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    {head, tail} = list

    LinkedList.new()
    |> LinkedList.push(head)
    |> reverse(tail)
  end

  def reverse(new, {}), do: new

  def reverse(new, list) do
    {head, tail} = list

    LinkedList.push(new, head)
    |> reverse(tail)
  end
end
