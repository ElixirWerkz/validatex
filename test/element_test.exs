defmodule Validatex.ElementTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V
  alias Validatex.Element, as: E

  test :element do
    assert V.valid?(E.new(list: [1,2,3]), 1) == true
    assert V.valid?(E.new(list: [1,2,3]), 0) == false
  end

end