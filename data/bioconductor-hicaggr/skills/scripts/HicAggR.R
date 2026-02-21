# Code example from 'HicAggR' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
options(tibble.print_min = 4L, tibble.print_max = 4L)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("HicAggR")

## ----eval = FALSE-------------------------------------------------------------
# remotes::install_github("CuvierLab/HicAggR")

## ----eval = TRUE, message = FALSE---------------------------------------------
library("HicAggR")

## ----eval = TRUE, message = FALSE---------------------------------------------
withr::local_options(list(timeout = 3600))
cache.dir <- paste0(tools::R_user_dir("", which="cache"),".HicAggR_HIC_DATA")
bfc <- BiocFileCache::BiocFileCache(cache.dir,ask = FALSE)

## ----eval = TRUE, message = FALSE---------------------------------------------
if(length(BiocFileCache::bfcinfo(bfc)$rname)==0 ||
    !"Control_HIC.hic"%in%BiocFileCache::bfcinfo(bfc)$rname){
    Hic.url <- paste0("https://4dn-open-data-public.s3.amazonaws.com/",
        "fourfront-webprod/wfoutput/7386f953-8da9-47b0-acb2-931cba810544/",
        "4DNFIOTPSS3L.hic")
    if(.Platform$OS.type == "windows"){
        HicOutput.pth <- BiocFileCache::bfcadd(
            x = bfc,rname = "Control_HIC.hic",
            fpath = Hic.url,
            download = TRUE,
            config = list(method="auto",mode="wb"))
    }else{
        HicOutput.pth <- BiocFileCache::bfcadd(
            x = bfc, rname = "Control_HIC.hic",
            fpath = Hic.url,
            download = TRUE,
            config = list())
    }
}else{
    HicOutput.pth <- BiocFileCache::bfcpath(bfc)[
        which(BiocFileCache::bfcinfo(bfc)$rname=="Control_HIC.hic")]
}

## ----eval = TRUE, message = FALSE---------------------------------------------
if(length(BiocFileCache::bfcinfo(bfc)$rname)==0 ||
    !"HeatShock_HIC.mcool"%in%BiocFileCache::bfcinfo(bfc)$rname){
    Mcool.url <- paste0("https://4dn-open-data-public.s3.amazonaws.com/",
        "fourfront-webprod/wfoutput/4f1479a2-4226-4163-ba99-837f2c8f4ac0/",
        "4DNFI8DRD739.mcool")
    if(.Platform$OS.type == "windows"){
        McoolOutput.pth <- BiocFileCache::bfcadd(
            x = bfc, rname = "HeatShock_HIC.mcool",
            fpath = Mcool.url,
            download = TRUE,
            config = list(method="auto",mode="wb"))
    }else{
        McoolOutput.pth <- BiocFileCache::bfcadd(
            x = bfc, rname = "HeatShock_HIC.mcool",
            fpath = Mcool.url,
            download = TRUE,
            config = list())
    }
}else{
    McoolOutput.pth <- as.character(BiocFileCache::bfcpath(bfc)[
        which(BiocFileCache::bfcinfo(bfc)$rname=="HeatShock_HIC.mcool")])
}

## ----eval = TRUE--------------------------------------------------------------
data("Beaf32_Peaks.gnr")

## ----echo = FALSE, eval = TRUE, message = FALSE-------------------------------
Beaf_Peaks.dtf <- Beaf32_Peaks.gnr |> as.data.frame() |> head(n=3L)
Beaf_Peaks.dtf <- Beaf_Peaks.dtf[,-c(4)]
knitr::kable(Beaf_Peaks.dtf[,c(1:4,6,5)],
    col.names = c(
        "seq","start","end","strand",
        "name","score"),
    align  = "rccccc",
    digits = 1
)

## ----eval = TRUE--------------------------------------------------------------
data("TSS_Peaks.gnr")

