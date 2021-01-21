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
      # What type of data?
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
      # What values can the data take?
      # selectInput(
      #   inputId = "support", label = "Support",
      #   choices = list(
      #     "Natural numbers (ℕ₀)" = "natural"
      #   ),
      #   selected = "natural"
      # ),

      # Which constraints do you want to use?
      checkboxGroupInput(
        inputId = "constraints", label = "Constraints",
        choices = list(
          "Pr(X < x)" = "lower",
          "Pr(X < x)" = "upper"
        ),
        selected = "upper"
      ),
      # What are the constraints?
      conditionalPanel(
        condition = "input.constraints.includes('lower')",
        numericInput(
          inputId = "lower_value", label = "Lower value", value = 0
        ),
      ),
      conditionalPanel(
        condition = "input.constraints.includes('lower')",
        sliderInput(
          inputId = "lower_prob", label = "Pr(X < lower value)",
          min = 0, max = 1, step = 0.005, value = 0.025
        )
      ),
      conditionalPanel(
        condition = "input.constraints.includes('upper')",
        numericInput(
          inputId = "upper_value", label = "Upper value", value = 10
        ),
      ),
      conditionalPanel(
        condition = "input.constraints.includes('upper')",
        sliderInput(
          inputId = "upper_prob", label = "Pr(X < upper value)",
          min = 0, max = 1, step = 0.005, value = 0.975
        )
      ),
      # conditionalPanel(
      #   condition = "input.constraints.includes('mode')",
      #   numericInput(inputId = "mode", label = "Mode", value = 10)
      # ),

      # Plot settings
      numericInput(inputId = "xseq_min", label = "Plot minimum x", value = 0),
      numericInput(inputId = "xseq_max", label = "Plot maximum x", value = 10)
    ),
    mainPanel(
      div(htmlOutput(outputId = "dist_description"), style = "font-size:150%"),
      plotOutput(outputId = "dist_plot", height = "300px"),
      textOutput("tmp")
    )
  )
)
