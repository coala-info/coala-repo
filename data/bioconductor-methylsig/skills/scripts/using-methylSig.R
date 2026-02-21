# Code example from 'using-methylSig' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(methylSig)

## ----install, eval=FALSE------------------------------------------------------
# devtools::install_github('sartorlab/methylSig')

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

## ----bsseq_access-------------------------------------------------------------
# pData
bsseq::pData(bsseq_stranded)

# GRanges
GenomicRanges::granges(bsseq_stranded)

# Coverage matrix
bsseq::getCoverage(bsseq_stranded, type = 'Cov')

# Methylation matrix
bsseq::getCoverage(bsseq_stranded, type = 'M')

## ----filter_by_coverage-------------------------------------------------------
# Load data for use in the rest of the vignette
data(BS.cancer.ex, package = 'bsseqData')
bs = BS.cancer.ex[1:10000]

bs = filter_loci_by_coverage(bs, min_count = 5, max_count = 500)

## ----filter_by_location-------------------------------------------------------
# Show locations of bs
GenomicRanges::granges(bs)

# Construct GRanges object
remove_gr = GenomicRanges::GRanges(
    seqnames = c('chr21', 'chr21', 'chr21'),
    ranges = IRanges::IRanges(
        start = c(9411552, 9411784, 9412099),
        end = c(9411552, 9411784, 9412099)
    )
)

bs = filter_loci_by_location(bs = bs, gr = remove_gr)

# Show removal
GenomicRanges::granges(bs)

## ----tile_by_windows----------------------------------------------------------
windowed_bs = tile_by_windows(bs = bs, win_size = 10000)

# Show tiling
GenomicRanges::granges(windowed_bs)

## ----tile_by_regions----------------------------------------------------------
# Collapsed promoters on chr21 and chr22
data(promoters_gr, package = 'methylSig')

promoters_bs = tile_by_regions(bs = bs, gr = promoters_gr)

## ----filter_by_group_coverage-------------------------------------------------
# Look a the phenotype data for bs
bsseq::pData(bs)

# Require at least two samples from cancer and two samples from normal
bs = filter_loci_by_group_coverage(
    bs = bs,
    group_column = 'Type',
    c('cancer' = 2, 'normal' = 2))

## ----diff_binomial------------------------------------------------------------
# Test cancer versus normal
diff_gr = diff_binomial(
    bs = bs,
    group_column = 'Type',
    comparison_groups = c('case' = 'cancer', 'control' = 'normal'))

diff_gr

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

diff_gr

## ----add_numerical_covariate--------------------------------------------------
bsseq::pData(bs)$num_covariate = c(84, 96, 93, 10, 18, 9)

## ----diff_dss_fit_simple------------------------------------------------------
diff_fit_simple = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = as.formula('~ Type'))

## ----diff_dss_fit_paired------------------------------------------------------
# Paired-test
diff_fit_paired = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = '~ Type + Pair')

## ----diff_dss_fit_num---------------------------------------------------------
# Numerical covariate test
diff_fit_num = diff_dss_fit(
    bs = bs,
    design = bsseq::pData(bs),
    formula = '~ num_covariate')

## ----diff_dss_fit_model-------------------------------------------------------
diff_fit_simple$X

diff_fit_paired$X

diff_fit_num$X

## ----contrast-----------------------------------------------------------------
# Test the simplest model for cancer vs normal
# Note, 2 rows corresponds to 2 columns in diff_fit_simple$X
simple_contrast = matrix(c(0,1), ncol = 1)

# Test the paired model for cancer vs normal
# Note, 4 rows corresponds to 4 columns in diff_fit_paired$X
paired_contrast = matrix(c(0,1,0,0), ncol = 1)

# Test the numerical covariate
num_contrast = matrix(c(0,1), ncol = 1)

## ----diff_dss_test_simple-----------------------------------------------------
diff_simple_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_simple,
    contrast = simple_contrast,
    methylation_group_column = 'Type',
    methylation_groups = c('case' = 'cancer', 'control' = 'normal'))

diff_simple_gr

## ----diff_dss_test_paired-----------------------------------------------------
diff_paired_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_paired,
    contrast = paired_contrast,
    methylation_group_column = 'Type',
    methylation_groups = c('case' = 'cancer', 'control' = 'normal'))

diff_paired_gr

## ----diff_dss_test_num--------------------------------------------------------
diff_num_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit_num,
    contrast = num_contrast,
    methylation_group_column = 'num_covariate')

diff_num_gr

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