## ----echo = FALSE, eval = TRUE, message = FALSE-------------------------------
TSS_Peaks.dtf <- TSS_Peaks.gnr |> as.data.frame() |> head(n=3L)
TSS_Peaks.dtf <- TSS_Peaks.dtf[,-c(4)] 
knitr::kable(TSS_Peaks.dtf[,c(1:4,6,5)],
    col.names = c(
        "seq","start","end","strand",
        "name","class"),
    align  = "rccccc"
)

## ----eval = TRUE--------------------------------------------------------------
data("TADs_Domains.gnr")

## ----echo = FALSE, eval = TRUE, message = FALSE-------------------------------
domains.dtf <- TADs_Domains.gnr |> as.data.frame() |> head(n=3L)
domains.dtf <- domains.dtf[,-c(4)]
knitr::kable(domains.dtf[,c(1:4,7,5,6)],
    col.names = c(
        "seq","start","end","strand",
        "name","score","class"),
    align  = "rcccccc"
    )

## ----eval = TRUE--------------------------------------------------------------
seqlengths.num <- c('2L'=23513712, '2R'=25286936)
chromSizes  <- data.frame(
    seqnames   = names(seqlengths.num ), 
    seqlengths = seqlengths.num
    )
binSize <- 5000

## ----eval = TRUE, message = FALSE---------------------------------------------
HiC_Ctrl.cmx_lst <- ImportHiC(
        file    = HicOutput.pth,
        hicResolution     = 5000,
        chrom_1 = c("2L", "2L", "2R"),
        chrom_2 = c("2L", "2R", "2R")
)

## ----eval = TRUE, message = FALSE---------------------------------------------
HiC_HS.cmx_lst <- ImportHiC(
        file    = McoolOutput.pth,
        hicResolution     = 5000,
        chrom_1 = c("2L", "2L", "2R"),
        chrom_2 = c("2L", "2R", "2R")
)

## ----eval = TRUE, results = FALSE---------------------------------------------
HiC_Ctrl.cmx_lst <- BalanceHiC(HiC_Ctrl.cmx_lst)
HiC_HS.cmx_lst <- BalanceHiC(HiC_HS.cmx_lst)

## ----eval = TRUE, results = FALSE---------------------------------------------
HiC_Ctrl.cmx_lst <- OverExpectedHiC(HiC_Ctrl.cmx_lst)
HiC_HS.cmx_lst <- OverExpectedHiC(HiC_HS.cmx_lst)

## ----eval = TRUE--------------------------------------------------------------
str(HiC_Ctrl.cmx_lst,max.level = 4)
#>

## ----eval = TRUE--------------------------------------------------------------
attributes(HiC_Ctrl.cmx_lst)
#>

## ----eval = TRUE--------------------------------------------------------------
str(S4Vectors::metadata(HiC_Ctrl.cmx_lst[["2L_2L"]]))
#>

## ----message = FALSE, eval = TRUE---------------------------------------------
anchors_Index.gnr <- IndexFeatures(
    gRangeList        = list(Beaf=Beaf32_Peaks.gnr), 
    genomicConstraint        = TADs_Domains.gnr,
    chromSizes         = chromSizes,
    binSize           = binSize,
    metadataColName = "score",
    method            = "max"
    )

## ----echo = FALSE, eval = TRUE------------------------------------------------
anchors_Index.gnr |>
    as.data.frame() |>
    head(n=3) |>
    knitr::kable()

## ----eval = TRUE--------------------------------------------------------------
baits_Index.gnr <- IndexFeatures(
    gRangeList        = list(Tss=TSS_Peaks.gnr),
    genomicConstraint        = TADs_Domains.gnr,
    chromSizes         = chromSizes,
    binSize           = binSize,
    metadataColName = "score",
    method            = "max"
    )

## ----echo = FALSE, eval = TRUE------------------------------------------------
baits_Index.gnr |>
    as.data.frame() |>
    head(n=3) |>
    knitr::kable()

