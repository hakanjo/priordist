test_that("Poisson with mean constraint", {
  poisson <- pick_parameters("poisson", list(mean = 5), list(lambda = 1))
  expect_equal(poisson$mean(), 5)
})

test_that("Poisson with leq constraint", {
  poisson <- pick_parameters("poisson", list(X = 5, pr_leq = 0.975), list(lambda = 1))
  expect_equal(poisson$mean(), 2.201894, tolerance = 0.000001)
})

test_that("Normal with Pr(a \U2264 x \U2264 b)constraint", {
  normal <- pick_parameters(
    "normal",
    list(a = 2, b = 8, pr_leq_a = 0.025, pr_leq_b = 0.975),
    list(mu = 4, sigma = 2)
  )
  expect_equal(normal$mean(), 5)
  expect_equal(normal$sd(), 1.530, tolerance = 0.001)
})

