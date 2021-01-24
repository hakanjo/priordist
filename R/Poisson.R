#' Constraint-based Poisson distribution
#'
#' Find suitable parameters for a Poisson distributions given constraints.
#'
#' @param constraints List of constraints.
#' @return Parameters for a Poisson distribution.
#' @import tidyr
#' @import ggplot2
#' @keywords internal
#'
Poisson <- setRefClass(
  "Poisson",
  fields = list(
    parameters = "list"
  ),
  methods = list(
    summarise = function() {
      summary <- paste0(
        "$$
          \\begin{align*}
            x &\\sim \\text{Poisson}(\\lambda) \\\\
            \\lambda &= ", parameters$lambda, "
          \\end{align*}
        $$"
      )
    },
    plot = function(min_x, max_x) {
      tibble(x = c(min_x:max_x)) %>%
        ggplot(aes(x = x, y = dpois(x, lambda = parameters$lambda))) +
        geom_col(fill = "#428bca") +
        scale_x_continuous(expand = expansion()) +
        scale_y_continuous(expand = expansion()) +
        labs(x = "k", y = expression("Pr("*italic(x)*" = k)"))
    },
    mean = function() {
      return(parameters$lambda)
    }
  )
)
