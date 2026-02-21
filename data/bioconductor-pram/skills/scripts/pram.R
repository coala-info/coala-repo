# Code example from 'pram' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----fig.cap='PRAM workflow', out.width='237px', out.height='233px', echo=F----
knitr::include_graphics("workflow_noScreen.jpg")

## ----installFromGitHub, eval=FALSE--------------------------------------------
# devtools::install_github('pliu55/pram')

## ----installFromBioconductor, eval=FALSE--------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("pram")

## ----runQuickPRAM, eval=FALSE-------------------------------------------------
# ##
# ## assuming the stringtie binary is in folder /usr/local/stringtie-1.3.3/
# ##
# pram::runPRAM(  in_gtf, in_bamv, out_gtf, method='plst',
#                 stringtie='/usr/loca/stringtie-1.3.3/stringtie')

## ----accessExample------------------------------------------------------------
system.file('extdata/demo/in.gtf', package='pram')

## ----runPRAM, eval=FALSE------------------------------------------------------
# in_gtf = system.file('extdata/demo/in.gtf', package='pram')
# 
# in_bamv = c(system.file('extdata/demo/SZP.bam', package='pram'),
#             system.file('extdata/demo/TLC.bam', package='pram') )
# 
# pred_out_gtf = tempfile(fileext='.gtf')
# 
# ##
# ## assuming the stringtie binary is in folder /usr/local/stringtie-1.3.3/
# ##
# pram::runPRAM(  in_gtf, in_bamv, pred_out_gtf, method='plst',
#                 stringtie='/usr/loca/stringtie-1.3.3/stringtie')

## ----echo=F-------------------------------------------------------------------
url_hg19_chromsize=
'http://hgdownload.cse.ucsc.edu/goldenpath/hg19/database/chromInfo.txt.gz'

## ----defIgRanges, warning=FALSE-----------------------------------------------
pram::defIgRanges(system.file('extdata/gtf/defIgRanges_in.gtf', package='pram'),
                genome = 'hg38')

## ----prepIgBam----------------------------------------------------------------
finbam =system.file('extdata/bam/CMPRep2.sortedByCoord.raw.bam', 
                    package='pram')

iggrs = GenomicRanges::GRanges('chr10:77236000-77247000:+')

foutbam = tempfile(fileext='.bam')

pram::prepIgBam(finbam, iggrs, foutbam)

## ----echo=F-------------------------------------------------------------------
url_cf_web = paste0('[Cufflinks, Cuffmerge]',
'(http://cole-trapnell-lab.github.io/cufflinks/)')

url_cf_lnx = paste0('[v2.2.1]',
'(http://cole-trapnell-lab.github.io/cufflinks/assets/',
'downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz)')

url_cf_mac = paste0('[v2.1.1]',
'(http://cole-trapnell-lab.github.io/cufflinks/assets/',
'downloads/cufflinks-2.1.1.OSX_x86_64.tar.gz)')

cf_methods = '__plcf__, __cfmg__, __cftc__, and __cf__'

url_st_web = paste0('[StringTie, StringTie-merge]',
'(https://ccb.jhu.edu/software/stringtie/)')

url_st_lnx = paste0('[v1.3.3b]', 
'(http://ccb.jhu.edu/software/stringtie/dl/',
'stringtie-1.3.3b.Linux_x86_64.tar.gz)')

url_st_mac = paste0('[v1.3.3b]', 
'(http://ccb.jhu.edu/software/stringtie/dl/',
'stringtie-1.3.3b.OSX_x86_64.tar.gz)')

st_methods = '__plst__, __stmg__, and __st__'

url_tc_web = '[TACO](https://tacorna.github.io)'

url_tc_lnx = paste0('[v0.7.0]', 
'(https://github.com/tacorna/taco/releases/download/',
'v0.7.0/taco-v0.7.0.Linux_x86_64.tar.gz)')

url_tc_mac = paste0('[v0.7.0]',
'(https://github.com/tacorna/taco/releases/download/',
'v0.7.0/taco-v0.7.0.OSX_x86_64.tar.gz)')

## ----buildModel, eval=FALSE---------------------------------------------------
# fbams = c(  system.file('extdata/bam/CMPRep1.sortedByCoord.clean.bam',
#                         package='pram'),
#             system.file('extdata/bam/CMPRep2.sortedByCoord.clean.bam',
#                         package='pram') )
# 
# foutgtf = tempfile(fileext='.gtf')
# 
# ##
# ## assuming the stringtie binary is in folder /usr/local/stringtie-1.3.3/
# ##
# pram::buildModel(fbams, foutgtf, method='plst',
#                 stringtie='/usr/loca/stringtie-1.3.3/stringtie')

## ----selModel-----------------------------------------------------------------
fin_gtf = system.file('extdata/gtf/selModel_in.gtf', package='pram')

fout_gtf = tempfile(fileext='.gtf')

pram::selModel(fin_gtf, fout_gtf)

## ----evalModel----------------------------------------------------------------
fmdl = system.file('extdata/benchmark/plcf.tsv', package='pram')
ftgt = system.file('extdata/benchmark/tgt.tsv',  package='pram')

mdldt = data.table::fread(fmdl, header=TRUE, sep="\t")
tgtdt = data.table::fread(ftgt, header=TRUE, sep="\t")

pram::evalModel(mdldt, tgtdt)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

