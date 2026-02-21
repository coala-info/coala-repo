# Code example from 'shiny_dev' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.align = "center"
)

## ----eval = FALSE-------------------------------------------------------------
# library(ComplexHeatmap)
# library(InteractiveComplexHeatmap)
# library(shiny)
# 
# data(rand_mat) # simply a random matrix
# ht1 = Heatmap(rand_mat, name = "mat",
#     show_row_names = FALSE, show_column_names = FALSE)
# ht1 = draw(ht1)
# 
# ui = fluidPage(
#     h3("My first interactive ComplexHeatmap Shiny app"),
#     p("This is an interactive heatmap visualization on a random matrix."),
#     InteractiveComplexHeatmapOutput()
# )
# 
# server = function(input, output, session) {
#     makeInteractiveComplexHeatmap(input, output, session, ht1)
# }
# 
# shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# mat2 = matrix(sample(letters[1:10], 100, replace = TRUE), 10)
# ht2 = draw(Heatmap(mat2, name = "mat2"))
# 
# ui = fluidPage(
#     h3("The first heatmap"),
#     InteractiveComplexHeatmapOutput("heatmap_1"),
#     hr(),
#     h3("The second heatmap"),
#     InteractiveComplexHeatmapOutput("heatmap_2")
# )
# server = function(input, output, session) {
#     makeInteractiveComplexHeatmap(input, output, session, ht1, "heatmap_1")
#     makeInteractiveComplexHeatmap(input, output, session, ht2, "heatmap_2")
# }
# shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# ui = tabsetPanel(
#     tabPanel("Numeric", InteractiveComplexHeatmapOutput("heatmap_1")),
#     tabPanel("character", InteractiveComplexHeatmapOutput("heatmap_2"))
# )
# server = function(input, output, session) {
#     makeInteractiveComplexHeatmap(input, output, session, ht1, "heatmap_1")
#     makeInteractiveComplexHeatmap(input, output, session, ht2, "heatmap_2")
# }
# shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# body = dashboardBody(
#     fluidRow(
#         box(
#             title = "Original heatmap", width = 4, solidHeader = TRUE, status = "primary",
#             originalHeatmapOutput("ht", title = NULL)
#         ),
#         box(
#             title = "Sub-heatmap", width = 4, solidHeader = TRUE, status = "primary",
#             subHeatmapOutput("ht", title = NULL)
#         ),
#         box(
#             title = "Output", width = 4, solidHeader = TRUE, status = "primary",
#             HeatmapInfoOutput("ht", title = NULL)
#         )
#     )
# )
# 
# ui = dashboardPage(
#     dashboardHeader(),
#     dashboardSidebar(),
#     body
# )
# 
# server = function(input, output, session) {
#     makeInteractiveComplexHeatmap(input, output, session, ht, "ht")
# }
# 
# shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     InteractiveComplexHeatmapOutput(output_ui = htmlOutput("info"))
# )

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     InteractiveComplexHeatmapOutput(),
#     htmlOutput("info")
# )

## ----eval = FALSE-------------------------------------------------------------
# function(df, output) {
#     output[["info"]] = renderUI({  # or output$info = ...
#         if(is.null(df)) { # have not clicked or brushed into the heatmap body
#             ...
#         } else {
#             ...
#         }
#     })
# }

## ----eval = FALSE-------------------------------------------------------------
# unique(unlist(df$row_index))
# unique(unlist(df$column_index))

## ----eval = FALSE-------------------------------------------------------------
# function(df, input, output, session) {
#     output[["info"]] = renderUI({  # or output$info = ...
#         if(is.null(df)) { # have not clicked into the heatmap body
#             ...
#         } else {
#             ...
#         }
#     })
# }

