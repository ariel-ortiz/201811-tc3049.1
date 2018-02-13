#==========================================================
# Type your student ID and name here
#==========================================================

require 'minitest/autorun'
require 'mathn'
require 'observer'

#==========================================================
# Problem 1
#----------------------------------------------------------
# Apply the "Replace Loop with Collection Closure Method"
# refactoring to the following code.
#----------------------------------------------------------
def prime_products(n)
  i = 2
  product = 1
  while i < n
    product *= i if i.prime?
    i += 1
  end
  product
end

#----------------------------------------------------------
# Unit test.
#----------------------------------------------------------
class PrimeProductsTest < Minitest::Test
  def test_prime_products
    assert_equal 1, prime_products(2)
    assert_equal 2, prime_products(3)
    assert_equal 6, prime_products(5)
    assert_equal 210, prime_products(10)
    assert_equal 2305567963945518424753102147331756070,
      prime_products(100)
  end
end

#==========================================================
# Problem 2
#----------------------------------------------------------
# Place here your code for the RandomNumberGenerator
# class.
#----------------------------------------------------------



#----------------------------------------------------------
# Unit test.
#----------------------------------------------------------
class RandomNumberGeneratorTest < Minitest::Test
  def test_iterator_pattern
    alpha = RandomNumberGenerator.new(:alpha, 100001, 1, 10)
    beta = RandomNumberGenerator.new(:beta, 666, 20, 1000)
    rng = alpha.to_enum
    assert_equal 4, rng.peek
    [4, 2, 9, 1, 1].each do |x|
      assert_equal x, rng.next
    end
    rng.rewind
    [4, 2, 9, 1, 1, 4, 9, 2, 5, 8, 9, 6].each do |x|
      assert_equal x, rng.next
    end

    rng = beta.to_enum
    assert_equal 866, rng.peek
    [866, 725, 458, 191, 999].each do |x|
      assert_equal x, rng.next
    end
    rng.rewind
    [866, 725, 458, 191, 999, 492, 332, 387, 223, 730,
     931, 259, 830, 403, 938, 87, 867, 353, 488, 58,
     616, 140, 387, 186, 177, 591, 808, 391, 563, 879,
     76, 165, 425, 31, 225, 935, 258, 81, 154, 466, 382,
     189, 207, 130, 877, 39, 995, 813, 790, 460, 84, 775,
     26, 905, 264, 778, 918, 567, 476, 130, 208, 505,
     385, 798, 598, 49, 320, 418, 970, 126, 488, 817,
     958, 543, 817, 149, 506, 465, 688, 939, 828, 777,
     916, 190, 566, 195, 785, 192, 972, 926, 746, 600,
     948, 976, 113, 427, 794, 726, 940, 530].each do |x|
      assert_equal x, rng.next
    end
  end
end

#==========================================================
# Problem 3
#----------------------------------------------------------
# Place here your code for the RandomObserver class.
#----------------------------------------------------------



#----------------------------------------------------------
# Unit test.
#----------------------------------------------------------
class RandomObserverTest < Minitest::Test

  def setup
    @out = StringIO.new
    @old_stdout = $stdout
    $stdout = @out

  end

  def teardown
    $stdout = @old_stdout
  end

  def test_observer_pattern
    alpha = RandomNumberGenerator.new(:alpha, 100001, 1, 10)
    beta = RandomNumberGenerator.new(:beta, 666, 20, 1000)
    gamma = RandomNumberGenerator.new(:gamma, 1000000241, 1, 100)

    a = RandomObserver.new(:a)
    b = RandomObserver.new(:b)
    c = RandomObserver.new(:c)

    alpha.add_observer(a)
    alpha.add_observer(c)
    beta.add_observer(b)
    gamma.add_observer(c)
    gamma.add_observer(b)
    gamma.add_observer(a)

    rng_alpha = alpha.to_enum
    rng_beta = beta.to_enum
    rng_gamma = gamma.to_enum

    rng_alpha.next
    rng_alpha.next
    rng_beta.next
    rng_gamma.take(20)
    rng_alpha.next

    assert_equal \
      "a received 4 from alpha\n" \
      "c received 4 from alpha\n" \
      "a received 2 from alpha\n" \
      "c received 2 from alpha\n" \
      "b received 866 from beta\n" \
      "c received 17 from gamma\n" \
      "b received 17 from gamma\n" \
      "a received 17 from gamma\n" \
      "c received 18 from gamma\n" \
      "b received 18 from gamma\n" \
      "a received 18 from gamma\n" \
      "c received 78 from gamma\n" \
      "b received 78 from gamma\n" \
      "a received 78 from gamma\n" \
      "c received 17 from gamma\n" \
      "b received 17 from gamma\n" \
      "a received 17 from gamma\n" \
      "c received 53 from gamma\n" \
      "b received 53 from gamma\n" \
      "a received 53 from gamma\n" \
      "c received 83 from gamma\n" \
      "b received 83 from gamma\n" \
      "a received 83 from gamma\n" \
      "c received 13 from gamma\n" \
      "b received 13 from gamma\n" \
      "a received 13 from gamma\n" \
      "c received 98 from gamma\n" \
      "b received 98 from gamma\n" \
      "a received 98 from gamma\n" \
      "c received 16 from gamma\n" \
      "b received 16 from gamma\n" \
      "a received 16 from gamma\n" \
      "c received 46 from gamma\n" \
      "b received 46 from gamma\n" \
      "a received 46 from gamma\n" \
      "c received 47 from gamma\n" \
      "b received 47 from gamma\n" \
      "a received 47 from gamma\n" \
      "c received 95 from gamma\n" \
      "b received 95 from gamma\n" \
      "a received 95 from gamma\n" \
      "c received 9 from gamma\n" \
      "b received 9 from gamma\n" \
      "a received 9 from gamma\n" \
      "c received 43 from gamma\n" \
      "b received 43 from gamma\n" \
      "a received 43 from gamma\n" \
      "c received 3 from gamma\n" \
      "b received 3 from gamma\n" \
      "a received 3 from gamma\n" \
      "c received 25 from gamma\n" \
      "b received 25 from gamma\n" \
      "a received 25 from gamma\n" \
      "c received 89 from gamma\n" \
      "b received 89 from gamma\n" \
      "a received 89 from gamma\n" \
      "c received 63 from gamma\n" \
      "b received 63 from gamma\n" \
      "a received 63 from gamma\n" \
      "c received 46 from gamma\n" \
      "b received 46 from gamma\n" \
      "a received 46 from gamma\n" \
      "c received 71 from gamma\n" \
      "b received 71 from gamma\n" \
      "a received 71 from gamma\n" \
      "a received 9 from alpha\n" \
      "c received 9 from alpha\n", \
      @out.string
  end
end