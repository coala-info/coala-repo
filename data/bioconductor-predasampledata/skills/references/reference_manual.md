Package ‘PREDAsampledata’

Title expression and copy number data on clear cell renal carcinoma

February 17, 2026

samples

Version 0.50.0

Author I. Cifola et al. in Cristina Battaglia Lab, University of Milan

Description Sample data for PREDA package. (annotations objects synchronized with GeneAn-

not custom CDFs version 2.2.0)

Depends R (>= 2.10.0), methods, PREDA, Biobase, affy, annotate

Suggests hgu133plus2.db, hgu133plus2cdf

Maintainer Francesco Ferrari <francesco.ferrari@ifom.eu>

License Artistic-2.0

biocViews ExperimentData, Tissue, CancerData, KidneyCancerData,

MicroarrayData, TissueMicroarrayData, ArrayExpress

git_url https://git.bioconductor.org/packages/PREDAsampledata

git_branch RELEASE_3_22

git_last_commit 3bd7e24

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

.

.
.
.

.
.
.

.
.
.

AffybatchRCC .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
ExpressionSetRCC .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
GEanalysisResults
SODEGIRCNanalysisResults . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
SODEGIRCNDataForPREDA . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
SODEGIRGEanalysisResults . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
SODEGIRGEDataForPREDA . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

Index

1

2
2
3
4
4
5
6

7

2

ExpressionSetRCC

AffybatchRCC

AffyBatch object for clear cell renal carcinoma (RCC) sample dataset

Description

An AffyBatch object containint raw data from clear cell renal carcinoma (RCC) dataset CEL files

Usage

data(AffybatchRCC)

Details

The sample gene expression dataset includes 12 samples of clear cell renal carcinoma and 11 sam-
ples from normal kidney tissue.

Source

ArrayExpress dataset E-TABM-282

References

Ingrid Cifola, Roberta Spinelli, Luca Beltrame, Clelia Peano, Ester Fasoli, Stefano Ferrero, Sil-
vano Bosari, Stefano Signorini, Francesco Rocco, Roberto Perego, Vanessa Proserpio, Francesca
Raimondo, Paolo Mocarelli, and Cristina Battaglia. Genomewide screening of copy number alter-
ations and loh events in renal cell carcinomas and integration with gene expression profile. Mol
Cancer, 7:6, 2008.

Examples

data(AffybatchRCC)
AffybatchRCC

ExpressionSetRCC

ExpressionSet object for clear cell renal carcinoma (RCC) sample
dataset

Description

An ExpressionSet object containint justRMA preprocessed data for clear cell renal carcinoma
(RCC) dataset, using standard Affymetrix CDF

Usage

data(ExpressionSetRCC)

Details

The sample gene expression dataset includes 12 samples of clear cell renal carcinoma and 11 sam-
ples from normal kidney tissue.

GEanalysisResults

Source

ArrayExpress dataset E-TABM-282

References

3

Ingrid Cifola, Roberta Spinelli, Luca Beltrame, Clelia Peano, Ester Fasoli, Stefano Ferrero, Sil-
vano Bosari, Stefano Signorini, Francesco Rocco, Roberto Perego, Vanessa Proserpio, Francesca
Raimondo, Paolo Mocarelli, and Cristina Battaglia. Genomewide screening of copy number alter-
ations and loh events in renal cell carcinomas and integration with gene expression profile. Mol
Cancer, 7:6, 2008.

Examples

data(ExpressionSetRCC)
ExpressionSetRCC

GEanalysisResults

RCC gene expression sample dataset - PREDA analysis results

Description

PREDA analysis results of RCC gene expression sample dataset. The PREDA analysis was focused
on the detection of differentially expressed genomic regions in tumor samples comparet to normal
kidney cells.

Usage

data(GEanalysisResults)

Source

ArrayExpress dataset E-TABM-282

References

http://www.xlab.unimo.it/PREDA

Examples

data(GEanalysisResults)
str(GEanalysisResults)

4

SODEGIRCNDataForPREDA

SODEGIRCNanalysisResults

SODEGIR analysis results on Copy Number data

Description

PREDAResults object containing SODEGIR analysis results on Copy Number data

Usage

data(SODEGIRCNanalysisResults)

Details

See also vignette from PREDA package

Source

