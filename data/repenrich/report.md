# repenrich CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| repenrich_RepEnrich.py | PASS | ran on real E. coli Illumina reads (ERR10542496 subset) with bowtie unique and multimapped reads; fraction counts per repeat are plausible |
| repenrich_RepEnrich_setup.py | PASS | ran on E. coli K-12 with a RepeatMasker annotation made with a RepeatScout library; built the repeat pseudogenome indexes |

## repenrich_RepEnrich_setup.py

### Tool Description
Part I: Prepartion of repetive element psuedogenomes and repetive element
bamfiles. This script prepares the annotation used by downstream applications
to analyze for repetitive element enrichment. For this script to run properly
bowtie must be loaded. The repeat element psuedogenomes are prepared in order
to analyze reads that map to multiple locations of the genome. The repeat
element bamfiles are prepared in order to use a region sorter to analyze reads
that map to a single location of the genome.You will 1) annotation_file: The
repetitive element annotation file downloaded from RepeatMasker.org database
for your organism of interest. 2) genomefasta: Your genome of interest in
fasta format, 3)setup_folder: a folder to contain repeat element setup files
command-line usage EXAMPLE: python master_setup.py
/users/nneretti/data/annotation/mm9/mm9_repeatmasker.txt
/users/nneretti/data/annotation/mm9/mm9.fa
/users/nneretti/data/annotation/mm9/setup_folder

### Metadata
- **Docker Image**: quay.io/biocontainers/repenrich:1.2--py27_1
- **Homepage**: https://github.com/nskvir/RepEnrich
- **Package**: https://anaconda.org/channels/bioconda/packages/repenrich/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repenrich/overview
- **Total Downloads**: 6.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nskvir/RepEnrich
- **Stars**: N/A
### Original Help Text
```text
usage: getargs_genome_maker.py [-h] [--version]
                               [--nfragmentsfile1 nfragmentsfile1]
                               [--gaplength gaplength]
                               [--flankinglength flankinglength]
                               [--is_bed is_bed]
                               annotation_file genomefasta setup_folder

Part I: Prepartion of repetive element psuedogenomes and repetive element
bamfiles. This script prepares the annotation used by downstream applications
to analyze for repetitive element enrichment. For this script to run properly
bowtie must be loaded. The repeat element psuedogenomes are prepared in order
to analyze reads that map to multiple locations of the genome. The repeat
element bamfiles are prepared in order to use a region sorter to analyze reads
that map to a single location of the genome.You will 1) annotation_file: The
repetitive element annotation file downloaded from RepeatMasker.org database
for your organism of interest. 2) genomefasta: Your genome of interest in
fasta format, 3)setup_folder: a folder to contain repeat element setup files
command-line usage EXAMPLE: python master_setup.py
/users/nneretti/data/annotation/mm9/mm9_repeatmasker.txt
/users/nneretti/data/annotation/mm9/mm9.fa
/users/nneretti/data/annotation/mm9/setup_folder

positional arguments:
  annotation_file       List annotation file. The annotation file contains the
                        repeat masker annotation for the genome of interest
                        and may be downloaded at RepeatMasker.org Example
                        /data/annotation/mm9/mm9.fa.out
  genomefasta           File name and path for genome of interest in fasta
                        format. Example /data/annotation/mm9/mm9.fa
  setup_folder          List folder to contain bamfiles for repeats and repeat
                        element psuedogenomes. Example
                        /data/annotation/mm9/setup

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --nfragmentsfile1 nfragmentsfile1
                        Output location of a description file that saves the
                        number of fragments processed per repname. Default
                        ./repnames_nfragments.txt
  --gaplength gaplength
                        Length of the spacer used to build repeat
                        psuedogeneomes. Default 200
  --flankinglength flankinglength
                        Length of the flanking region adjacent to the repeat
                        element that is used to build repeat psuedogeneomes.
                        The flanking length should be set according to the
                        length of your reads. Default 25
  --is_bed is_bed       Is the annotation file a bed file. This is also a
                        compatible format. The file needs to be a tab
                        seperated bed with optional fields. Ex. format chr
                        start end Name_element class family. The class and
                        family should identical to name_element if not
                        applicable. Default FALSE change to TRUE
```


## repenrich_RepEnrich.py

### Tool Description
Part II: Conducting the alignments to the psuedogenomes (repeat element enrichment counts).

### Metadata
- **Docker Image**: quay.io/biocontainers/repenrich:1.2--py27_1
- **Homepage**: https://github.com/nskvir/RepEnrich
- **Package**: https://anaconda.org/channels/bioconda/packages/repenrich/overview
- **Validation**: PASS

### Original Help Text
```text
usage: RepEnrich.py [-h] [--version] [--pairedend PAIREDEND]
                    [--collapserepeat collapserepeat] [--threshold threshold]
                    [--tolerance tolerance] [--fastqfile2 fastqfile2]
                    [--cpus cpus] [--allcountmethod allcountmethod]
                    [--is_bed is_bed]
                    annotation_file outputfolder outputprefix setup_folder
                    fastqfile alignment_bam
```

## Metadata
- **Skill**: generated
