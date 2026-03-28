PROGRAM: eval\_predications
USAGE: eval\_predictions -r  -p
-l  [OPTIONS]
DESCRIPTION:
Compares predicted genes with "real" (or annotated) genes.
Reports standard measures of prediction quality. The following
measures are reported:
- nucleotide sensitivity (Sn)
- nucleotide specificity (Sp)
- approximate correlation (AC)
- correlation coefficient (CC)
- exon sensitivity (ESn)
- exon specificity (ESp)
- proportion of real exons correctly predicted (CRa)
- proportion of real exons partially predicted (PCa)
- proportion of real exons with overlapping predictions (OLa)
- missed exons (ME)
- proportion of predicted exons that are correct (CRp)
- proportion of predicted exons that are partially correct (PCp)
- proportion of predicted exons that overlap real ones (OLp)
- wrong exons (WE)
All quantities are computed as described in "Evaluation of Gene-Finding
Programs on Mammalian Sequences," by Rogic et al. (Genome Research
11:817-832). Note that CRa + PCa + OLa + ME = 1 and CRp + PCp + OLp +
WE = 1. Note also that each set (predicted and real) should consist of
non-overlapping groups of features (see 'refeature').
OPTIONS:
-r
(required) List of names of files defining real genes (GFF).
-p
(required) List of names of files defining predicted genes
(GFF). Must correspond in order to .
-l
(required) List of lengths of sequences. Needed to compute
certain nucleotide-level statistics.
-f
List of names of all features denoting exon regions. By
default, equal to the single name "CDS".
-d
Dump full coords of correct, partially correct, wrong, missed,
and overlapping exons to a set of files having the specified
file name prefix.
-n
Also report stats on "nearly correct" exons, that is, incorrect
exons whose boundaries are within  of being correct.
Columns will be labeled "NCa" and "NCp".
-h
Print this help message.
NOTE: be sure stop codons are included in CDSs in both the predicted
and real sets, or in neither set.