## ----eval = TRUE--------------------------------------------------------------
non_Overlaps.ndx <- match(baits_Index.gnr$bin, 
    anchors_Index.gnr$bin, nomatch=0L)==0L
baits_Index.gnr <- baits_Index.gnr[non_Overlaps.ndx,]

## ----echo = FALSE, eval = TRUE------------------------------------------------
baits_Index.gnr |>
    as.data.frame() |>
    head(n=3) |>
    knitr::kable()

## ----eval = TRUE--------------------------------------------------------------
interactions.gni <- SearchPairs(
        indexAnchor = anchors_Index.gnr,
        indexBait   = baits_Index.gnr
        )

## ----eval = TRUE,  echo = FALSE-----------------------------------------------
interactions.dtf <- interactions.gni |>
    as.data.frame() |>
    head(n=3L)
interactions.dtf <- interactions.dtf[,-c(4,5,9,10)]
interactions.dtf <- interactions.dtf[,c(1:11,13,12,17,16,18,15,14,20,19,21)] |>
    `colnames<-`(c(
            "seq","start","end",
            "seq","start","end",
            "name", "constraint" ,"distance", "orientation", "submatrix.name",
            "name", "bin", "Beaf.name", "Beaf.score", "Beaf.bln",
            "name", "bin", "Tss.name", "Tss.class", "Tss.bln"
        ))

    knitr::kable(x=interactions.dtf,
        align  = "rccrccccccccccccccccc",
        digits = 1
    ) |>
    kableExtra::add_header_above(c(
        #"Names",
        "First" = 3,
        "Second" = 3,
        "Interaction"=5,
        "Anchor"=5,
        "Bait"=5)
    ) |>
    kableExtra::add_header_above(c(#" ",
    "Ranges" = 6 , "Metadata"=15))

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Extractions_of_LRI.png")

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/LRI_GInteractions.png")

## ----eval = FALSE-------------------------------------------------------------
# interactions_PFmatrix.lst <- ExtractSubmatrix(
#     genomicFeature         = interactions.gni,
#     hicLst        = HiC_Ctrl.cmx_lst,
#     referencePoint = "pf",
#     matriceDim     = 41
#     )

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/LRI_GRanges.png")

## ----eval = TRUE--------------------------------------------------------------
domains_PFmatrix.lst <- ExtractSubmatrix(
    genomicFeature         = TADs_Domains.gnr,
    hicLst        = HiC_Ctrl.cmx_lst,
    referencePoint = "pf",
    matriceDim     = 41
    )

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Extractions_of_Regions.png")

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Regions_GInteractions.png")

## ----eval = TRUE--------------------------------------------------------------
interactions_RFmatrix_ctrl.lst  <- ExtractSubmatrix(
    genomicFeature         = interactions.gni,
    hicLst        = HiC_Ctrl.cmx_lst,
    hicResolution            = NULL,
    referencePoint = "rf",
    matriceDim     = 101
    )

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Regions_GRanges.png")

## ----eval = FALSE-------------------------------------------------------------
# domains_RFmatrix.lst <- ExtractSubmatrix(
#     genomicFeature         = TADs_Domains.gnr,
#     hicLst        = HiC_Ctrl.cmx_lst,
#     referencePoint = "rf",
#     matriceDim     = 101,
#     cores          = 1,
#     verbose        = FALSE
#     )

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Extractions_of_Ponctuals_Interactions.png")

## ----eval = TRUE--------------------------------------------------------------
domains_Border.gnr <- c(
        GenomicRanges::resize(TADs_Domains.gnr, 1, "start"),
        GenomicRanges::resize(TADs_Domains.gnr, 1,  "end" )
) |>
sort()

## ----eval = TRUE--------------------------------------------------------------
domains_Border_Bin.gnr <- BinGRanges(
    gRange  = domains_Border.gnr,
    binSize = binSize,
    verbose = FALSE
    )