Copy number data data were obtained from ArrayExpress datasets E-TABM-283/E-TABM-284

References

http://www.xlab.unimo.it/PREDA http://www.xlab.unimo.it/SODEGIR

Silvio Bicciato, Roberta Spinelli, Mattia Zampieri, Eleonora Mangano, Francesco Ferrari, Luca
Beltrame, Ingrid Cifola, Clelia Peano, Aldo Solari, and Cristina Battaglia. A computational proce-
dure to identify significant overlap of differentially expressed and genomic imbalanced regions in
cancer datasets. Nucleic Acids Res, 37(15):5057-70, August 2009.

Examples

data(SODEGIRCNanalysisResults)
str(SODEGIRCNanalysisResults)

SODEGIRCNDataForPREDA Copy Number input data for PREDA analysis

Description

DataForPREDA object containing Copy Number input data for PREDA analysis

Usage

data(SODEGIRCNDataForPREDA)

Details

See also vignette from PREDA package

Source

Copy number data data were obtained from ArrayExpress datasets E-TABM-283/E-TABM-284

SODEGIRGEanalysisResults

References

5

http://www.xlab.unimo.it/PREDA http://www.xlab.unimo.it/SODEGIR

Silvio Bicciato, Roberta Spinelli, Mattia Zampieri, Eleonora Mangano, Francesco Ferrari, Luca
Beltrame, Ingrid Cifola, Clelia Peano, Aldo Solari, and Cristina Battaglia. A computational proce-
dure to identify significant overlap of differentially expressed and genomic imbalanced regions in
cancer datasets. Nucleic Acids Res, 37(15):5057-70, August 2009.

Examples

data(SODEGIRCNDataForPREDA)
str(SODEGIRCNDataForPREDA)

SODEGIRGEanalysisResults

SODEGIR analysis results on Gene Expression data

Description

PREDADataAndResults object containing SODEGIR analysis results on Gene Expression data

Usage

data(SODEGIRGEanalysisResults)

Details

See also vignette from PREDA package

Source

ArrayExpress dataset E-TABM-282

References

http://www.xlab.unimo.it/PREDA http://www.xlab.unimo.it/SODEGIR

Silvio Bicciato, Roberta Spinelli, Mattia Zampieri, Eleonora Mangano, Francesco Ferrari, Luca
Beltrame, Ingrid Cifola, Clelia Peano, Aldo Solari, and Cristina Battaglia. A computational proce-
dure to identify significant overlap of differentially expressed and genomic imbalanced regions in
cancer datasets. Nucleic Acids Res, 37(15):5057-70, August 2009.

Examples

data(SODEGIRGEanalysisResults)
str(SODEGIRGEanalysisResults)

6

SODEGIRGEDataForPREDA

SODEGIRGEDataForPREDA Gene Expression input data for PREDA analysis

Description

DataForPREDA object containing Gene Expression input data for PREDA analysis

Usage

data(SODEGIRGEDataForPREDA)

Details

See also vignette from PREDA package

Source

ArrayExpress dataset E-TABM-282

References

http://www.xlab.unimo.it/PREDA http://www.xlab.unimo.it/SODEGIR

Silvio Bicciato, Roberta Spinelli, Mattia Zampieri, Eleonora Mangano, Francesco Ferrari, Luca
Beltrame, Ingrid Cifola, Clelia Peano, Aldo Solari, and Cristina Battaglia. A computational proce-
dure to identify significant overlap of differentially expressed and genomic imbalanced regions in
cancer datasets. Nucleic Acids Res, 37(15):5057-70, August 2009.

Examples

data(SODEGIRGEDataForPREDA)
str(SODEGIRGEDataForPREDA)

Index

∗ datasets

AffybatchRCC, 2
ExpressionSetRCC, 2
GEanalysisResults, 3
SODEGIRCNanalysisResults, 4
SODEGIRCNDataForPREDA, 4
SODEGIRGEanalysisResults, 5
SODEGIRGEDataForPREDA, 6

AffybatchRCC, 2

ExpressionSetRCC, 2

GEanalysisResults, 3

SODEGIRCNanalysisResults, 4
SODEGIRCNDataForPREDA, 4
SODEGIRGEanalysisResults, 5
SODEGIRGEDataForPREDA, 6

7

