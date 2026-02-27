oligoData
February 25, 2026

oligoData-package

Provides sample datasets to be used with the oligo package.

Description

This package provides sample datasets (Affymetrix: Expression, Gene, Exon and SNP; NimbleGen:
Expression, Tiling) to be used with the oligo package. The datasets are provided as FeatureSet
extensions and require the respective annotation packages to be available.

Details

Dataset
affyExpressionFS
affyExonFS
affyGeneFS
affySnpFS
nimbleExpressionFS ExpressionFeatureSet Expression
nimbleTilingFS

Class
Array Type
ExpressionFeatureSet Expression
ExonFeatureSet
GeneFeatureSet
SnpFeatureSet

Exon
Gene
SNP

TilingFeatureSet

Tiling

Author(s)

Benilton Carvalho <Benilton.Carvalho@cancer.org.uk>

Examples

objNames <- c("affyExpressionFS",

"affyExonFS",
"affyExpressionFS",
"affyGeneFS",
"nimbleExpressionFS",
"nimbleTilingFS")

desc <- function(objName){

data(list=objName)
class(get(objName))

}
sapply(objNames, desc)

1

Index

∗ package

oligoData-package, 1

affyExonFS (oligoData-package), 1
affyExpressionFS (oligoData-package), 1
affyGeneFS (oligoData-package), 1
affySnpFS (oligoData-package), 1

nimbleExpressionFS (oligoData-package),

1

nimbleTilingFS (oligoData-package), 1

oligoData (oligoData-package), 1
oligoData-package, 1

2

