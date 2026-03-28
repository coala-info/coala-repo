# snpgenie CWL Generation Report

## snpgenie_snpgenie.pl

### Tool Description
SNPGenie: Estimating Evolutionary Parameters from SNPs!

### Metadata
- **Docker Image**: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
- **Homepage**: https://github.com/chasewnelson/SNPGenie
- **Package**: https://anaconda.org/channels/bioconda/packages/snpgenie/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snpgenie/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chasewnelson/SNPGenie
- **Stars**: N/A
### Original Help Text
```text
################################################################################
##                                                                            ##
##           SNPGenie: Estimating Evolutionary Parameters from SNPs!          ##
##                                                                            ##
################################################################################

################################################################################
### OPTIONS:
################################################################################

	--fastafile: FASTA file containing exactly one (1) reference sequence.
		All positions in the SNP report must correspond to one position in this
		sequence. DEFAULT: .fa/.fasta file in the working directory.
	--gtffile: tab-delimited Gene Transfer Format file containing non-redundant
		records for all "CDS" elements (i.e., open reading frames, or ORFs)
		present in the SNP report(s). DEFAULT: .gtf file in the working directory.
	--snpreport: CLC, Geneious, or VCF file containing SNP data with respect to
		positions in the provided reference sequence (FASTA). If VCF, the exact
		format must be specified (see documentation). DEFAULT: .txt or .vcf file(s)
		in the working directory.
	--vcfformat (REQUIRED IF VCF): format ID of the VCF file (see documentation).
		Format 4 is the only option which provides support for concurrent analysis
		 of multiple samples.
	--minfreq: minimum SNP frequency to consider when calculating diversity measures;
		useful if SNPs below a certain frequency are likely to be errors.
		DEFAULT: 0
	--workdir (OPTIONAL): user-specified working directory name. DEFAULT: current
		working directory.
	--outdir (OPTIONAL): user-specified output directory name. Unless a full path,
		is given, the directory will be created in the working directory.
		DEFAULT: SNPGenie_Results (in working directory).

################################################################################
### EXAMPLES:
################################################################################

### FORMAT

	snpgenie.pl --fastafile=<ref_seq>.(fa|fasta) --gtffile=<CDS_annotations>.(gff|gtf) --snpreport=<variants>.(txt|vcf)

### EXAMPLE 1: BASIC USAGE

	snpgenie.pl --fastafile=chr1.fa --gtffile=chr1_genes.gtf --snpreport=chr1_SNPs_CLC.txt

### EXAMPLE 2: VCF INPUT

	snpgenie.pl --fastafile=seg1.fa --gtffile=seg1_genes.gtf --snpreport=seg1_VARSCAN.vcf \
	--vcfformat=4

### EXAMPLE 3: USER-SPECIFIED DIRECTORIES & RE-DIRECTED OUTPUT

	snpgenie.pl --fastafile=HPV_genome.fa --gtffile=HPV_genes.gtf --snpreport=HPV_SNPs_Geneious.txt \
	--workdir=/home/kimura/HPV/SNPs/ --outdir=/home/kimura/HPV/SNPs/diversity/ > SNPGenie_HPV.out

### EXAMPLE 4: ALL OPTIONS USED

	snpgenie.pl --fastafile=chr21.fa --gtffile=chr21_genes.gtf --snpreport=chr21_GATK.vcf \
	--vcfformat=4 --minfreq=0.001 --workdir=/home/ohta/human/data/ --outdir=SNPGenie_Results

################################################################################
################################################################################
```


## snpgenie_snpgenie_within_group.pl

### Tool Description
SNPGenie terminated.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
- **Homepage**: https://github.com/chasewnelson/SNPGenie
- **Package**: https://anaconda.org/channels/bioconda/packages/snpgenie/overview
- **Validation**: PASS

### Original Help Text
```text
### WARNING: The --fasta_file_name option must be a file with a .fa or .fasta extension
### SNPGenie terminated.
```


## snpgenie_snpgenie_between_group.pl

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
- **Homepage**: https://github.com/chasewnelson/SNPGenie
- **Package**: https://anaconda.org/channels/bioconda/packages/snpgenie/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
## WARNING: There are no .fa or .fasta files. SNPGenie terminated.
```


## snpgenie_fasta2revcom.pl

### Tool Description
Converts a '+' strand FASTA file to its reverse complement.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
- **Homepage**: https://github.com/chasewnelson/SNPGenie
- **Package**: https://anaconda.org/channels/bioconda/packages/snpgenie/overview
- **Validation**: PASS

### Original Help Text
```text
## WARNING: This script requires exactly 1 argument:
## (1) A '+' strand FASTA file

## For example: fasta2revcom.pl my_sequence.fasta
```


## snpgenie_gtf2revcom.pl

### Tool Description
Converts a '+' strand GTF file to its reverse complement representation.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
- **Homepage**: https://github.com/chasewnelson/SNPGenie
- **Package**: https://anaconda.org/channels/bioconda/packages/snpgenie/overview
- **Validation**: PASS

### Original Help Text
```text
## WARNING: This script requires exactly 2 arguments, in this order:
## (1) A '+' strand GTF file containing both '+' and '–' strand products from the '+' strand point of view; and
## (2) The total sequence length.

## For example: gtf2revcom.pl my_cds_file.gtf 10000
```


## snpgenie_vcf2revcom.pl

### Tool Description
Converts a VCF format 1 SNP report to a reverse complement sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
- **Homepage**: https://github.com/chasewnelson/SNPGenie
- **Package**: https://anaconda.org/channels/bioconda/packages/snpgenie/overview
- **Validation**: PASS

### Original Help Text
```text
## WARNING: The SNPGenie script vcfformat1_to_revcom needs exactly 2 arguments, in this order:
## ## (1) A '+' strand SNP report in VCF format 1 (SNPGenie descriptions).
## (2) The exact length of the sequence in the FASTA file.

## For example: vcfformat1_to_revcom.pl my_snp_report.vcf 248956422
```


## Metadata
- **Skill**: generated
