#' Plot theme
#'
#' ggplot2 theme for priordist.
#'
#' @import ggplot2
#' @keywords internal
#'
theme_set_priordist <- function() {
  theme_set(
    theme_linedraw(base_family = "Garamond", base_size = 24) +
      theme(
        plot.background = element_rect(fill = "transparent", color = NA),
        panel.background = element_rect(fill = "transparent"),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.line = element_line(size = 0.5),
        axis.text = element_text(family = "Roboto Mono", size = 16),
        legend.position = "none"
      )
  )
}

#' Remove x axis
#' ggplot2 theme settings to completely remove the x axis.
#'
#' @return ggplot2 theme.
#' @import ggplot2
#' @keywords internal
#'
remove_x_axis <- function() {
  theme(
    axis.title.x = element_blank(), axis.text.x = element_blank(),
    axis.line.x = element_blank(), axis.ticks.x = element_blank()
  )
}

#' Remove y axis
#' ggplot2 theme settings to completely remove the y axis.
#'
#' @return ggplot2 theme.
#' @import ggplot2
#' @keywords internal
#'
remove_y_axis <- function() {
  theme(
    axis.title.y = element_blank(), axis.text.y = element_blank(),
    axis.line.y = element_blank(), axis.ticks.y = element_blank()
  )
}
