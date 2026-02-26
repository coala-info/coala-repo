# safesim CWL Generation Report

## safesim_safemut

### Tool Description
This is a NGS variant simulator that is aware of the molecular-barcodes (also known as unique molecular identifiers (UMIs))

### Metadata
- **Docker Image**: quay.io/biocontainers/safesim:0.1.6.8d44580--h7d57edc_4
- **Homepage**: https://github.com/genetronhealth/safesim
- **Package**: https://anaconda.org/channels/bioconda/packages/safesim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/safesim/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/genetronhealth/safesim
- **Stars**: N/A
### Original Help Text
```text
Program safemut version 0.1.6. ()
  This is a NGS variant simulator that is aware of the molecular-barcodes (also known as unique molecular identifiers (UMIs))
Usage: safemut -b <INPUT-BAM> -v <INPUT-VCF> -1 <OUTPUT-R1-FASTQ> -2 <OUTPUT-R2-FASTQ.gz> -0 <OUTPUT-UNPAIRED-FASTQ.GZ>
Optional parameters:
 -f Fraction of variant allele (FA) to simulate. This value is overriden by the INFO/FA tag (specified by the -F command-line parameter) in the INPUT-VCF. Please note that INFO/FA must be defined the header of INPUT-VCF to be effective. Otherwise, the value defined by -f is used in the simulation [default to 0.100000].
 -p The power-law exponent simulating the over-dispersion of allele fractions in NGS [default to -1.000000] (https://doi.org/10.1093/bib/bbab458). Negative value means that no over-dispersion is simulated. 
 -q the log-normal over-dispersion parameter in Phred scale [default to 15.000000] (https://doi.org/10.1093/bib/bbab458). Negative value means that no over-dispersion is simulated. 
 -s The random seed used to simulate allele fractions from read names labeled with UMIs [default to 13].
 -x Phred-scale sequencing error rates of simulated SNV variants where -2 means zero error and -1 means using sequencer BQ [default to -1].
 -i The base quality of the inserted bases in the simulated insertion variants. [default to 30].
 -A The number of reads used to generate the randomness for simulating the nominator of the allele fraction used with the -p cmd-line param [default to 50].
 -B The number of reads used to generate the randomness for simulating the denominator of the allele fraction used with the -p cmd-line param [default to 500].
 -C The random seed used to simulate basecalling error [default to 13].
 -F allele fraction TAG in the VCF file. [default to FA].
 -S sample name used for the -F command-line parameter. The special values NULL pointer, empty-string, and INFO mean using the INFO column instead of the FORMAT column.[default to NULL pointer].
Note:
Reads in <OUTPUT-R1-FASTQ> and <OUTPUT-R2-FASTQ> are not in the same order, so these output FASTQ files have to be sorted using a tool such as fastq-sort before being aligned again, as most aligners such as BWA and Bowtie2 require reads in the R1 and R2 files to be in the same order (This is VERY IMPORTANT!).
<INPUT-BAM> and <INPUT-VCF> both have to be sorted and indexed.
To detect UMI, this prgram first checks for the MI tag in each alignment record in <INPUT-BAM>. If the MI tag is absent, then the program checks for the string after the number-hash-pound sign (#) in the read name (QNAME).
Each variant record in the INPUT-VCF needs to have only one variant, it cannot be multiallelic.
Currently, the simulation of insertion/deletion variants causes longer/shorter-than-expected lengths of read template sequences due to preservation of alignment start and end positions on the reference genome.
The symbol '#' denotes the start of UMI sequence so that any string before the '#' symbol is discarded.
The symbol '+' in a UMI sequence means that the UMI is a duplex, so the substrings before/after the '+' symbol are respectively the alpha/beta tags.
The BAM tag MI has special meaning as mentioned in the BAM file format specification.Therefore, for each BAM record, this program first searches for the MI tag. If the MI tag is not found, then this program uses the read name QNAME as the string containing UMI sequence.
The -v command-line parameter without any other comamnd-line parameter means 'print version then exit with zero'.
```


## safesim_safemix

### Tool Description
This program mixes two bam files and is aware of the molecular-barcodes (also known as unique molecular identifiers (UMIs))

### Metadata
- **Docker Image**: quay.io/biocontainers/safesim:0.1.6.8d44580--h7d57edc_4
- **Homepage**: https://github.com/genetronhealth/safesim
- **Package**: https://anaconda.org/channels/bioconda/packages/safesim/overview
- **Validation**: PASS

### Original Help Text
```text
Program safemix version 0.1.6. ()
  This program mixes two bam files and is aware of the molecular-barcodes (also known as unique molecular identifiers (UMIs))
Usage: safemix -o <OUTPUT-PREFIX> -a <tumor-INPUT-BAM> -b <normal-INPUT-BAM>
Optional parameters:
  -d <tumor-umi-size> average number of reads in a UMI family in the <TUMOR-INPUT-BAM> file [default to 1.500000]
  -e <normal-umi-size> average number of reads in a UMI family in the <NORMAL-INPUT-BAM> file [default to 1.500000]
  -f <tumor-fraction> the fraction of DNA that comes from tumor [default to 0.050000]
  -i <tumor-initial-quantity> initial quantity of DNA in ng sequenced in the <TUMOR-INPUT-BAM> file [default to 10.000000]
  -j <normal-initial-quantity> initial quantity of DNA in ng sequenced in the <NORMAL-INPUT-BAM> file [default to 10.000000]
  -r <random-seed-for-initial-quantity> random seed used to select the UMI from the initial quantity of DNA [default to 13]
  -s <random-seed-for-umi-size>
 random seed used to select the reads in each UMI [default to 23]
  -U <use-only-umi>
 set the program to use only UMIs for identifying read families (discard read start and end positions) [default to unset]
Note:
<tumor-INPUT-BAM> and <normal-INPUT-BAM> both have to be sorted and indexed.
To detect UMI, this prgram first checks for the MI tag in each alignment record in <tumor-INPUT-BAM> and <normal-INPUT-BAM>. If the MI tag is absent, then the program checks for the string after the number-hash-pound sign (#) in the read name (QNAME).
<OUTPUT-PREFIX> is appended by the string literals ".tumor.bam" and ".normal.bam" (without the double quotes) to generate the tumor and normal simulated BAM filenames, respectively. The tumor and normal bam files have to be merged (e.g., by samtools merge) to simulate the sequenced sample.
```

