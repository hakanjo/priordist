#' Pick parameters
#'
#' Pick paramters for a given distribution based on a list of constraints.
#'
#' @param constraints List of constraints.
#' @return A distribution object.
#' @import methods
#' @import stats
#' @keywords internal
#'
pick_parameters <- function(distribution, constraints, guess, iter = 1000) {
  if (distribution == "poisson") {
    if (exists("mean", where = constraints)) {
      lambda <- constraints$mean
      return(Poisson(parameters = list(lambda = lambda)))
    } else if (exists("pr_leq", where = constraints)) {
      X <- constraints$X
      p <- constraints$pr_leq
      lambda <- Map(
        "abs",
        newton(
          f = function(lambda) { ppois(X, abs(lambda)) - p}, guess, iter
        )
      )
      return(Poisson(parameters = lambda))
    } else {
      stop("Invalid constraints for a Poisson distribution.")
    }
  } else if (distribution == "normal") {
    if (exists("pr_leq_a", where = constraints)) {
      a <- constraints$a
      pr_leq_a <- constraints$pr_leq_a
      b <- constraints$b
      pr_leq_b <- constraints$pr_leq_b

      parameters <- newton(
        f = function(mu, sigma) {
          list(
            pnorm(a, mu, sigma) - pr_leq_a,
            pnorm(b, mu, sigma) - pr_leq_b
          )
        },
        guess, iter
      )

      return(Normal(parameters = parameters))
    } else {
      stop("Invalid constraints for a normal distribution.")
    }
  } else {
    stop("Invalid distribution.")
  }
}
