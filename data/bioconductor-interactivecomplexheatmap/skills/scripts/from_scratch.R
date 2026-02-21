# Code example from 'from_scratch' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# ui = fluidPage(
#     ...,
#     plotOutput("heatmap", click = "heatmap_click")
# )
# server = function(input, output, session) {
#     ht_obj = reactiveVal(NULL)
#     ht_pos_obj = reactiveVal(NULL)
#     output$heatmap = renderPlot({
#         ...
#         ht = draw(Heatmap(mat))
#         ht_pos = htPositionsOnDevice(ht)
#         ht_obj(ht)
#         ht_pos_obj(ht_pos)
#     })
#     observeEvent(input$heatmap_click, {
#         pos = getPositionFromClick(input$heatmap_click)
#         df = selectPosition(ht_obj(), pos, mark = FALSE,
#             ht_pos = ht_pos_obj(), verbose = FALSE)
#         # do something with `df`
#         ...
#     })
# }