domains_Border_Bin.gnr$subname <- domains_Border_Bin.gnr$name
domains_Border_Bin.gnr$name    <- domains_Border_Bin.gnr$bin

## ----eval = FALSE-------------------------------------------------------------
# domains_Border_Bin.gnr

## ----eval = TRUE, echo = FALSE------------------------------------------------
domains_Border_Bin.dtf <- domains_Border_Bin.gnr |>
    as.data.frame() |>
    head(n=3L)
domains_Border_Bin.dtf <- domains_Border_Bin.dtf[,-c(4)]
knitr::kable(domains_Border_Bin.dtf[,c(1:4,7,5,6,8,9)],
    col.names = c(
        "seq","start","end","strand",
        "name","score", "class","bin","subname"),
    align  = "rcccccccc"
    ) 

## ----eval = TRUE--------------------------------------------------------------
domains_Border_Bin.gni <- 
    InteractionSet::GInteractions(
        domains_Border_Bin.gnr,domains_Border_Bin.gnr)

## ----eval = TRUE, echo = FALSE------------------------------------------------
domains_Border_Bin.dtf <- domains_Border_Bin.gni |>
    as.data.frame() |>
    head(n=3L)
domains_Border_Bin.dtf <- domains_Border_Bin.dtf[,-c(4,5,9,10)]
domains_Border_Bin.dtf[,c(1,2,3,9,7,8,10,11,4,5,6,14,13,12,15,16)] |>
    knitr::kable(
        col.names = c(
            "seq","start","end","name","score", "class", "bin", "subname",
            "seq","start","end","name","score", "class", "bin", "subname"
        ),
        align  = "rccrccccccccccccccccc",
        digits = 1
    ) |>
    kableExtra::add_header_above(c("First" = 8, "Second" = 8))

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Ponctuals_Interactions_GRanges.png")

## ----eval = FALSE-------------------------------------------------------------
# border_PFmatrix.lst <- ExtractSubmatrix(
#     genomicFeature         = domains_Border_Bin.gnr,
#     hicLst        = HiC_Ctrl.cmx_lst,
#     referencePoint = "pf",
#     matriceDim     = 101
# )

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Ponctuals_Interactions_GInteractions.png")

## ----eval = FALSE-------------------------------------------------------------
# border_PFmatrix.lst <- ExtractSubmatrix(
#     genomicFeature         = domains_Border_Bin.gni,
#     hicLst        = HiC_Ctrl.cmx_lst,
#     referencePoint = "pf",
#     matriceDim     = 101
# )

## ----eval = FALSE-------------------------------------------------------------
# structureTarget.lst <- list(
#     first_colname_of_GInteraction  = c("value"),
#     second_colname_of_GInteraction = function(eachElement){
#         min_th<value && value<max_th}
#     )

## ----eval = FALSE-------------------------------------------------------------
# attributes(interactions_RFmatrix_ctrl.lst)$interactions
# names(S4Vectors::mcols(attributes(interactions_RFmatrix_ctrl.lst)$interactions))

## ----eval = TRUE, echo = FALSE------------------------------------------------
interactions_RFmatrix_ctrl.dtf <- 
    attributes(interactions_RFmatrix_ctrl.lst)$interactions |>
        as.data.frame() |>
        head(n=10L)
interactions_RFmatrix_ctrl.dtf <- 
    interactions_RFmatrix_ctrl.dtf[,-c(4,5,9,10)]
interactions_RFmatrix_ctrl.dtf[,c(1:11,13,12,17,16,18,15,14,20,19,21)] |>
    knitr::kable(
        col.names = c(
            "seq","start","end",
            "seq","start","end",
            "name", "constraint" ,"distance", "orientation", "submatrix.name",
            "name", "bin", "Beaf.name", "Beaf.score", "Beaf.bln",
            "name", "bin", "Tss.name", "Tss.class", "Tss.bln"
        ),
        align  = "rccrccccccccccccccccc",
        digits = 1
    ) |>
    kableExtra::add_header_above(c(
        # "Names",
        "First" = 3,
        "Second" = 3,
        "Interaction"=5,
        "Anchor"=5,
        "Bait"=5)
    ) |>
    kableExtra::add_header_above(c(#" ",
    "Ranges" = 6, "Metadata"=15))

