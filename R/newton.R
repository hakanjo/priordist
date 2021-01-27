#' Approximate solution of f(x) = 0 by Newton's method.
#'
#' Pick a distribution based on a list of constraints.
#'
#' @param f Function for which we are searching for a solution f(x) = 0.
#' @param guess Initial guess for a solution f(x) = 0.
#' @param iter Iterations.
#' @return The estimated root of the equations.
#' @keywords internal
#'
newton <- function(f, guess, iter = 1000) {
  N <- length(guess)
  xn <- guess

  for (n in 1:iter) {
    fxn <- do.call(f, xn)

    if (any(is.na(fxn))) {
      stop("newton: NaNs produced")
    }

    jacobian <- matrix(0, nrow = N, ncol = N)
    delta <- pmax(abs(unlist(xn)) * 1e-8, 1e-8)

    for (j in 1:N) {
      d <- rep(0, N)
      d[j] <- delta[j]
      xnp1 <- Map("+", xn, d)
      fxnp1 <- do.call(f, xnp1)
      jacobian[, j] <- unlist(Map("/", Map("-", fxnp1, fxn), delta[j]))
    }

    relchange <- solve(jacobian, -1 * unlist(fxn))
    xn <- Map("+", xn, relchange)
  }

  return(xn)
}
