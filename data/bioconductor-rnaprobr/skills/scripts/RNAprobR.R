# Code example from 'RNAprobR' vignette. See references/ for full tutorial.

### R code from vignette source 'RNAprobR.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: preliminaries
###################################################
library(RNAprobR)


###################################################
### code chunk number 3: readsamples
###################################################
treated <- c(system.file("extdata", "unique_barcodes14.gz", package="RNAprobR"),
             system.file("extdata", "unique_barcodes22.gz", package="RNAprobR"))
control <- c(system.file("extdata", "unique_barcodes16.gz", package="RNAprobR"),
             system.file("extdata", "unique_barcodes24.gz", package="RNAprobR"))

k2n_treated <- c(system.file("extdata", "k2n_14", package="RNAprobR"),
                 system.file("extdata", "k2n_22", package="RNAprobR"))
k2n_control <- c(system.file("extdata", "k2n_16", package="RNAprobR"),
                 system.file("extdata", "k2n_24", package="RNAprobR"))

control_euc <- readsamples(control, euc="HRF-Seq", k2n_files=k2n_control)
treated_euc <- readsamples(treated, euc="HRF-Seq", k2n_files=k2n_treated)


###################################################
### code chunk number 4: comp
###################################################
treated_comp <- comp(treated_euc, cutoff=101, fasta_file =
                         system.file("extdata", "hrfseq.fa", package="RNAprobR"))
control_comp <- comp(control_euc, cutoff=101, fasta_file =
                         system.file("extdata", "hrfseq.fa", package="RNAprobR"))


###################################################
### code chunk number 5: dtcr
###################################################
hrfseq_norm <- dtcr(control_GR=control_comp, treated_GR=treated_comp,
                    window_size=3, nt_offset=1)


###################################################
### code chunk number 6: slograt
###################################################
hrfseq_norm <- slograt(control_GR=control_comp, treated_GR=treated_comp,
                       add_to=hrfseq_norm)


###################################################
### code chunk number 7: swinsor
###################################################
hrfseq_norm <- swinsor(Comp_GR=treated_comp, add_to=hrfseq_norm)


###################################################
### code chunk number 8: compdata
###################################################
hrfseq_norm <- compdata(Comp_GR=treated_comp, add_to=hrfseq_norm)


###################################################
### code chunk number 9: GR2norm_df
###################################################
norm_df <- GR2norm_df(hrfseq_norm, RNAid = "RNase_P", norm_methods = "slograt")


###################################################
### code chunk number 10: plotRNA
###################################################
plotRNA(norm_GR=hrfseq_norm, RNAid="16S_rRNA_E.coli", norm_method="dtcr")


###################################################
### code chunk number 11: norm2bedgraph
###################################################
RNase_P_BED <- system.file("extdata", "RNaseP.bed", package="RNAprobR")
norm2bedgraph(hrfseq_norm, bed_file = RNase_P_BED, norm_method = "dtcr",
              genome_build = "baciSubt2", bedgraph_out_file = "RNaseP_dtcr",
              track_name = "dtcr", track_description = "deltaTCR Normalization")


###################################################
### code chunk number 12: sessInfo
###################################################
sessionInfo()


###################################################
### code chunk number 13: resetOptions
###################################################
options(prompt="> ", continue="+ ")


