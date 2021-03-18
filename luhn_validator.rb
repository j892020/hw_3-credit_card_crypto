# frozen_string_literal: true

# Module used for mixin
module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)

    # TODO: use the integers in nums_a to validate its last check digit
    check_digit = nums_a.pop

    sum_of_sum_digits = get_sum_of_sum_digits(nums_a)

    # Check if the check_digit is valid
    (sum_of_sum_digits * 9 % 10) == check_digit
  end

  def get_sum_of_sum_digits(nums_a)
    # Reverse the array for convenience
    nums_double_other_digit_reversed = nums_a.reverse.map.with_index(1) do |num, idx|
      # Double every other element from the right more digit
      idx.odd? ? num * 2 : num
    end

    # Reverse back and calculate the sum digit
    nums_sum_digit = nums_double_other_digit_reversed.reverse.map do |num|
      num > 9 ? (num - 9) : num
    end

    nums_sum_digit.sum
  end
end
