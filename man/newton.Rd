% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/newton.R
\name{newton}
\alias{newton}
\title{Approximate solution of f(x) = 0 by Newton's method.}
\usage{
newton(f, Df, guess, epsilon = 1e-08, max_iter = 1000)
}
\arguments{
\item{f}{Function for which we are searching for a solution f(x) = 0.}

\item{Df}{Derivative of f(x).}

\item{guess}{Initial guess for a solution f(x) = 0.}

\item{epsilon}{Stopping criteria is abs(f(x)) < epsilon.}

\item{max_iter}{Maximum number of iterations of Newton's method.}
}
\value{
If abs(f(xn)) < epsilon, returns xn or if Df(xn) == 0 or the number of iterations exceeds max_iter, returns NA.
}
\description{
Pick a distribution based on a list of constraints.
}
\keyword{internal}