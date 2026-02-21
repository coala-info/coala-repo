# Code example from 'MetaVolcano' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE--------------------
knitr::opts_chunk$set(tidy = FALSE,
                      warning = FALSE,
                      message = FALSE,
                      cache=TRUE)

## ------------------------------------------------------------------------

BiocManager::install("MetaVolcanoR", eval = FALSE)

## ------------------------------------------------------------------------
library(MetaVolcanoR)

## ------------------------------------------------------------------------
data(diffexplist)
class(diffexplist)
head(diffexplist[[1]])
length(diffexplist)

## ------------------------------------------------------------------------
meta_degs_rem <- rem_mv(diffexp=diffexplist,
			pcriteria="pvalue",
			foldchangecol='Log2FC', 
			genenamecol='Symbol',
			geneidcol=NULL,
			collaps=FALSE,
			llcol='CI.L',
			rlcol='CI.R',
			vcol=NULL, 
			cvar=TRUE,
			metathr=0.01,
			jobname="MetaVolcano",
			outputfolder=".", 
			draw='HTML',
			ncores=1)

head(meta_degs_rem@metaresult, 3)

meta_degs_rem@MetaVolcano

draw_forest(remres=meta_degs_rem,
	    gene="MMP9",
	    genecol="Symbol", 
	    foldchangecol="Log2FC",
	    llcol="CI.L", 
	    rlcol="CI.R",
	    jobname="MetaVolcano",
	    outputfolder=".",
	    draw="HTML")

draw_forest(remres=meta_degs_rem,
	    gene="COL6A6",
	    genecol="Symbol", 
	    foldchangecol="Log2FC",
	    llcol="CI.L", 
	    rlcol="CI.R",
	    jobname="MetaVolcano",
	    outputfolder=".",
	    draw="HTML")


## ------------------------------------------------------------------------
meta_degs_vote <- votecount_mv(diffexp=diffexplist,
			       pcriteria='pvalue',
			       foldchangecol='Log2FC',
			       genenamecol='Symbol',
			       geneidcol=NULL,
			       pvalue=0.05,
			       foldchange=0, 
			       metathr=0.01,
			       collaps=FALSE,
			       jobname="MetaVolcano", 
			       outputfolder=".",
			       draw='HTML')

head(meta_degs_vote@metaresult, 3)
meta_degs_vote@degfreq

## ------------------------------------------------------------------------
meta_degs_vote@MetaVolcano

## ------------------------------------------------------------------------
meta_degs_comb <- combining_mv(diffexp=diffexplist,
			       pcriteria='pvalue', 
			       foldchangecol='Log2FC',
			       genenamecol='Symbol',
			       geneidcol=NULL,
			       metafc='Mean',
			       metathr=0.01, 
			       collaps=TRUE,
			       jobname="MetaVolcano",
			       outputfolder=".",
			       draw='HTML')

head(meta_degs_comb@metaresult, 3)
meta_degs_comb@MetaVolcano

