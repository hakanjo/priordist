#' Approximate solution of f(x) = 0 by Newton's method.
#'
#' Pick a distribution based on a list of constraints.
#'
#' @param f Function for which we are searching for a solution f(x) = 0.
#' @param Df Derivative of f(x).
#' @param guess Initial guess for a solution f(x) = 0.
#' @param epsilon Stopping criteria is abs(f(x)) < epsilon.
#' @param max_iter Maximum number of iterations of Newton's method.
#' @return If abs(f(xn)) < epsilon, returns xn or if Df(xn) == 0 or the number of iterations exceeds max_iter, returns NA.
#' @keywords internal
#'
newton <- function(f, Df, guess, epsilon = 1e-8, max_iter = 1000) {
  xn <- guess
  for (n in 0:max_iter) {
    # fxn = f(xn)
    fxn <- f(xn)
    if (is.nan(fxn)) {
      warning("NaNs produced")
      return(NA)
    }
    if (abs(fxn) < epsilon) {
      return(xn)
    }
    # Dfxn = Df(xn)
    Dfxn <- Df(xn)
    if (Dfxn == 0) {
      warning("f'(x) == 0")
      return(NA)
    }
    xn <- xn - fxn / Dfxn
  }
  warning("Maximum number of iterations exceeded")
  return(NA)
}
