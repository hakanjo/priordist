test_that("Trivial function", {
  solution <- newton(
    f = function(x) { x**2 - x - 1 },
    Df = function(x) { 2*x - 1 },
    guess = 1, epsilon = 1e-8, max_iter = 100
  )
  expect_equal(solution, 1.618033988749989)
})

test_that("Divergent function", {
  solution <- newton(
    f = function(x) { x**(1/3) },
    Df = function(x) { (1/3) * x**(-2/3) },
    guess = 1, epsilon = 1e-8, max_iter = 100
  )
  expect_equal(solution, NA)
})
