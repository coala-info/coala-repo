Package ‘antiProfilesData’

February 12, 2026

Maintainer Hector Corrada Bravo <hcorrada@gmail.com>

Author Hector Corrada Bravo, Matthew McCall and Rafael A. Irizarry

Version 1.46.0

License Artistic-2.0

Title Normal colon and cancer preprocessed affy data for antiProfile

building.

Description Colon normal tissue and cancer samples used in Corrada Bravo, et
al. gene expression anti-profiles paper: BMC Bioinformatics 2012, 13:272
doi:10.1186/1471-2105-13-272. Measurements are z-scores obtained from the
GeneExpression Barcode in the 'frma' package

LazyData yes

Depends Biobase,

Suggests frma, GEOquery, GEOmetadb

biocViews ExperimentData, MicroarrayData, Tissue, CancerData,

ColonCancerData

Collate 'antiProfilesData-package.r' 'apColonData.r'

git_url https://git.bioconductor.org/packages/antiProfilesData

git_branch RELEASE_3_22

git_last_commit 63970b8

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

antiProfilesData-package .
.
apColonData

.

.

.

.

.

.

Index

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
2

4

1

2

apColonData

antiProfilesData-package

Curated dataset of normal and cancer samples on Affymetrix
hgu133plus2 expression arrays.

Description

Data used in Corrada Bravo, et al. gene expression anti-profiles paper: BMC Bioinformatics 2012,
13:272 doi:10.1186/1471-2105-13-272. Measurements are z-scores obtained from the GeneEx-
pression Barcode in the ’frma’ package. The full curated dataset in the same format containing
many normal and cancer samples is available for download http://cbcb.umd.edu/~hcorrada/
antiProfiles

Author(s)

Hector Corrada Bravo

References

Corrada Bravo, H., Pihur, V., McCall, M., Irizarry, R.A., Leek, J.T. (2012). "Gene expression
anti-profiles as a basis for accurate universal cancer signatures" BMC Bioinformatics, 13:272

apColonData

Curated dataset of many colon normal and cancer samples on
Affymetrix hgu133plus2 expression arrays.

Description

Data used in Corrada Bravo, et al. gene expression anti-profiles paper: BMC Bioinformatics 2012,
13:272 doi:10.1186/1471-2105-13-272. Measurements are z-scores obtained from the GeneEx-
pression Barcode in the ’frma’ package. Only probes mapped to genes within colon cancer hypo-
methylation blocks defined in Hansen et al. are included.

format

Data is an ExpressionSet object. The exprs slot contains gene expression barcode z-scores from
frma preprocessed data. The phenoData slot contains a data frame with the following columns:

filename: The CEL filename in the Gene Expression Omnibus (GEO)

DB_ID: The GSM sample id in GEO

ExperimentID: The GSE experiment id in GEO

Tissue: Tissue type, obtained from the gene expression barcode annotation

SubType: Sample sub-type, obtained from the gene expression barcode annotation

ClinicalGroup: Clinical sample annotation, obtained from the gene expression barcode annota-

tion

Status: Normal (0) or Cancer (1) indicator

apColonData

Author(s)

Hector Corrada Bravo

References

3

Corrada Bravo, H., Pihur, V., McCall, M., Irizarry, R.A., Leek, J.T. (2012). "Gene expression
anti-profiles as a basis for accurate universal cancer signatures" BMC Bioinformatics, 13:272

Hansen, K. D., Timp, W., Bravo, H. C., Sabunciyan, S., Langmead, B., McDonald, O. G., Wen, B.,
et al. (2011). "Increased methylation variation in epigenetic domains across cancer types." Nature
Genetics, 43(8), 768

See Also

ExpressionSet for the class definition, frma for the preprocessing method used, barcode for the
function to obtain the z-score definition.

Examples

data(apColonData)
pData(apColonData)

Index

∗ datasets

apColonData, 2

antiProfilesData-package, 2
apColonData, 2

barcode, 3

ExpressionSet, 2, 3

frma, 3

4

