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
pick_parameters <- function(distribution, constraints, guess, epsilon, max_iter) {
  if (distribution == "poisson") {
    if (exists("mean", where = constraints)) {
      lambda <- constraints$mean
      return(Poisson(parameters = list(lambda = lambda)))
    } else if (exists("pr_leq", where = constraints)) {
      p <- constraints$pr_leq
      X <- constraints$X
      lambda <- newton(
        f = function(lambda) { ppois(X, lambda) - p},
        Df = function(lambda) { dpois(X, lambda) - p},
        guess, epsilon, max_iter
      )
      return(Poisson(parameters = list(lambda = lambda)))
    } else {
      stop("Invalid constraints for a Poisson distribution.")
    }
  } else {
    stop("Invalid distribution.")
  }
}
