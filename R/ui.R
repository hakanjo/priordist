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
      # What type of distribution?
      selectInput(
        inputId = "dist_type", label = "Distribution category",
        choices = list(
          "Univariate" = list(
            "Discrete" = "univariate_discrete"
            # "Continuous" = "univariate_continuous"
          )
          # "Multivariate" = list(
          #   "Continuous" = "multivariate_continuous"
          # )
        ),
        selected = "univariate_discrete"
      ),
      # What distribution?
      conditionalPanel(
        condition = "input.dist_type == 'univariate_discrete'",
        selectInput(
          inputId = "dist", label = "Distribution",
          choices = list(
            "Poisson" = "poisson"
          ),
          selected = "poisson"
        )
      ),
      # What are the constraints?
      selectInput(
        inputId = "constraints", label = "Constraints",
        choices = list(
          "Mean" = "mean",
          "Pr(x \U2264 X)" = "leq"
        ),
        selected = "mean"
      ),
      conditionalPanel(
        condition = "input.constraints.includes('mean')",
        numericInput(
          inputId = "mean", label = "Mean", value = 5
        )
      ),
      conditionalPanel(
        condition = "input.constraints.includes('leq')",
        numericInput(
          inputId = "X", label = "X", value = 5
        ),
        sliderInput(
          inputId = "pr_leq", label = "Pr(x \U2264 X)", min = 0, max = 1,
          step = 0.005, value = 0.975
        )
      ),
      # Plot settings
      numericInput(inputId = "xseq_min", label = "x-axis minimum", value = 0),
      numericInput(inputId = "xseq_max", label = "x-axis maximum", value = 10),
      # Newton solver options
      numericInput(inputId = "guess", label = "Guess", value = 1),
      helpText("Initial guess for a solution to f(x) = 0."),
      numericInput(inputId = "epsilon", label = "\U03B5", value = 1e-8, step = 0.01),
      helpText("Stopping criteria is abs(f(x)) < \U03B5."),
      numericInput(
        inputId = "max_iter", label = "Maximum number of iterations", min = 1,
        value = 1000
      )
    ),
    mainPanel(
      div(htmlOutput(outputId = "dist_description"), style = "font-size:150%"),
      plotOutput(outputId = "dist_plot", height = "300px"),
      textOutput("tmp")
    )
  )
)
