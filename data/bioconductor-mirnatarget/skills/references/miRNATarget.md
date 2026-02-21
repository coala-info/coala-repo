The miRNATarget data User’s Guide

Y-h. Taguchi

Modified: December 7, 2013 Compiled: November 4, 2025

Contents

1 Overview

1 Overview

1

The miRNATarget package contains miRNA target gene table for human/mouse, gene id conver-
sion table and miRNA conservation table, which are intended for the usage of MiRaGE. MiRaGE
is the software package which infers target gene regulation of miRNAs via the algorithm employed
in MiRaGE Server, http://www.granular.com/MiRaGE/.

Since this experimental package is only for the usage with MiRaGE, please refer to vignette in
MiRaGE for details about this experimental package. MiRaGE and citations[1, 2] there explain
what these data are, how to generate them from scratch and how to use them. In order to avoid the
duplicate explanation, no detailed explanation will not be here.

> library(miRNATarget)
> data(MM_refseq_to_ensembl_gene_id)
> data(TBL2_MM)
> data(MM_conv_id)

1

References

[1] Yoshizawa, M., Taguchi, Y-h., and Yasuda, J. (2011), Inference of Gene Regulation via miR-
NAs During ES Cell Differentiation Using MiRaGE Method. Int J Mol Sci 12(12):9265-9276

[2] Taguchi, Y-h. (2013). Inference of Target Gene Regulation by miRNA via MiRaGE Server. In-
troduction to Genetics - DNA Methylation, Histone Modification and Gene Regulation. ISBN:
978-1477554-94-4. iConcept Press. Retrieved from http://www.iconceptpress.com/books/ In-
troductionToGeneticsDNAMethylationHistoneModificationAndGeneRegulation/

2

