test_that("Trivial function", {
  solution <- newton(
    f = function(x) { x**2 - x - 1 },
    guess = list(x = 1), iter = 100
  )
  expect_equal(solution, list(x = 1.618033988749989))
})

test_that("Divergent function", {
  solution <- function() newton(
    f = function(x) { x**(1/3) },
    guess = list(x = 1), iter = 100
  )
  expect_error(solution(), "newton: NaNs produced")
})

test_that("Multivariate function", {
  solution <- newton(
    f = function(x, y) { list(x = 3*y - 9, y = 3 - 3*x) },
    guess = list(x = 2, y = 2), iter = 100
  )
  expect_equal(solution, list(x = 1, y = 3))
})

test_that("Probability function", {
  solution <- newton(
    f = function(mu, sigma) {
      list(
        pnorm(2, mu, sigma) - 0.025,
        pnorm(8, mu, sigma) - 0.975
      )
    },
    guess = list(mu = 4, sigma = 2), iter = 1000
  )
  expect_equal(solution$mu, 5)
  expect_equal(solution$sigma, 1.530, tolerance = 0.001)
})

