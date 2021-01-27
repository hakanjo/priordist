#' User interface for priordist
#'
#' Define the priordist user interface.
#'
#' @return A Shiny user-interface definition.
#' @import shiny
#' @importFrom graphics hist
#' @keywords internal
#'
ui <- fluidPage(
  titlePanel("priordist"),
  sidebarLayout(
    sidebarPanel(
      # Which distribution?
      selectInput(
        inputId = "dist", label = "Distribution category",
        choices = list(
          "Univariate discrete" = list(
            "Poisson" = "poisson"
          ),
          "Univariate continuous" = list(
            "Normal" = "normal"
          )
        ),
        selected = "poisson"
      ),
      # What are the constraints?
      selectInput(
        inputId = "constraints", label = "Constraints",
        choices = list(
          "Mean" = "mean",
          "Pr(x \U2264 X)" = "leq",
          "Pr(a \U2264 x \U2264 b)" = "a_x_b"
        ),
        selected = "mean"
      ),
      conditionalPanel(
        condition = "input.constraints == 'mean'",
        numericInput(
          inputId = "mean", label = "Mean", value = 5
        )
      ),
      conditionalPanel(
        condition = "input.constraints == 'leq'",
        numericInput(
          inputId = "X", label = "X", value = 5
        ),
        sliderInput(
          inputId = "pr_leq", label = "Pr(x \U2264 X)", min = 0, max = 1,
          step = 0.005, value = 0.975
        )
      ),
      conditionalPanel(
        condition = "input.constraints == 'a_x_b'",
        numericInput(
          inputId = "a", label = "a", value = 2
        ),
        sliderInput(
          inputId = "pr_leq_a", label = "Pr(x \U2264 a)", min = 0, max = 1,
          step = 0.005, value = 0.025
        ),
        numericInput(
          inputId = "b", label = "b", value = 8
        ),
        sliderInput(
          inputId = "pr_leq_b", label = "Pr(x \U2264 b)", min = 0, max = 1,
          step = 0.005, value = 0.975
        )
      ),
      # Newton solver options
      helpText("Initial parameter guesses for a solution to f(xn) = 0."),
      conditionalPanel(
        condition = "input.dist == 'poisson'",
        numericInput(inputId = "guess_lambda", label = "\U03BB", value = 1)
      ),
      conditionalPanel(
        condition = "input.dist == 'normal'",
        numericInput(inputId = "guess_mu", label = "\U03BC", value = 5),
        numericInput(inputId = "guess_sigma", label = "\U03C3", value = 1)
      ),
      numericInput(
        inputId = "iter", label = "Iterations", min = 1,
        value = 1000
      ),
      # Plot settings
      numericInput(inputId = "xseq_min", label = "x-axis minimum", value = 0),
      numericInput(inputId = "xseq_max", label = "x-axis maximum", value = 10),
    ),
    mainPanel(
      div(htmlOutput(outputId = "dist_description"), style = "font-size:150%"),
      plotOutput(outputId = "dist_plot", height = "300px"),
      textOutput("tmp")
    )
  )
)