## ----eval = TRUE--------------------------------------------------------------
targets <- list(
    anchor.Beaf.name = c("Beaf32_62","Beaf32_204"),
    bait.Tss.name    = c("FBgn0015924","FBgn0264943"),
    name             = c("2L:25_2L:22"),
    distance         = function(columnElement){
        return(20000==columnElement || columnElement == 40000)
        }
    )

## ----eval = TRUE--------------------------------------------------------------
selectionFun = function(){
    Reduce(intersect, list(anchor.Beaf.name, bait.Tss.name ,distance) ) |>
    setdiff(name)
    }

## ----eval = TRUE--------------------------------------------------------------
FilterInteractions(
    genomicInteractions = 
        attributes(interactions_RFmatrix_ctrl.lst)$interactions,
    targets        = targets,
    selectionFun     = selectionFun
    )

## ----eval = TRUE--------------------------------------------------------------
filtred_interactions_RFmatrix_ctrl.lst <- FilterInteractions(
    matrices  = interactions_RFmatrix_ctrl.lst,
    targets    = targets,
    selectionFun = selectionFun
    )

## ----eval = TRUE--------------------------------------------------------------
first100_targets = list(
    submatrix.name = names(interactions_RFmatrix_ctrl.lst)[1:100]
    )

## ----eval = TRUE--------------------------------------------------------------
FilterInteractions(
    genomicInteractions = 
        attributes(interactions_RFmatrix_ctrl.lst)$interactions,
    targets        = first100_targets,
    selectionFun     = NULL
    ) |> head()

## ----eval = TRUE--------------------------------------------------------------
first100_interactions_RFmatrix_ctrl.lst <- FilterInteractions(
    matrices  = interactions_RFmatrix_ctrl.lst,
    targets    = first100_targets,
    selectionFun = NULL
    )
attributes(first100_interactions_RFmatrix_ctrl.lst)$interactions

## ----eval = TRUE--------------------------------------------------------------
attributes(interactions_RFmatrix_ctrl.lst[1:20])$interactions

## ----eval = TRUE--------------------------------------------------------------
nSample.num = 3
set.seed(123)
targets = list(name=sample(
    attributes(interactions_RFmatrix_ctrl.lst)$interactions$name,nSample.num))

## ----eval = TRUE--------------------------------------------------------------
FilterInteractions(
    genomicInteractions = 
        attributes(interactions_RFmatrix_ctrl.lst)$interactions,
    targets        = targets,
    selectionFun     = NULL
    )

## ----eval = TRUE--------------------------------------------------------------
sampled_interactions_RFmatrix_ctrl.lst <- FilterInteractions(
    matrices  = interactions_RFmatrix_ctrl.lst,
    targets    = targets,
    selectionFun = NULL
    )
attributes(sampled_interactions_RFmatrix_ctrl.lst)$interactions

## ----eval = TRUE--------------------------------------------------------------
targets <- list(
    anchor.Beaf.name = c("Beaf32_8","Beaf32_15"),
    bait.Tss.name    = c("FBgn0031214","FBgn0005278"),
    name             = c("2L:74_2L:77"),
    distance         = function(columnElement){
        return(14000==columnElement || columnElement == 3000)
        }
    )

## ----eval = TRUE--------------------------------------------------------------
FilterInteractions(
    genomicInteractions = 
        attributes(interactions_RFmatrix_ctrl.lst)$interactions,
    targets        = targets,
    selectionFun     = NULL
    ) |> str()

## ----eval = TRUE--------------------------------------------------------------
FilterInteractions(
    matrices      = interactions_RFmatrix_ctrl.lst,
    targets        = targets,
    selectionFun     = NULL
    ) |>
