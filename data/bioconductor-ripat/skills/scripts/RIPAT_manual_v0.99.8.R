# Code example from 'RIPAT_manual_v0.99.8' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo=TRUE)
knitr::opts_knit$set(progress=FALSE, verbose=FALSE)

## ----echo=FALSE, out.width='70%', fig.align='center'--------------------------
    knitr::include_graphics('db_structure.png')

## ----echo=FALSE, fig.align='left'---------------------------------------------
    knitr::include_graphics('input_contents_table.PNG')

## ----results='hide', message=FALSE--------------------------------------------
library(RIPAT)
# Download gene data file
makeData(organism = 'GRCh37', dataType = 'gene')

## ----results='hide', message=FALSE--------------------------------------------
blast_obj=makeInputObj(inFile='blast_result.txt',  
                       vectorPos='front',
                       mapTool='blast',  
                       outPath='.',  
                       outFileName='A5_15856M_BLAST')

## ----results='hide', message=FALSE--------------------------------------------
blast_gene10K=annoByGene(hits=blast_obj,
                         organism='GRCh37',  
                         interval=5000,
                         range=c(-20000, 20000),  
                         doRandom=TRUE,
                         randomSize=10000,  
                         includeUndecided=FALSE,  
                         outPath='.',
                         outFileName='A5_15856M_BLAST_10K')

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('A5_15856M_BLAST_10K_distribution_gene_GRCh37.png')

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('A5_15856M_BLAST_10K_distribution_tss_GRCh37.png')

## ----results='hide', message=FALSE--------------------------------------------
blast_gene_norandom=annoByGene(hits=blast_obj, 
                               organism='GRCh37',  
                               interval=5000, 
                               range=c(-20000, 20000),  
                               doRandom=FALSE,  
                               includeUndecided=FALSE,  
                               outPath='.',
                               outFileName='A5_15856M_BLAST_norandom')  

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('A5_15856M_BLAST_norandom_distribution_gene_GRCh37.png')

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('A5_15856M_BLAST_norandom_distribution_tss_GRCh37.png')

## ----results='hide', message=FALSE--------------------------------------------
## Karyogram marked genomic spots
karyo_obj_gene = drawingKaryo(hits=blast_obj, 
                              organism="GRCh37",  
                              feature=blast_gene10K$Gene_data,  
                              includeUndecided=FALSE,  
                              outPath=getwd(),  
                              outFileName='A5_15856M_BLAST_karyo_gene')  

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('Ideogram_A5_15856M_BLAST_karyo_gene_GRCh37_decided.png')

## ----results='hide', message=FALSE--------------------------------------------
makeDocument(res = blast_gene10K,
             dataType = 'gene',
             excelOut = TRUE,
             includeUndecided = FALSE,
             outPath = getwd(),
             outFileName = 'A5_15856M_BLAST_10K')  

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('A5_15856M_BLAST_10K_histogram_observed_gene.png')

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('A5_15856M_BLAST_10K_random_histogram_observed_gene.png')

## ----echo=FALSE---------------------------------------------------------------
    knitr::include_graphics('A5_15856M_BLAST_10K_pvalue_plot_gene.png')

## ----echo=FALSE---------------------------------------------------------------
citation('RIPAT')

