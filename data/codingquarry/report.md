# codingquarry CWL Generation Report

## codingquarry_CodingQuarry

### Tool Description
CodingQuarry is a tool for gene prediction in fungal genomes using transcriptomic data (RNA-seq).

### Metadata
- **Docker Image**: quay.io/biocontainers/codingquarry:2.0--py311he264feb_11
- **Homepage**: https://sourceforge.net/p/codingquarry/
- **Package**: https://anaconda.org/channels/bioconda/packages/codingquarry/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/codingquarry/overview
- **Total Downloads**: 31.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
CodingQuarry v. 2.0
Author: Alison Testa

ESSENTIAL:
-f followed by file name of genome sequence

And ONE of:
-t gff3 file of aligned transcripts (recommended)
-s species name, providing pre-trained parameters exist
-a gff3 of high confidence genes that can be used for training

OPTIONAL:
-p number of threads (default is 1)
-d specify this when using un-stranded RNA-seq. By default,
 CodingQuarry expects stranded RNA-seq
-i stop after stage 1 (see manual)
-e gff3 file of aligned EST data
-h do not predict genes in soft-masked regions (that is, hard-mask these regions)

Recommended run for annotating a genome using transcripts derived from
stranded RNA-seq:
CodingQuarry -f myGenome.fa -t myTranscript.gff3 -p 8

Recommended run for annotating a genome using transcripts derived from
un-stranded RNA-seq:
CodingQuarry -f	myGenome.fa -t myTranscript.gff3 -p 8 -d

A pathogen run-mode of CodingQuarry (CodingQuarry-PM) has recently (v. 2.0) been introduced
to assist in the prediction of effectors in fungal phytopathogen species. See the manual for
details on how to use this run-mode.

IMPORTANT: It is important that you set the
environmental variable "QUARRY_PATH". This should specify the
location of the folder QuarryFiles that came with this program. If you
do not want to set the environmental variable, place the folder
QuarryFiles in your working directory before you run the program.

IMPORTANT: The transcripts must be aligned to the genome and in gff3
format. Gtf format is not supported and is likely to cause
run-time errors - use a gtf to gff3 converter (a python script has
been provided for converting Cufflinks gtfs). To be read properly,
the aligned transcripts must be listed as "exons" in the gff3 file.
The parent ID must be the same for each exon of the aligned
transcript.
An example of a gff3 that can be read:
scaffold_1  EXAMPLE  exon  1000  1024   .  -  .  ID=exon:G01:1;Parent=G01;
scaffold_1  EXAMPLE  exon  1080 1300  .  -  .  ID=exon:G01:2;Parent=G01;
scaffold_1  EXAMPLE  exon  1350 1499 .  -  .  ID=exon:G01:3;Parent=G01;
Annotation files (files containing genes) are read similarly, except
the exons should be labelled as CDS. 
The scaffold name is taken from the fasta file between the > and 
the first space that follows. This must exactly match the scaffold 
name in the gff3. The fasta and gff3 files are not checked to see 
if they conform, incorrect files may produce incorrect output or
run-time fail.
```

