# Code example from 'genome_arithmetics' vignette. See references/ for full tutorial.

## ----include=TRUE, echo=FALSE, message=FALSE----------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, cache = FALSE)
#str(knitr::opts_chunk$get())

## ----fig.width=5.5, fig.height=3, out.width="85%"-----------------------------
require(multicrispr)
bsgenome <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38  
gr <- char_to_granges(c(PRNP  = 'chr20:4699600:+',         # snp
                        HBB  = 'chr11:5227002:-',            # snp
                        HEXA = 'chr15:72346580-72346583:-',  # del
                        CFTR = 'chr7:117559593-117559595:+'),# ins
                     bsgenome = bsgenome)
plot_intervals(gr, facet_var = c('targetname','seqnames'))

## ----fig.width=5.5, fig.height=3, out.width="85%"-----------------------------
ext <- extend(gr, start = -10, end = +10, plot = TRUE)

## ----fig.width=5.5, fig.height=3, out.width="85%"-----------------------------
up <- up_flank(gr,  -22,  -1, plot=TRUE, facet_var=c('targetname', 'seqnames'))

## ----fig.width=5.5, fig.height=3, out.width="85%"-----------------------------
dn <- down_flank(gr, +1, +22, plot=TRUE)

## ----fig.width=5.5, fig.height=3, out.width="85%"-----------------------------
dbl <- double_flank(gr, -10,  -1, +1, +20, plot = TRUE)

