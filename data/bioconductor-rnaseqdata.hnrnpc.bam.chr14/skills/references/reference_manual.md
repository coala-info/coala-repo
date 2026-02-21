Package ‘RNAseqData.HNRNPC.bam.chr14’

February 17, 2026

Title Aligned reads from RNAseq experiment: Transcription profiling by

high throughput sequencing of HNRNPC knockdown and control HeLa
cells

Description The package contains 8 BAM files, 1 per sequencing run. Each

BAM file was obtained by (1) aligning the reads (paired-end) to the
full hg19 genome with TopHat2, and then (2) subsetting to keep only
alignments on chr14. See accession number E-MTAB-1147 in the
ArrayExpress database for details about the experiment, including links
to the published study (by Zarnack et al., 2012) and to the
FASTQ files.

URL http://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-1147/

Version 0.48.0

Encoding UTF-8

Author Hervé Pagès

Maintainer Hervé Pagès <hpages.on.github@gmail.com>

Suggests GenomicAlignments, BiocManager

biocViews ExperimentData, Genome, Homo_sapiens_Data, SequencingData,

GEO, NCI, RNASeqData, ArrayExpress

License LGPL

git_url https://git.bioconductor.org/packages/RNAseqData.HNRNPC.bam.chr14

git_branch RELEASE_3_22

git_last_commit 986efa9

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-17

Contents

RNAseqData.HNRNPC.bam.chr14-package . . . . . . . . . . . . . . . . . . . . . . . .

2

4

Index

1

2

RNAseqData.HNRNPC.bam.chr14-package

RNAseqData.HNRNPC.bam.chr14-package

Aligned reads from RNAseq experiment: Transcription profiling by
high throughput sequencing of HNRNPC knockdown and control
HeLa cells

Description

The package contains 8 BAM files, 1 per sequencing run. Each BAM file was obtained by (1)
aligning the reads (paired-end) to the full hg19 genome with TopHat2, and then (2) subsetting to
keep only alignments on chr14. See accession number E-MTAB-1147 in the ArrayExpress database
for details about the experiment, including links to the published study (by Zarnack et al., 2012)
and to the FASTQ files.

RNAseqData.HNRNPC.bam.chr14_RUNNAMES is a predefined character vector containing the names
of the 8 runs of the RNAseq experiment. The name of each run is its accession number on the
European Nucleotide Archive (ENA).

RNAseqData.HNRNPC.bam.chr14_BAMFILES is a predefined named character vector of length 8
containing the paths to the 8 BAM files obtained by aligning the reads from each sequencing run.
The reads were aligned to the full hg19 genome with TopHat2 and then the resulting BAM file was
subset to keep only alignments located on chr14.

Usage

RNAseqData.HNRNPC.bam.chr14_RUNNAMES
RNAseqData.HNRNPC.bam.chr14_BAMFILES

Details

The scripts/ folder in the package contains the scripts that were used to generate the data contained
in the package (note that all the data contained in the package is located in its extdata/ folder). The
README.TXT file in the scripts/ folder describes how to use those scripts to re-generate the data.

References

Direct Competition between hnRNP C and U2AF65 Protects the Transcriptome from the Exoniza-
tion of Alu Elements. Kathi Zarnack, Julian Konig, Mojca Tajnik, Inigo Martincorena, Sebastian
Eustermann, Isabelle Stevant, Alejandro Reyes, Simon Anders, Nicholas M. Luscombe, Jernej Ule.
Cell 2012, Europe PMC 23374342

TopHat2: accurate alignment of transcriptomes in the presence of insertions, deletions and gene
fusions. Daehwan Kim, Geo Pertea, Cole Trapnell, Harold Pimentel, Ryan Kelley and Steven L
Salzberg. Genome biology 2013, 14:R36

See Also

• http://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-1147/ for details about the
experiment, including links to the published study (by Kathi Zarnack et al., 2012) and to the
FASTQ files.

• http://www.ebi.ac.uk/ena/data/view/ERR127306, http://www.ebi.ac.uk/ena/data/
view/ERR127307, http://www.ebi.ac.uk/ena/data/view/ERR127308, http://www.ebi.
ac.uk/ena/data/view/ERR127309, http://www.ebi.ac.uk/ena/data/view/ERR127302,

RNAseqData.HNRNPC.bam.chr14-package

3

http://www.ebi.ac.uk/ena/data/view/ERR127303, http://www.ebi.ac.uk/ena/data/
view/ERR127304, and http://www.ebi.ac.uk/ena/data/view/ERR127305, for direct ac-
cess to individual runs on the European Nucleotide Archive (ENA).

• http://ccb.jhu.edu/software/tophat for the TopHat2 software.

• http://samtools.sourceforge.net/SAM1.pdf for the SAM Format Specification.

• The readGAlignmentPairs function in the GenomicAlignments package for more informa-

tion about how to read paired-end reads from a BAM file into Bioconductor.

• The ScanBamParam function in the Rsamtools package for how to get control over what to

import from a BAM file.

Examples

RNAseqData.HNRNPC.bam.chr14_RUNNAMES
RNAseqData.HNRNPC.bam.chr14_BAMFILES

if (require(GenomicAlignments)) {

bamfiles <- RNAseqData.HNRNPC.bam.chr14_BAMFILES
param <- ScanBamParam(tag="NM")
galp <- readGAlignmentPairs(bamfiles[1L], use.names=TRUE, param=param)
galp

first(galp) # 1st segment in each pair
last(galp) # 2nd segment in each pair

## The alignments contain insertions, deletions, and junctions (I, D,
## and N CIGAR operations, respectively):
colSums(cigarOpTable(cigar(first(galp))))
colSums(cigarOpTable(cigar(last(galp))))

## njunc() returns the nb of junctions for each alignment:
table(njunc(first(galp)))
table(njunc(last(galp)))
table(njunc(first(galp)) + njunc(last(galp)))

# up to 5 junctions
# per pair!

## The NM tag gives the edit distance of each alignment to the
## reference (ignoring the junction gaps):
table(mcols(first(galp))$NM)
table(mcols(last(galp))$NM)
table(mcols(first(galp))$NM + mcols(last(galp))$NM)

}

## See README.TXT in scripts/ folder:
README_file <- system.file("scripts", "README.TXT",

cat(readLines(README_file), sep="\n")

package="RNAseqData.HNRNPC.bam.chr14")

Index

∗ package

RNAseqData.HNRNPC.bam.chr14-package,

2

readGAlignmentPairs, 3
RNAseqData.HNRNPC.bam.chr14

(RNAseqData.HNRNPC.bam.chr14-package),
2

RNAseqData.HNRNPC.bam.chr14-package, 2
RNAseqData.HNRNPC.bam.chr14_BAMFILES

(RNAseqData.HNRNPC.bam.chr14-package),
2

RNAseqData.HNRNPC.bam.chr14_RUNNAMES

(RNAseqData.HNRNPC.bam.chr14-package),
2

ScanBamParam, 3

4

