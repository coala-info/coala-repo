# Code example from 'updating-methylSig-code' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(methylSig)

## ----eval = FALSE-------------------------------------------------------------
# meth = methylSigReadData(
#     fileList = files,
#     pData = pData,
#     assembly = 'hg19',
#     destranded = TRUE,
#     maxCount = 500,
#     minCount = 10,
#     filterSNPs = TRUE,
#     num.cores = 1,
#     fileType = 'cytosineReport')

## ----read---------------------------------------------------------------------
files = c(
    system.file('extdata', 'bis_cov1.cov', package='methylSig'),
    system.file('extdata', 'bis_cov2.cov', package='methylSig')
)

bsseq_stranded = bsseq::read.bismark(
    files = files,
    colData = data.frame(row.names = c('test1','test2')),
    rmZeroCov = FALSE,
    strandCollapse = FALSE
)

## ----filter_by_coverage-------------------------------------------------------
# Load data for use in the rest of the vignette
data(BS.cancer.ex, package = 'bsseqData')
bs = BS.cancer.ex[1:10000]

bs = filter_loci_by_coverage(bs, min_count = 5, max_count = 500)

## ----filter_by_location-------------------------------------------------------
# Construct GRanges object
remove_gr = GenomicRanges::GRanges(
    seqnames = c('chr21', 'chr21', 'chr21'),
    ranges = IRanges::IRanges(
        start = c(9411552, 9411784, 9412099),
        end = c(9411552, 9411784, 9412099)
    )
)

bs = filter_loci_by_location(bs = bs, gr = remove_gr)

## ----eval = FALSE-------------------------------------------------------------
# # For genomic windows, tiles = NULL
# windowed_meth = methylSigTile(meth, tiles = NULL, win.size = 10000)
# 
# # For pre-defined tiles, tiles should be a GRanges object.

## ----tile_by_windows----------------------------------------------------------
windowed_bs = tile_by_windows(bs = bs, win_size = 10000)

## ----tile_by_regions----------------------------------------------------------
# Collapsed promoters on chr21 and chr22
data(promoters_gr, package = 'methylSig')

promoters_bs = tile_by_regions(bs = bs, gr = promoters_gr)

## ----eval = FALSE-------------------------------------------------------------
# result = methylSigCalc(
#     meth = meth,
#     comparison = 'DR_vs_DS',
#     dispersion = 'both',
#     local.info = FALSE,
#     local.winsize = 200,
#     min.per.group = c(3,3),
#     weightFunc = methylSig_weightFunc,
#     T.approx = TRUE,
#     num.cores = 1)

## ----filter_by_group_coverage-------------------------------------------------
# Look a the phenotype data for bs
bsseq::pData(bs)

# Require at least two samples from cancer and two samples from normal
bs = filter_loci_by_group_coverage(
    bs = bs,
    group_column = 'Type',
    c('cancer' = 2, 'normal' = 2))

## ----diff_methylsig-----------------------------------------------------------
# Test cancer versus normal with dispersion from both groups
diff_gr = diff_methylsig(
    bs = bs,
    group_column = 'Type',
    comparison_groups = c('case' = 'cancer', 'control' = 'normal'),
    disp_groups = c('case' = TRUE, 'control' = TRUE),
    local_window_size = 0,
    t_approx = TRUE,
    n_cores = 1)

## ----eval = FALSE-------------------------------------------------------------
# contrast = matrix(c(0,1), ncol = 1)
# result_dss = methylSigDSS(
#     meth = meth,
#     design = design1,
#     formula = '~ group',
#     contrast = contrast,
#     group.term = 'group',
#     min.per.group=c(3,3))

## ----filter_by_group_coverage2, eval = FALSE----------------------------------
# # IF NOT DONE PREVIOUSLY
# # Require at least two samples from cancer and two samples from normal
# bs = filter_loci_by_group_coverage(
#     bs = bs,
#     group_column = 'Type',
#     c('cancer' = 2, 'normal' = 2))

## ----diff_dss_fit_simple------------------------------------------------------
# Test the simplest model with an intercept and Type
diff_fit_simple = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = as.formula('~ Type'))

## ----diff_dss_test_simple-----------------------------------------------------
# Test the simplest model for cancer vs normal
# Note, 2 rows corresponds to 2 columns in diff_fit_simple$X
simple_contrast = matrix(c(0,1), ncol = 1)

diff_simple_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_simple,
    contrast = simple_contrast,
    methylation_group_column = 'Type',
    methylation_groups = c('case' = 'cancer', 'control' = 'normal'))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

