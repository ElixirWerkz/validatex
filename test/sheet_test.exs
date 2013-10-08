defmodule Validatex.SheetTest do
  use ExUnit.Case
  alias Validatex, as: V

  test :no_errors do
    plan = [{"age", "30", V.Numericality.new(allow_string: true)}]
    assert V.validate(plan) == []
  end

  test :no_errors_bang do
    plan = [{"age", "30", V.Numericality.new(allow_string: true)}]
    assert V.validate!(plan) == true
  end

  test :errors do
    plan = [{"age", "30", V.Numericality.new(allow_string: false)},
            {"age", 30, V.Range.new(to: 18)}
           ]
    assert length(V.validate(plan)) == 2
  end

  test :errors_bang do
    plan = [{"age", "30", V.Numericality.new(allow_string: false)},
            {"age", 30, V.Range.new(to: 18)}
           ]
    assert_raise Validatex.ValidationFailure, "Validation error on age, \"30\" does not pass the validation " <>
                                              "of #{inspect V.Numericality.new(allow_string: false)} with a reason of :string_not_allowed", fn ->
      V.validate!(plan)
    end
    assert_raise Validatex.MultipleValidationFailures,
        "Validation error on age, \"30\" does not pass the validation " <>
        "of #{inspect V.Numericality.new(allow_string: false)} with a reason of :string_not_allowed\n" <>
        "Validation error on age, 30 does not pass the validation " <>
        "of #{inspect V.Range.new(to: 18)} with a reason of :greater", fn ->
      V.validate!(plan, report_all_errors: true)
    end

  end

end
