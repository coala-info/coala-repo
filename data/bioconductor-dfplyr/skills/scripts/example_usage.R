# Code example from 'example_usage' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("DFplyr")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"start", message=FALSE---------------------------------------------------
library("DFplyr")

## ----"create_d", message=FALSE------------------------------------------------
library(S4Vectors)
m <- mtcars[, c("cyl", "hp", "am", "gear", "disp")]
d <- as(m, "DataFrame")
d$grX <- GenomicRanges::GRanges("chrX", IRanges::IRanges(1:32, width = 10))
d$grY <- GenomicRanges::GRanges("chrY", IRanges::IRanges(1:32, width = 10))
d$nl <- IRanges::NumericList(lapply(d$gear, function(n) round(rnorm(n), 2)))
d

## ----"mutate_newvar"----------------------------------------------------------
mutate(d, newvar = cyl + hp)

## ----"nl2"--------------------------------------------------------------------
mutate(d, nl2 = nl * 2)

## ----"length_nl"--------------------------------------------------------------
mutate(d, length_nl = lengths(nl))

## ----"s4cols"-----------------------------------------------------------------
mutate(d,
    chr = GenomeInfoDb::seqnames(grX),
    strand_X = BiocGenerics::strand(grX),
    end_X = BiocGenerics::end(grX)
)

## ----"pipe"-------------------------------------------------------------------
mutate(d, newvar = cyl + hp) %>%
    pull(newvar)

## ----"mutate_if"--------------------------------------------------------------
mutate_if(d, is.numeric, ~ .^2)

## ----"mutate_if_granges"------------------------------------------------------
mutate_if(d, ~ isa(., "GRanges"), BiocGenerics::start)

## ----"at_mutate"--------------------------------------------------------------
mutate_at(d, vars(starts_with("c")), ~ .^2)

## ----"at_select"--------------------------------------------------------------
select_at(d, vars(starts_with("gr")))

## ----"group_by"---------------------------------------------------------------
group_by(d, cyl, am)

## ----"rownames"---------------------------------------------------------------
select(d, am, cyl)

## ----"rownames_arrange"-------------------------------------------------------
arrange(d, desc(hp))

## ----"rownames_filter"--------------------------------------------------------
filter(d, am == 0)

## ----"rownames_slice"---------------------------------------------------------
slice(d, 3:6)

## ----"grouped_slice"----------------------------------------------------------
group_by(d, gear) %>%
    slice(1:2)

## ----"rename2"----------------------------------------------------------------
select(d, am, cyl) %>%
    rename2(foo = am)

## ----"distinct"---------------------------------------------------------------
distinct(d)

## ----"group_tally"------------------------------------------------------------
group_by(d, cyl, am) %>%
    tally(gear)

## ----"count"------------------------------------------------------------------
count(d, gear, am, cyl)

## -----------------------------------------------------------------------------
Da <- as(starwars[, c("name", "eye_color", "height", "mass")], "DataFrame") |>
    head(10) |>
    group_by(eye_color)
Da

Db <- as(starwars[, c("name", "eye_color", "homeworld")], "DataFrame")
Db

left_join(Da, Db)

right_join(Da, Db)

inner_join(Da, Db[1:3, ])

full_join(Da, Db[1:3, ])

## ----"citation"---------------------------------------------------------------
citation("DFplyr")

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
options(width = 120)
sessioninfo::session_info()