str()

## ----eval = TRUE--------------------------------------------------------------
a <- c("A","B","D","G")
b <- c("E","B","C","G")
c <- c("A","F","C","G")

## ----eval = TRUE--------------------------------------------------------------
Reduce(intersect, list(a,b,c)) |> sort()
intersect(a,b) |> intersect(c) |> sort()

## ----eval = TRUE--------------------------------------------------------------
Reduce(union, list(a,b,c)) |> sort()
union(a,b) |> union(c) |> sort()

## ----eval = TRUE--------------------------------------------------------------
Reduce(setdiff,list(a,b,c)) |> sort()
setdiff(a,b) |> setdiff(c) |> sort()

## ----eval = TRUE--------------------------------------------------------------
intersect(a,b) |> setdiff(c) |> sort()

## ----eval = TRUE--------------------------------------------------------------
intersect(a,b) |> union(c) |> sort()

## ----eval = TRUE--------------------------------------------------------------
union(a,b) |> intersect(c) |> sort()

## ----eval = TRUE--------------------------------------------------------------
union(a,b) |> setdiff(c) |> sort()

## ----eval = TRUE--------------------------------------------------------------
d <- c(a,b,c)
setdiff(d,d[duplicated(d)]) |> sort()

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Orientation_extraction.png")

## ----eval = TRUE, echo = FALSE------------------------------------------------
knitr::include_graphics("images/Orientation.png")

## ----eval = FALSE-------------------------------------------------------------
# # mcols(attributes(
#     # first100_interactions_RFmatrix_ctrl.lst)$interactions)$orientation

## ----eval = TRUE--------------------------------------------------------------
oriented_first100_interactions_RFmatrix_ctrl.lst <- 
    OrientateMatrix(first100_interactions_RFmatrix_ctrl.lst)

## ----eval = FALSE-------------------------------------------------------------
# orientedMatrix.mtx <-
#     OrientateMatrix(first100_interactions_RFmatrix_ctrl.lst[[1]])

## ----eval = TRUE--------------------------------------------------------------
oriented_quantiled_first100_interactions_RFmatrix_ctrl.lst <- 
    PrepareMtxList(
        first100_interactions_RFmatrix_ctrl.lst,
        transFun = 'quantile',
        orientate = TRUE)
oriented_first100_interactions_RFmatrix_ctrl.lst <- 
    PrepareMtxList(
        first100_interactions_RFmatrix_ctrl.lst,
        orientate = TRUE)

## ----eval = TRUE--------------------------------------------------------------
center.num <- GetQuantif(
    matrices  = oriented_first100_interactions_RFmatrix_ctrl.lst,
    areaFun      = "center",
    operationFun = "mean"
    )

## ----eval = TRUE--------------------------------------------------------------
GetQuantif(
    matrices  = oriented_first100_interactions_RFmatrix_ctrl.lst,
    areaFun      = function(matrice.mtx){matrice.mtx[33:35,67:69]},
    operationFun = function(area.mtx){
        area.mtx[which(area.mtx==0)]<-NA;
        return(mean(area.mtx,na.rm=TRUE))
        }
    ) |>
c() |>
unlist() |>
head()

## ----eval = TRUE--------------------------------------------------------------
namedCenter.num <- GetQuantif(
    matrices  = oriented_first100_interactions_RFmatrix_ctrl.lst,
    areaFun      = "center",
    operationFun = "mean",
    varName      = "anchor.Beaf.name"
    )

## ----eval = TRUE, echo = FALSE------------------------------------------------
S4Vectors::mcols(attributes(
    oriented_first100_interactions_RFmatrix_ctrl.lst)$interactions)[
        45:50,c("name","anchor.Beaf.name")] |>
    `row.names<-`(45:50) |>
    knitr::kable(align = "cc", digits = 1)

