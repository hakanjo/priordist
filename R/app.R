#' Launch priordist
#'
#' Run the priordist application.
#'
#' @export
#'
launch_priordist <- function() {
  shiny::shinyApp(ui = ui, server = server)
}
