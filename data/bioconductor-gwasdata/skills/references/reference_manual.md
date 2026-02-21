Package ‘GWASdata’

February 12, 2026

Title Data used in the examples and vignettes of the GWASTools package

Version 1.48.0

Author Stephanie Gogarten

Description Selected Affymetrix and Illlumina SNP data for HapMap subjects. Data pro-
vided by the Center for Inherited Disease Research at Johns Hopkins Univer-
sity and the Broad Institute of MIT and Harvard University.

Depends GWASTools

Suggests ncdf4

Maintainer Stephanie Gogarten <sdmorris@uw.edu>

License Artistic-2.0

biocViews ExperimentData, MicroarrayData, SNPData, HapMap

git_url https://git.bioconductor.org/packages/GWASdata

git_branch RELEASE_3_22

git_last_commit 1e9fcc4

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Contents

GWASdata-package .

.

.

.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

1

4

Index

GWASdata-package

Data used in the examples and vignettes of the GWASTools package.

Description

Selected Affymetrix and Illlumina SNP data for HapMap subjects. Data provided by the Center
for Inherited Disease Research (CIDR) at Johns Hopkins University and the Broad Institute of MIT
and Harvard University.

1

2

Details

GWASdata-package

77 HapMap subjects were genotyped by CIDR on the Illumina Human1Mv_C array. Selected data
includes 1000 SNPs on each of chromosomes 21, 22, and X, and 100 SNPs on each of Y, the
pseudoautosomal region, and mitochondrial DNA. SNP and scan annotation are provided as R data
frames. Genotype data, X and Y intensity data with quality scores, and B allele frequency / log R
ratio data are stored in NetCDF files. Text files with raw data are provided for 3 subjects.

47 of the HapMap subjects were genotyped by the Broad on the Affymetrix GenomeWideSNP_6
array. Identical SNPs to the Illumina data were selected for chromosomes 21, 22, and X. SNP and
scan annotation are provided as R data frames. Genotype data and X and Y intensity data with
quality scores are stored in NetCDF files. Text files with raw data are provided for 3 subjects.

List of datasets:

• affy_scan_annot: data.frame with Affymetrix scan annotation

• affy_snp_annot: data.frame with Affymetrix SNP annotation

• affyScanADF: ScanAnnotationDataFrame with Affymetrix scan annotation

• affySNPADF: SnpAnnotationDataFrame with Affymetrix SNP annotation

• illumina_scan_annot: data.frame with Illumina scan annotation

• illumina_snp_annot: data.frame with Illumina SNP annotation

• illuminaScanADF: ScanAnnotationDataFrame with Illumina scan annotation

• illuminaSnpADF: SnpAnnotationDataFrame with Illumina SNP annotation

List of files in "extdata":

• affy_geno.nc: NetCDF file with Affymetrix genotypes

• affy_qxy.nc: NetCDF file with Affymetrix XY intensity data and quality scores

• affy_raw_data: Directory with Affymetrix raw data in text files

• illumina_geno.nc: NetCDF file with Illumina genotypes

• illumina_qxy.nc: NetCDF file with Illumina XY intensity data and quality scores

• illumina_bl.nc: NetCDF file with Illumina BAlleleFreq and LogRRatio data

• illumina_geno.gds: GDS file with Illumina genotypes

• illumina_qxy.gds: GDS file with Illumina XY intensity data and quality scores

• illumina_bl.gds: GDS file with Illumina BAlleleFreq and LogRRatio data

• illumina_raw_data: Directory with Illumina raw data in text files

• illumina_subj.ped: PLINK PED file with Illumina genotypes

• illumina_subj.map: PLINK MAP file with Illumina SNP info

• illumina_subj.bim: PLINK extended MAP file with Illumina SNP info and alleles

See Also

ScanAnnotationDataFrame, SnpAnnotationDataFrame, NcdfGenotypeReader, NcdfIntensityReader,
GdsGenotypeReader, GdsIntensityReader, GenotypeData, IntensityData

GWASdata-package

Examples

library(GWASdata)
data(illumina_scan_annot)
data(illumina_snp_annot)

3

data(illuminaScanADF) # ScanAnnotationDataFrame
data(illuminaSnpADF) # SnpAnnotationDataFrame
varMetadata(illuminaSnpADF)

# NetCDF
file <- system.file("extdata", "illumina_geno.nc", package="GWASdata")
nc <- NcdfGenotypeReader(file)
geno <- getGenotype(nc, snp=c(1,10), scan=c(1,5))
genoData <- GenotypeData(nc, snpAnnot=illuminaSnpADF, scanAnnot=illuminaScanADF)

# GDS
file <- system.file("extdata", "illumina_geno.gds", package="GWASdata")
gds <- GdsGenotypeReader(file)
geno <- getGenotype(gds, snp=c(1,10), scan=c(1,5))
genoData <- GenotypeData(gds, snpAnnot=illuminaSnpADF, scanAnnot=illuminaScanADF)

# raw data
list.files(system.file("extdata", "illumina_raw_data", package="GWASdata"))

Index

∗ datasets

GWASdata-package, 1

∗ package

GWASdata-package, 1

affy_scan_annot (GWASdata-package), 1
affy_snp_annot (GWASdata-package), 1
affyScanADF (GWASdata-package), 1
affySnpADF (GWASdata-package), 1

GdsGenotypeReader, 2
GdsIntensityReader, 2
GenotypeData, 2
GWASdata (GWASdata-package), 1
GWASdata-package, 1

illumina_scan_annot (GWASdata-package),

1

illumina_snp_annot (GWASdata-package), 1
illuminaScanADF (GWASdata-package), 1
illuminaSnpADF (GWASdata-package), 1
IntensityData, 2

NcdfGenotypeReader, 2
NcdfIntensityReader, 2

ScanAnnotationDataFrame, 2
SnpAnnotationDataFrame, 2

4