## ----eval = TRUE--------------------------------------------------------------
unlist(c(center.num))[45:50]
unlist(c(namedCenter.num))[45:51]

## ----eval = TRUE--------------------------------------------------------------
attributes(center.num)$duplicated
attributes(namedCenter.num)$duplicated

## ----eval = TRUE--------------------------------------------------------------
GetQuantif(
    matrices  = oriented_first100_interactions_RFmatrix_ctrl.lst,
    areaFun      = function(matrice.mtx){matrice.mtx[5,5]},
    operationFun = function(area.mtx){area.mtx}
    ) |>
head()

## ----eval = TRUE--------------------------------------------------------------
GetQuantif(
    matrices  = oriented_first100_interactions_RFmatrix_ctrl.lst,
    areaFun      = function(matrice.mtx){matrice.mtx[4:6,4:6]},
    operationFun = function(area){area}
    ) |>
head()

## ----eval = TRUE--------------------------------------------------------------
GetQuantif(
    matrices  = oriented_first100_interactions_RFmatrix_ctrl.lst,
    areaFun      = function(matrice.mtx){matrice.mtx[4:6,4:6]},
    operationFun = NULL
    ) |>
head()

## ----eval = TRUE--------------------------------------------------------------
# rm0 argument can be added to PrepareMtxList to assign NA to 0 values.
oriented_first100_interactions_RFmatrix_ctrl.lst = 
    PrepareMtxList(
        oriented_first100_interactions_RFmatrix_ctrl.lst,
        rm0 = FALSE)
agg_sum.mtx <- Aggregation(
    matrices = oriented_first100_interactions_RFmatrix_ctrl.lst, 
    aggFun      = "sum"
    )

## ----eval = TRUE--------------------------------------------------------------
agg_mean.mtx <- Aggregation(
    matrices = oriented_first100_interactions_RFmatrix_ctrl.lst,
    aggFun      = function(x){mean(x,na.rm=TRUE)}
    )

## ----eval = FALSE-------------------------------------------------------------
# first100_targets = list(
#     submatrix.name = names(interactions_RFmatrix_ctrl.lst)[1:100]
#     )
# first100_interactions_RFmatrix_ctrl.lst <- FilterInteractions(
#     matrices  = interactions_RFmatrix_ctrl.lst,
#     targets    = first100_targets,
#     selectionFun = NULL
#     )

## ----eval = FALSE-------------------------------------------------------------
# oriented_first100_interactions_RFmatrix_ctrl.lst <-
#     OrientateMatrix(first100_interactions_RFmatrix_ctrl.lst)

## ----eval = TRUE--------------------------------------------------------------
interactions_RFmatrix.lst  <- ExtractSubmatrix(
    genomicFeature         = interactions.gni,
    hicLst        = HiC_HS.cmx_lst,
    referencePoint = "rf",
    matriceDim     = 101
    )

## ----eval = TRUE--------------------------------------------------------------
first100_interactions_RFmatrix.lst <- FilterInteractions(
    matrices  = interactions_RFmatrix.lst,
    targets    = first100_targets,
    selectionFun = NULL
    )

## ----eval = TRUE--------------------------------------------------------------
oriented_first100_interactions_RFmatrix.lst <- 
    OrientateMatrix(first100_interactions_RFmatrix.lst)

## ----eval = TRUE--------------------------------------------------------------
oriented_first100_interactions_RFmatrix_ctrl.lst = 
    PrepareMtxList(first100_interactions_RFmatrix_ctrl.lst,
        minDist   = NULL,
        maxDist   = NULL,
        rm0       = FALSE,
        orientate = TRUE
)
oriented_first100_interactions_RFmatrix.lst = 
    PrepareMtxList(first100_interactions_RFmatrix.lst,
        minDist   = NULL,
        maxDist   = NULL,
        rm0       = FALSE,
        orientate = TRUE
)

