#' Server logic for priordist
#'
#' Define the priordist server logic.
#'
#' @param input provided by shiny.
#' @param output Provided by shiny.
#' @param session Provided by shiny.
#' @return Shiny server logic.
#' @import tidyr
#' @import ggplot2
#' @import shiny
#' @keywords internal
#'
server <- function(input, output, session) {
  theme_set_priordist()

  lambda <- reactive({ input$lower_bound })



  # Parse constraints
  # dist_type <- input$dist_type
  #
  # dist <- parse_constraints(
  #   dist_type = input$dist_type,
  #   bounds = list(lower = input$lower_bound, upper = input$upper_bound)
  #   constraints =
  # )

  # output$tmp <- renderPrint({
  #   "lower" %in% input$bounds
  #   "upper" %in% input$bounds
  #   # both
  # })


  output$dist_description <- renderUI({
    withMathJax(
      HTML(
        paste("<p>$$x \\sim \\text{Poisson}(\\lambda = ", lambda(), ")$$</p>")
      )
    )
  })

  output$dist_plot <- renderPlot({
    tibble(x = c(input$xseq_min:input$xseq_max)) %>%
      ggplot(aes(x = x, y = dpois(x, lambda = lambda()))) +
      geom_col(fill = "#428bca") +
      scale_x_continuous(expand = expansion()) +
      scale_y_continuous(expand = expansion()) +
      labs(x = "k", y = expression("Pr("*italic(x)*" = k)"))
  })
}
