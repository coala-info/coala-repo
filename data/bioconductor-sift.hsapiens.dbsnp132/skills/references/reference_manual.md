SIFT.Hsapiens.dbSNP132

February 11, 2026

SIFT.Hsapiens.dbSNP132

SIFT predictions for Homo sapiens dbSNP build 132

Description

Database of SIFT predictions for Homo sapiens dbSNP build 132

Details

• Methods : See ?’SIFTDb-class’ for methods.

• Creation of Database Tables : This package includes SIFT predictions for dbSNP build 132

human coding non-synonymous SNPs.

• Source Files :

– Source : ftp://ftp.jcvi.org/pub/data/sift/dbSNP_132/
– Software : SIFT 4.0.3
– Databases : PSI-BLAST
– Source Files : collated_predictions_dbSNP132.tgz SIFT predictions for all snps in db-
SNP build 132 readme_collated_predictions_dbSNP132.txt description of data columns
– Description : This package contains SIFT annotations for 437544 human SNPs included

in dbSNP build 132.

Author(s)

Valerie Obenchain <vobencha@fhcrc.org>

References

SIFT Home: http://sift.jcvi.org/

Kumar P, Henikoff S, Ng PC. Predicting the effects of coding non-synonymous variants on protein
function using the SIFT algorithm. Nat Protoc. 2009;4(7):1073-81

Ng PC, Henikoff S. Predicting the Effects of Amino Acid Substitutions on Protein Function Annu
Rev Genomics Hum Genet. 2006;7:61-80.

Ng PC, Henikoff S. SIFT: predicting amino acid changes that affect protein function. Nucleic Acids
Res. 2003 Jul 1;31(13):3812-4.

1

SIFT.Hsapiens.dbSNP132

2

See Also

SIFTDb-class

see ? SIFTDbColumns for column descriptions

Examples

library(SIFT.Hsapiens.dbSNP132)

## metadata
metadata(SIFT.Hsapiens.dbSNP132)

## column descriptions can be found at ?SIFTDbColumns
head(keys(SIFT.Hsapiens.dbSNP132))
cols(SIFT.Hsapiens.dbSNP132)

## subset on keys and cols
rsids <- c("rs17970171", "rs2142947", "rs3026284")
subst <- c("RSID", "METHOD", "PREDICTION", "SCORE")
select(SIFT.Hsapiens.dbSNP132, keys=rsids, cols=subst)
select(SIFT.Hsapiens.dbSNP132, keys=rsids)

Index

∗ data

SIFT.Hsapiens.dbSNP132, 1

∗ package

SIFT.Hsapiens.dbSNP132, 1

SIFT.Hsapiens.dbSNP132, 1
SIFT.Hsapiens.dbSNP132-package

(SIFT.Hsapiens.dbSNP132), 1

SIFTDb-class, 2

3