diffAggreg.mtx <- Aggregation(
    ctrlMatrices    = oriented_first100_interactions_RFmatrix_ctrl.lst,
    matrices        = oriented_first100_interactions_RFmatrix.lst,
    aggFun             = "mean",
    diffFun            = "substraction",
    scaleCorrection = TRUE,
    correctionArea  =  list(
        i = c(1:30),
        j = c(72:101)
        ),
    statCompare = TRUE)

## -----------------------------------------------------------------------------
aggreg.mtx <- Aggregation(
        ctrlMatrices=interactions_RFmatrix_ctrl.lst,
        aggFun="mean"
)

## -----------------------------------------------------------------------------
oriented_interactions_RFmatrix_ctrl.lst <- 
    OrientateMatrix(interactions_RFmatrix_ctrl.lst)
orientedAggreg.mtx <- Aggregation(
        ctrlMatrices=oriented_interactions_RFmatrix_ctrl.lst,
        aggFun="mean"
)

## -----------------------------------------------------------------------------
oriented_interactions_RFmatrix.lst <- 
    OrientateMatrix(interactions_RFmatrix.lst)
diffAggreg.mtx <- Aggregation(
        ctrlMatrices    = oriented_interactions_RFmatrix_ctrl.lst,
        matrices        = oriented_interactions_RFmatrix.lst,
        aggFun          = "mean",
        diffFun         = "log2+1",
        scaleCorrection = TRUE,
        correctionArea  = list( i=c(1:30) , j=c(72:101) ),
        statCompare     = TRUE
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx   = aggreg.mtx,
        title = "APA"
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx   = orientedAggreg.mtx,
        title = "APA"
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx      = orientedAggreg.mtx,
        title    = "APA 30% trimmed on upper side",
        trim = 30,
        tails   = "upper"
)
ggAPA(
        aggregatedMtx      = orientedAggreg.mtx,
        title    = "APA 30% trimmed on upper side",
        trim = 30,
        tails   = "lower"
)
ggAPA(
        aggregatedMtx      = orientedAggreg.mtx,
        title    = "APA 30% trimmed",
        trim = 30,
        tails   = "both"
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx         = orientedAggreg.mtx,
        title       = "APA [0-1]",
        colMin = 0,
        colMax = 1
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx    = orientedAggreg.mtx,
        title  = "APA center on 0.2",
        colMid = 0.5
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx       = orientedAggreg.mtx,
        title     = "APA [0, .25, .50, .30, .75, 1]",
        colBreaks = c(0,0.25,0.5,0.75,1)
)
ggAPA(
        aggregatedMtx       = orientedAggreg.mtx,
        title     = "APA [0, .15, .20, .25, 1]",
        colBreaks = c(0,0.15,0.20,0.25,1)
)
ggAPA(
        aggregatedMtx       = orientedAggreg.mtx,
        title     = "APA [0, .5, .6, .8, 1]",
        colBreaks = c(0,0.4,0.5,0.7,1)
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx    = orientedAggreg.mtx,
        title  = "APA",
        colorScale = "density"
)
ggAPA(
        aggregatedMtx     = orientedAggreg.mtx,
        title   = "APA",
        bias    = 2
)
ggAPA(
        aggregatedMtx     = orientedAggreg.mtx,
        title   = "APA",
        bias    = 0.5
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
    aggregatedMtx     = orientedAggreg.mtx,
    title   = "APA",
    colors = viridis(6),
    na.value      = "black"
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
    aggregatedMtx           = orientedAggreg.mtx,
    title         = "APA",
    blurPass      = 1,
    stdev        = 0.5,
    loTri      = NA
)

## ----fig.dim = c(7,7)---------------------------------------------------------
ggAPA(
        aggregatedMtx     = orientedAggreg.mtx,
        title   = "APA",
) + 
ggplot2::labs(
        title    = "New title",
        subtitle = "and subtitle"
)

## ----eval = TRUE--------------------------------------------------------------
sessionInfo()