## ----eval = FALSE-------------------------------------------------------------
# library(GetoptLong)  # for the qq() function which does variable intepolation
# data(rand_mat)
# ht = Heatmap(rand_mat, show_row_names = FALSE, show_column_names = FALSE)
# ht = draw(ht)
# 
# ui = fluidPage(
#     InteractiveComplexHeatmapOutput(output_ui = htmlOutput("info")),
# )
# 
# click_action = function(df, output) {
#     output[["info"]] = renderUI({
#         if(!is.null(df)) {
#             HTML(qq("<p style='background-color:#FF8080;color:white;padding:5px;'>You have clicked on heatmap @{df$heatmap}, row @{df$row_index}, column @{df$column_index}</p>"))
#         }
#     })
# }
# 
# suppressPackageStartupMessages(library(kableExtra))
# brush_action = function(df, output) {
#     row_index = unique(unlist(df$row_index))
#     column_index = unique(unlist(df$column_index))
#     output[["info"]] = renderUI({
#         if(!is.null(df)) {
#             HTML(kable_styling(kbl(m[row_index, column_index, drop = FALSE], digits = 2, format = "html"), full_width = FALSE, position = "left"))
#         }
#     })
# }
# 
# server = function(input, output, session) {
#     makeInteractiveComplexHeatmap(input, output, session, ht,
#         click_action = click_action, brush_action = brush_action)
# }
# 
# shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# InteractiveComplexHeatmapOutput(..., compact = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# InteractiveComplexHeatmap(..., response = c(action, "brush-output"), output_ui_float = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# new_output_ui = ...
# InteractiveComplexHeatmap(..., compact = TRUE, output_ui = new_output_ui)

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     sliderInput("column", label = "Which column to order?",
#         value = 1, min = 1, max = 10),
#     InteractiveComplexHeatmapOutput()
# )
# 
# server = function(input, output, session) {
#     m = matrix(rnorm(100), 10)
#     rownames(m) = 1:10
#     colnames(m) = 1:10
# 
#     observeEvent(input$column, {
#         order = order(m[, input$column])
#         ht = Heatmap(m[order, , drop = FALSE],
#             cluster_rows = FALSE, cluster_columns = FALSE)
#         makeInteractiveComplexHeatmap(input, output, session, ht)
#     })
# }
# shiny::shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
#     ...
#     observeEvent(input$column, {
#         order = order(m[, input$column])
#         ht = Heatmap(m[order, , drop = FALSE],
#             cluster_rows = FALSE, cluster_columns = FALSE)
#         makeInteractiveComplexHeatmap(input, output, session, ht)
#     })
#     ...

## ----eval = FALSE-------------------------------------------------------------
# click_action = function(df, input, output, session) {
#     obs = observeEvent(input$foo, {
#         ...
#     })
#     record_observation(obs)
# }

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     actionButton("show_heatmap", "Generate_heatmap"),
# )
# 
# server = function(input, output, session) {
#     m = matrix(rnorm(100), 10)
#     ht = Heatmap(m)
# 
#     observeEvent(input$show_heatmap, {
#         InteractiveComplexHeatmapModal(input, output, session, ht)
#     })
# }
# shiny::shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     radioButtons("select", "Select", c("Numeric" = 1, "Character" = 2)),
#     actionButton("show_heatmap", "Generate_heatmap"),
# )
# 
# get_heatmap_fun = function(i) {
#     mat_list = list(
#         matrix(rnorm(100), 10),
#         matrix(sample(letters[1:10], 100, replace = TRUE), 10)
#     )
#     Heatmap(mat_list[[i]])
# }
# 
# server = function(input, output, session) {
#     observeEvent(input$show_heatmap, {
#         i = as.numeric(input$select)
#         InteractiveComplexHeatmapModal(input, output, session,
#             get_heatmap = get_heatmap_fun(i))
#     })
# }
# shiny::shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     actionButton("show_heatmap", "Generate_heatmap"),
#     htmlOutput("heatmap_output")
# )
# 
# server = function(input, output, session) {
#     m = matrix(rnorm(100), 10)
#     ht = Heatmap(m)
# 
#     observeEvent(input$show_heatmap, {
#         InteractiveComplexHeatmapWidget(input, output, session, ht, output_id = "heatmap_output")
#     })
# }
# shiny::shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     actionButton("show_heatmap", "Generate_heatmap"),
#     htmlOutput("heatmap_output")
# )
# 
# server = function(input, output, session) {
#     m = matrix(rnorm(100), 10)
#     ht = Heatmap(m)
# 
#     observeEvent(input$show_heatmap1, {
#         InteractiveComplexHeatmapWidget(input, output, session, ht,
#             output_id = "heatmap_output", close_button = FALSE,
# 
#             js_code = "
#                 $('#show_heatmap').click(function() {
#                     $('#heatmap_output').toggle('slow');
#                 }).text('Show/hide heatmap').
#                    attr('id', 'show_heatmap_toggle');
#             "
#         )
#     })
# }
# shiny::shinyApp(ui, server)

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     actionButton("action", "Generate heatmap"),
#     plotOutput("heatmap", width = 500, height = 500, click = "heatmap_click",
#         brush = "heatmap_brush"),
#     verbatimTextOutput("output")
# )
# server = function(input, output, session) {
# 
#     ht_obj = reactiveVal(NULL)
#     ht_pos_obj = reactiveVal(NULL)
# 
#     observeEvent(input$action, {
#         m = matrix(rnorm(100), 10)
#         rownames(m) = 1:10
#         colnames(m) = 1:10
# 
#         output$heatmap = renderPlot({
#             ht = draw(Heatmap(m))
#             ht_pos = htPositionsOnDevice(ht)
# 
#             ht_obj(ht)
#             ht_pos_obj(ht_pos)
#         })
#     })
# 
#     observeEvent(input$heatmap_click, {
#         pos = getPositionFromClick(input$heatmap_click)
# 
#         selection = selectPosition(ht_obj(), pos, mark = FALSE, ht_pos = ht_pos_obj(),
#             verbose = FALSE)
#         output$output = renderPrint({
#             print(selection)
#         })
#     })
# 
#     observeEvent(input$heatmap_brush, {
#         lt = getPositionFromBrush(input$heatmap_brush)
# 
#         selection = selectArea(ht_obj(), lt[[1]], lt[[2]], mark = FALSE, ht_pos = ht_pos_obj(),
#             verbose = FALSE)
#         output$output = renderPrint({
#             print(selection)
#         })
#     })
# }
# shinyApp(ui, server)

