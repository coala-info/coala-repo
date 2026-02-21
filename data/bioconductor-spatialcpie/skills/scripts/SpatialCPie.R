# Code example from 'SpatialCPie' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "# >",
    dev = "jpeg"
)

## ----include = FALSE----------------------------------------------------------
library(rlang)
library(dplyr)

# Patch SpatialCPie::runCPie so that it returns a mock output object instead of
# starting the web server
assignInNamespace(
    ns = "SpatialCPie",
    x = "runCPie",
    value = function(
        counts,
        image = NULL,
        spotCoordinates = NULL,
        margin = "spot",
        resolutions = 2:4,
        assignmentFunction = function(k, x) kmeans(x, centers =  k)$cluster,
        scoreMultiplier = 1.0
    ) {
        data <- SpatialCPie:::.preprocessData(
            counts,
            coordinates = spotCoordinates,
            margin = margin,
            resolutions = resolutions,
            assignmentFunction = assignmentFunction
        )
        arrayPlots <- lapply(
            setNames(
                nm = levels(data$scores$resolution) %>%
                    purrr::keep(~ . > 1)
            ),
            function(r) {
                scores <- data$scores %>% filter(.data$resolution == r)
                p <- SpatialCPie:::.arrayPlot(
                    scores = scores %>%
                        select(.data$spot, .data$name, .data$score),
                    coordinates = data$coordinates,
                    image =
                        if (!is.null(image) && !is.null(data$coordinates))
                            grid::rasterGrob(
                                image,
                                width  = grid::unit(1, "npc"),
                                height = grid::unit(1, "npc"),
                                interpolate = TRUE
                            )
                        else NULL,
                    scoreMultiplier = scoreMultiplier,
                    spotOpacity = if (is.null(image)) 1.0 else 0.7
                ) +
                    ggplot2::guides(
                        fill = ggplot2::guide_legend(title = "Cluster")
                    ) +
                    ggplot2::scale_fill_manual(
                        values = data$colors,
                        labels = unique(scores$cluster)
                    )
            }
        )
        list(
            clusters = data$assignments %>% select(-.data$name),
            clusterGraph = SpatialCPie:::.clusterGraph(
                data$assignments,
                data$means,
                data$featureName,
                transitionLabels = TRUE,
                transitionThreshold = 0.05
            ) +
                ggplot2::scale_color_manual(values = data$colors),
            arrayPlot = arrayPlots
        )
    }
)

## -----------------------------------------------------------------------------
library(SpatialCPie)
set.seed(42)

## -----------------------------------------------------------------------------
counts <- read.table(
    system.file("extdata", "counts.tsv", package = "SpatialCPie"),
    sep = "\t",
    check.names = FALSE
)
counts[1:5, 1:5]

## -----------------------------------------------------------------------------
tissue <- jpeg::readJPEG(
    system.file("extdata", "he_image.jpg", package = "SpatialCPie")
)
spots <- parseSpotFile(
    system.file("extdata", "spot_data.tsv", package = "SpatialCPie")
)
head(spots)

## -----------------------------------------------------------------------------
counts <- counts[, which(colnames(counts) %in% rownames(spots))]

## -----------------------------------------------------------------------------
repeat {
    d <- dim(counts)
    counts <- counts[rowSums(counts) >= 20, colSums(counts) >= 20]
    if (all(dim(counts) == d)) {
        break
    }
}

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# runCPie(
#     counts,
#     resolutions = c(3, 5),
#     assignmentFunction = function(k, x) cluster::pam(x, k = k)$clustering
# )

## -----------------------------------------------------------------------------
result <- runCPie(
    counts,
    image = tissue,
    spotCoordinates = spots
)

## -----------------------------------------------------------------------------
str(result, max.level = 1)

## -----------------------------------------------------------------------------
result$clusterGraph

## -----------------------------------------------------------------------------
result$arrayPlot$`4`

## ----echo=FALSE, message=FALSE------------------------------------------------
result <- runCPie(
    counts,
    image = tissue,
    spotCoordinates = spots,
    scoreMultiplier = 10.0
)
result$arrayPlot$`4`

## -----------------------------------------------------------------------------
library(dplyr)
subcluster <-
    result$clusters %>%
    filter(resolution == 4, cluster %in% c(1, 4)) %>%
    `$`("unit")
head(subcluster)

## -----------------------------------------------------------------------------
subclusterResult <- runCPie(
    counts = counts[, subcluster],
    image = tissue,
    spotCoordinates = spots
)
subclusterResult$clusterGraph

## -----------------------------------------------------------------------------
subclusterResult$arrayPlot$`3`

