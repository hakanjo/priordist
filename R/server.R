#' Server logic for priordist
#'
#' Define the priordist server logic.
#'
#' @param input Provided by shiny.
#' @param output Provided by shiny.
#' @param session Provided by shiny.
#' @return Shiny server logic.
#' @import ggplot2
#' @import tidyr
#' @import shiny
#' @keywords internal
#'
server <- function(input, output, session) {
  theme_set_priordist()

  constraints <- reactive({
    if (input$constraints == "mean") {
      list(
        mean = input$mean
      )
    } else if (input$constraints == "leq") {
      list(
        X = input$X,
        pr_leq = input$pr_leq
      )
    } else if (input$constraints == "a_x_b") {
      list(
        a = input$a,
        b = input$b,
        pr_leq_a = input$pr_leq_a,
        pr_leq_b = input$pr_leq_b
      )
    } else {
      stop("No valid constraint selected.")
    }
  })

  guess <- reactive({
    if (input$dist == "poisson") {
      list(
        lambda = input$guess_lambda
      )
    } else if (input$dist == "normal") {
      list(
        mu = input$guess_mu,
        sigma = input$guess_sigma
      )
    }
  })

  distribution <- reactive({
    pick_parameters(
      distribution = input$dist, constraints = constraints(), guess = guess(),
      input$max_iter
    )
  })

  output$dist_description <- renderUI({
    withMathJax(HTML(distribution()$summarise()))
  })

  output$dist_plot <- renderPlot({
    distribution()$plot(input$xseq_min, input$xseq_max)
  })
}
