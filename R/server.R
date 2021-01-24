#' Server logic for priordist
#'
#' Define the priordist server logic.
#'
#' @param input Provided by shiny.
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

  constraints <- reactive({
    if (input$constraints == "mean") {
      constraints <- list(
        mean = input$mean
      )
      return(constraints)
    } else if (input$constraints == "leq") {
      constraints <- list(
        X = input$X,
        pr_leq = input$pr_leq
      )
      return(constraints)
    } else {
      stop("No valid constraint selected.")
    }
  })

  distribution <- reactive({
    pick_parameters(
      distribution = input$dist, constraints = constraints(), input$guess,
      input$epsilon, input$max_iter
    )
  })

  output$dist_description <- renderUI({
    withMathJax(HTML(distribution()$summarise()))
  })

  output$dist_plot <- renderPlot({
    distribution()$plot(input$xseq_min, input$xseq_max)
  })
}
