defmodule Validatex.LengthTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V
  alias Validatex.Length, as: L
  alias Validatex.Range, as: Range

  test :comparison do
    tests = [{'a', [{1, true},{2, :lesser}, {0, :greater}, {Range.new(from: 0, to: 2), true}]},
             {"a", [{1, true},{2, :lesser}, {0, :greater}, {Range.new(from: 0, to: 2), true}]},
             {{:a}, [{1, true},{2, :lesser}, {0, :greater}], {Range.new(from: 0, to: 2), true}},
             {1, [{1, :bad_argument}, {2, :bad_argument}, {Range.new(from: 0, to: 2), :bad_argument}]},
             {:atom, [{1, :bad_argument}, {2, :bad_argument}, {Range.new(from: 0, to: 2), :bad_argument}]},
      ]
    lc {data, cases} inlist tests, {is, outcome} inlist cases do
      assert V.valid?(L.new(is: is), data) == outcome
    end
  end

end
