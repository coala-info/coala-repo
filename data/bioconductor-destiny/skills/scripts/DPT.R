# Code example from 'DPT' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
set.seed(1)

## -----------------------------------------------------------------------------
library(destiny)    # load destiny…
data(guo)           # …and sample data
library(gridExtra)  # Also we need grid.arrange

## -----------------------------------------------------------------------------
par(mar = rep(0, 4))
graph <- igraph::graph_from_literal(
    data - + 'transition probabilities' - + DiffusionMap,
    'transition probabilities' - + DPT)
plot(
    graph, layout = igraph::layout_as_tree,
    vertex.size = 50,
    vertex.color = 'transparent',
    vertex.frame.color = 'transparent',
    vertex.label.color = 'black')

## -----------------------------------------------------------------------------
dm <- DiffusionMap(guo)
dpt <- DPT(dm)

## -----------------------------------------------------------------------------
set.seed(4)
dpt_random <- DPT(dm, tips = sample(ncol(guo), 3L))

## -----------------------------------------------------------------------------
grid.arrange(plot(dpt), plot(dpt_random), ncol = 2)

## -----------------------------------------------------------------------------
grid.arrange(
    plot(dpt, col_by = 'DPT3'),
    plot(dpt, col_by = 'Gata4', pal = viridis::magma),
    ncol = 2
)

## -----------------------------------------------------------------------------
plot(dpt, root = 2, paths_to = c(1, 3), col_by = 'branch')

## -----------------------------------------------------------------------------
plot(dpt, col_by = 'branch', divide = 3, dcs = c(-1, -3, 2), pch = 20)

