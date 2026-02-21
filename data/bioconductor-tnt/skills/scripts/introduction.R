# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("TnT")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("marlin-na/TnT")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(TnT))

## -----------------------------------------------------------------------------
gr <- GenomicRanges::GRanges("chr7",
    ranges = IRanges(
        start = c(26549019L, 26564119L, 26585667L, 26591772L, 26594192L, 26623835L,
                  26659284L, 26721294L, 26821518L, 26991322L),
        end =   c(26550183L, 26564500L, 26586158L, 26593309L, 26594570L, 26624150L,
                  26660352L, 26721717L, 26823297L, 26991841L)),
    ID = 1:10,
    Name = paste("My Range", 1:10)
)
btrack <- TnT::BlockTrack(gr)
btrack

## -----------------------------------------------------------------------------
args(TnT::BlockTrack)

## -----------------------------------------------------------------------------
TnT::TnTGenome(btrack)

## ----echo=FALSE---------------------------------------------------------------
df <- data.frame(stringsAsFactors = FALSE,
    Constructor = c("BlockTrack", "VlineTrack", "PinTrack", "LineTrack", "AreaTrack",
                    "GeneTrackFromTxDb", "FeatureTrack", "GroupFeatureTrack",
                    "TxTrackFromTxDb", "TxTrackFromGRanges", "merge")
)
map.source <- c(
    BlockTrack   = "GRanges",
    FeatureTrack = "GRanges",
    VlineTrack   = "Width-one GRanges",
    PinTrack     = "Width-one GRanges paired with values",
    LineTrack    = "Width-one GRanges paired with values",
    AreaTrack    = "Width-one GRanges paired with values",
    GeneTrackFromTxDb  = "TxDb",
    TxTrackFromTxDb    = "TxDb",
    TxTrackFromGRanges = "GRanges paired with 'type' and 'tx_id'",
    GroupFeatureTrack  = "GRangesList",
    merge = "Two or more tracks"
)
map.feature <- c(
    BlockTrack   = "block",
    VlineTrack   = "vline",
    PinTrack     = "pin",
    LineTrack    = "line",
    AreaTrack    = "area",
    GeneTrackFromTxDb  = "gene",
    FeatureTrack       = "gene",
    GroupFeatureTrack  = "tx",
    TxTrackFromTxDb    = "tx",
    TxTrackFromGRanges = "tx",
    merge = "composite"
)
map.link <- list(
    BlockTrack         = c("Block Track"         = "tracktype-BlockTrack.html"),
    VlineTrack         = c("Vline Track"         = "tracktype-VlineTrack.html"),
    PinTrack           = c("Pin Track"           = "tracktype-PinTrack.html"),
    LineTrack          = c("Line and Area Track" = "tracktype-LineTrack-AreaTrack.html"),
    AreaTrack          = c("Line and Area Track" = "tracktype-LineTrack-AreaTrack.html"),
    GeneTrackFromTxDb  = c("Gene Track and Feature Track"   = "tracktype-GeneTrack.html"),
    FeatureTrack       = c("Gene Track and Feature Track"   = "tracktype-GeneTrack.html"),
    GroupFeatureTrack  = c("Tx Track and GroupFeatureTrack" = "tracktype-TxTrack.html"),
    TxTrackFromTxDb    = c("Tx Track and GroupFeatureTrack" = "tracktype-TxTrack.html"),
    TxTrackFromGRanges = c("Tx Track and GroupFeatureTrack" = "tracktype-TxTrack.html"),
    merge              = c("Composite Track" = "track-CompositeTrack.html")
)
genlink <- function (li.pairs) {
    vapply(li.pairs, FUN.VALUE = character(1),
        function (pairs) {
            stopifnot(length(pairs) == 1)
            name <- names(pairs)
            base.link <- unname(pairs)
            sprintf("[%s](http://tnt.marlin.pub/articles/examples/%s)", name, base.link)
        }
    )
}
df$Source <- map.source[df$Constructor]
df$`Feature type` <- map.feature[df$Constructor]
df$`Example` <- genlink(map.link[df$Constructor])
knitr::kable(df)

## -----------------------------------------------------------------------------
TnT::trackSpec(btrack, "background")
btrack2 <- btrack
TnT::trackSpec(btrack2, "background") <- "blanchedalmond"
TnT::trackSpec(btrack2, "label")      <- "My Ranges"
TnT::trackSpec(btrack2, "height")     <- 50

## -----------------------------------------------------------------------------
btrack2$color                     # Equivalent to `trackData(btrack2)$color`
btrack2$color <- "darkseagreen4"  # Equivalent to `trackData(btrack2)$color <- "darkseagreen4"`

## -----------------------------------------------------------------------------
TnT::trackData(btrack2) <- GenomicRanges::shift(TnT::trackData(btrack2), 10000)

## -----------------------------------------------------------------------------
TnT::TnTBoard(list(btrack, btrack2))

## -----------------------------------------------------------------------------
TnT::tooltip(btrack2) <- cbind(TnT::tooltip(btrack2),
                               as.data.frame(TnT::trackData(btrack2)))
TnT::TnTGenome(btrack2, view.range = TnT::trackData(btrack2)[4] * .05)

## -----------------------------------------------------------------------------
set.seed(6)
pintrack <- TnT::PinTrack(GRanges("chr7", IRanges(start = sample(26300000:27000000, 4), width = 1)),
                          value = c(1,3,2,4), color = c("blue", "yellow", "green", "red"))
TnT::TnTGenome(
    list(pintrack, btrack2),
    view.range = GRanges("chr7", IRanges(26550000, 26600000)),
    coord.range = IRanges(26350000, 27050000),
    zoom.allow = IRanges(50000, 200000)
)

