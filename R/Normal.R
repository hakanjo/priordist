#' Constraint-based normal distribution
#'
#' A distribution class pairing a description in model syntax and a ggplot2 function.
#'
#' @import tidyr
#' @import ggplot2
#' @keywords internal
#'
Normal <- setRefClass(
  "Normal",
  fields = list(
    parameters = "list"
  ),
  methods = list(
    summarise = function() {
      summary <- paste0(
        "$$
          \\begin{align*}
            x &\\sim \\text{Normal}(\\mu, \\sigma) \\\\
            \\mu &= ", parameters$mu, " \\\\
            \\sigma &= ", parameters$sigma, "
          \\end{align*}
        $$"
      )
    },
    plot = function(min_x, max_x) {
        ggplot() +
        geom_function(fun = dnorm, args = list(mean = parameters$mu, sd = parameters$sigma)) +
        scale_x_continuous(limits = c(min_x, max_x), expand = expansion()) +
        scale_y_continuous(expand = expansion()) +
        labs(x = "x") +
        remove_y_axis() +
        theme(plot.margin = margin(l = 25, r = 25))
    },
    mean = function() {
      return(parameters$mu)
    },
    sd = function() {
      return(parameters$sigma)
    }
  )
)
