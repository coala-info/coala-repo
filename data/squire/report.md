# squire CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| squire_call | PASS |  |
| squire_clean | PASS |  |
| squire_count | PASS | single-end count is correct; paired-end input crashes visibly because the image has no join command. |
| squire_draw | PASS |  |
| squire_fetch | PASS |  |
| squire_map | PASS |  |
| squire_seek | PASS |  |

## squire_fetch

### Tool Description
Download genome files (chromosome fasta, repeatmasker annotation, gene annotation) from UCSC and optionally build a STAR index.

### Metadata
- **Docker Image**: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
- **Homepage**: https://github.com/wyang17/SQuIRE
- **Package**: https://anaconda.org/channels/bioconda/packages/squire/overview
- **Validation**: PASS

### Original Help Text
```text
usage: squire Fetch [-h] -b <build> [-o <folder>] [-f] [-c] [-r] [-g] [-x]
                    [-p <int>] [-k] [-v]

Arguments:
  -h, --help            show this help message and exit
  -b <build>, --build <build>
                        UCSC designation for genome build, eg. 'hg37'
                        (required)
  -o <folder>, --fetch_folder <folder>
                        Destination folder for downloaded UCSC file(s)
                        (optional; default='squire_fetch')
  -f, --fasta           Download chromosome fasta files for build chromosomes
                        (optional; default=False)
  -c, --chrom_info      Download chrom_info.txt file with lengths of each
                        chromosome (optional; default=False)
  -r, --rmsk            Download Repeatmasker file (optional; default=False)
  -g, --gene            Download UCSC gene annotation(optional; default=False)
  -x, --index           Create STAR index, WARNING will take a lot of time and
                        memory (optional; default=False)
  -p <int>, --pthreads <int>
                        Launch <int> parallel threads(optional; default='1')
  -k, --keep            Keep downloaded compressed files (optional;
                        default=False)
  -v, --verbosity       Want messages and runtime printed to stderr (optional;
                        default=False)
```

## squire_clean

### Tool Description
Filter the repeatmasker annotation into a clean BED file of transposable elements for the chosen repeat classes, families or subfamilies.

### Metadata
- **Docker Image**: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
- **Homepage**: https://github.com/wyang17/SQuIRE
- **Package**: https://anaconda.org/channels/bioconda/packages/squire/overview
- **Validation**: PASS

### Original Help Text
```text
usage: squire Clean [-h] [-r <rmsk.txt or file.out>] [-b <build>]
                    [-i <folder>] [-o <folder>] [-c <classes>]
                    [-f <subfamilies>] [-s <families>] [-e <file>] [-v]

Arguments:
  -h, --help            show this help message and exit
  -r <rmsk.txt or file.out>, --rmsk <rmsk.txt or file.out>
                        Repeatmasker file (optional; will search
                        'squire_fetch' folder for rmsk.txt or .out file by
                        default)
  -b <build>, --build <build>
                        UCSC designation for genome build, eg. 'hg37'
                        (optional; will be basename of rmsk.txt file by
                        default)
  -i <folder>, --fetch_folder <folder>
                        Destination folder for downloaded UCSC file(s)
                        (optional; default='squire_fetch')
  -o <folder>, --clean_folder <folder>
                        Destination folder for output BED file (optional;
                        default = 'squire_clean')
  -c <classes>, --repclass <classes>
                        Comma-separated list of desired repeat class/classes,
                        aka superfamily, eg DNA, LTR. Column 12 in
                        repeatmasker file. Can use UNIX wildcard patterns.
                        (optional; default=False)
  -f <subfamilies>, --family <subfamilies>
                        Comma-separated list of desired repeat
                        family/families, eg 'ERV1,ERVK,ERVL. Column 13 in
                        repeatmasker file. Can use UNIX wildcard patterns.
                        (optional; default=False)
  -s <families>, --subfamily <families>
                        Comma-separated list of desired repeat subfamilies, eg
                        'L1HS,AluYb'. Column 11 in repeatmasker file. Can use
                        UNIX wildcard patterns. (optional; default=False)
  -e <file>, --extra <file>
                        Filepath of extra file containing non-reference repeat
                        sequences. Columns should be chr, start, stop, strand,
                        subfamily, and sequence (optional)
  -v, --verbosity       Want messages and runtime printed to stderr (optional;
                        default=False)
```

## squire_map

### Tool Description
Align RNA-seq reads to the genome with STAR, keeping multi-mapping reads for transposable element quantification.

### Metadata
- **Docker Image**: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
- **Homepage**: https://github.com/wyang17/SQuIRE
- **Package**: https://anaconda.org/channels/bioconda/packages/squire/overview
- **Validation**: PASS

### Original Help Text
```text
usage: squire Map [-h] [-1 <file_1.fastq or file_1.fastq.gz>]
                  [-2 <file_2.fastq or file_2.fastq.gz>] [-o <folder>]
                  [-f <folder>] -r <int> [-n <str>] [-3 <int>] [-e <file.txt>]
                  [-b <build>] [-p <int>] [-v]

Arguments:
  -h, --help            show this help message and exit
  -1 <file_1.fastq or file_1.fastq.gz>, --read1 <file_1.fastq or file_1.fastq.gz>
                        RNASeq data fastq file(s); read1 if providing paired
                        end data. If more than one file, separate with commas,
                        no spaces. Can be gzipped.
  -2 <file_2.fastq or file_2.fastq.gz>, --read2 <file_2.fastq or file_2.fastq.gz>
                        RNASeq data read2 fastq file(s). if more than one
                        file, separate with commas, no spaces. Can be gzipped.
                        (optional, can skip or enter 'False' if data is
                        unpaired)
  -o <folder>, --map_folder <folder>
                        Location of SQuIRE Map outputs (optional, default =
                        'squire_map')
  -f <folder>, --fetch_folder <folder>
                        Folder location of outputs from SQuIRE Fetch
                        (optional, default = 'squire_fetch'
  -r <int>, --read_length <int>
                        Read length (if trim3 selected, after trimming;
                        required).
  -n <str>, --name <str>
                        Common basename for input files (optional; uses
                        basename of read1 as default)
  -3 <int>, --trim3 <int>
                        Trim <int> bases from right end of each read before
                        alignment (optional; default=0).
  -e <file.txt>, --extra <file.txt>
                        Filepath of text file containing non-reference repeat
                        sequence and genome information
  -b <build>, --build <build>
                        UCSC designation for genome build, eg. 'hg38'
                        (required if more than 1 build in clean_folder)
  -p <int>, --pthreads <int>
                        Launch <int> parallel threads(optional; default='1')
  -v, --verbosity       Want messages and runtime printed to stderr (optional;
                        default=False)
```

## squire_count

### Tool Description
Quantify transposable element expression from the aligned reads (EM-based assignment of multi-mapping reads).

### Metadata
- **Docker Image**: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
- **Homepage**: https://github.com/wyang17/SQuIRE
- **Package**: https://anaconda.org/channels/bioconda/packages/squire/overview
- **Validation**: PASS

### Original Help Text
```text
usage: squire Count [-h] [-m <folder>] [-c <folder>] [-o <folder>]
                    [-t <folder>] [-f <folder>] -r <int> [-n <str>]
                    [-b <build>] [-p <int>] [-s <int>] [-e EM] [-v]

Arguments:
  -h, --help            show this help message and exit
  -m <folder>, --map_folder <folder>
                        Folder location of outputs from SQuIRE Map (optional,
                        default = 'squire_map')
  -c <folder>, --clean_folder <folder>
                        Folder location of outputs from SQuIRE Clean
                        (optional, default = 'squire_clean')
  -o <folder>, --count_folder <folder>
                        Destination folder for output files(optional, default
                        = 'squire_count')
  -t <folder>, --tempfolder <folder>
                        Folder for tempfiles (optional; default=count_folder')
  -f <folder>, --fetch_folder <folder>
                        Folder location of outputs from SQuIRE Fetch
                        (optional, default = 'squire_fetch)'
  -r <int>, --read_length <int>
                        Read length (if trim3 selected, after trimming;
                        required).
  -n <str>, --name <str>
                        Common basename for input files (required if more than
                        one bam file in map_folder)
  -b <build>, --build <build>
                        UCSC designation for genome build, eg. 'hg38'
                        (required if more than 1 build in clean_folder)
  -p <int>, --pthreads <int>
                        Launch <int> parallel threads(optional; default='1')
  -s <int>, --strandedness <int>
                        '0' if unstranded eg Standard Illumina, 1 if first-
                        strand eg Illumina Truseq, dUTP, NSR, NNSR, 2 if
                        second-strand, eg Ligation, Standard SOLiD
                        (optional,default=0)
  -e EM, --EM EM        Run estimation-maximization on TE counts given number
                        of times (optional, specify 0 if no EM desired;
                        default=auto)
  -v, --verbosity       Want messages and runtime printed to stderr (optional;
                        default=False)
```

## squire_call

### Tool Description
Call differentially expressed transposable elements between two groups of samples with DESeq2.

### Metadata
- **Docker Image**: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
- **Homepage**: https://github.com/wyang17/SQuIRE
- **Package**: https://anaconda.org/channels/bioconda/packages/squire/overview
- **Validation**: PASS

### Original Help Text
```text
usage: squire Call [-h] -1 <str1,str2> or <*str*> -2 <str1,str2> or <*str*> -A
                   <str> -B <str> [-i <folder>] [-o <folder>] [-s] [-p <int>]
                   [-N <str>] [-f <str>] [-t] [-v]

Arguments:
  -h, --help            show this help message and exit
  -1 <str1,str2> or <*str*>, --group1 <str1,str2> or <*str*>
                        List of basenames for group1 (Treatment) samples, can
                        also provide string pattern common to all group1
                        basenames
  -2 <str1,str2> or <*str*>, --group2 <str1,str2> or <*str*>
                        List of basenames for group2 (Control) samples, can
                        also provide string pattern common to all group2
                        basenames
  -A <str>, --condition1 <str>
                        Name of condition for group1
  -B <str>, --condition2 <str>
                        Name of condition for group2
  -i <folder>, --count_folder <folder>
                        Folder location of outputs from SQuIRE Count
                        (optional, default = 'squire_count')
  -o <folder>, --call_folder <folder>
                        Destination folder for output files (optional;
                        default='squire_call')
  -s, --subfamily       Compare TE counts by subfamily. Otherwise, compares
                        TEs at locus level (optional; default=False)
  -p <int>, --pthreads <int>
                        Launch <int> parallel threads(optional; default='1')
  -N <str>, --projectname <str>
                        Basename for project, default='SQuIRE'
  -f <str>, --output_format <str>
                        Output figures as html or pdf
  -t, --table_only      Output count table only, don't want to perform
                        differential expression with DESeq2
  -v, --verbosity       Want messages and runtime printed to stderr (optional;
                        default=False)
```

## squire_draw

### Tool Description
Draw RPM-normalized bedgraph tracks of the aligned reads for visualisation.

### Metadata
- **Docker Image**: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
- **Homepage**: https://github.com/wyang17/SQuIRE
- **Package**: https://anaconda.org/channels/bioconda/packages/squire/overview
- **Validation**: PASS

### Original Help Text
```text
usage: squire Draw [-h] [-f <folder>] [-m <folder>] [-o <folder>] [-n <str>]
                   [-s <int>] -b <build> [-l] [-p <int>] [-v]

Arguments:
  -h, --help            show this help message and exit
  -f <folder>, --fetch_folder <folder>
                        Folder location of outputs from SQuIRE Fetch
                        (optional, default = 'squire_fetch')
  -m <folder>, --map_folder <folder>
                        Folder location of outputs from SQuIRE Map (optional,
                        default = 'squire_map')
  -o <folder>, --draw_folder <folder>
                        Destination folder for output files (optional;
                        default='squire_draw')
  -n <str>, --name <str>
                        Basename for bam file (required if more than one bam
                        file in map_folder)
  -s <int>, --strandedness <int>
                        '0' if unstranded, 1 if first-strand eg Illumina
                        Truseq, dUTP, NSR, NNSR, 2 if second-strand, eg
                        Ligation, Standard (optional,default=1)
  -b <build>, --build <build>
                        UCSC designation for genome build, eg. 'hg38'
                        (required)
  -l, --normlib         Normalize bedgraphs by library size (optional;
                        default=False)
  -p <int>, --pthreads <int>
                        Launch <int> parallel threads(optional; default='1')
  -v, --verbosity       Want messages and runtime printed to stderr (optional;
                        default=False)
```

## squire_seek

### Tool Description
Extract the repeat sequences for given genomic coordinates from a genome fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/squire:0.9.9.92--pyhdfd78af_1
- **Homepage**: https://github.com/wyang17/SQuIRE
- **Package**: https://anaconda.org/channels/bioconda/packages/squire/overview
- **Validation**: PASS

### Original Help Text
```text
usage: squire Seek [-h] -i <file.bed> -o <file.fa> -g <file.fa or
                   folder.chromFa> [-v]

Arguments:
  -h, --help            show this help message and exit
  -i <file.bed>, --infile <file.bed>
                        Repeat genomic coordinates, can be TE_ID, bedfile, or
                        gff (required)
  -o <file.fa>, --outfile <file.fa>
                        Repeat sequences output file (FASTA), can use "-" for
                        stdout (required)
  -g <file.fa or folder.chromFa>, --genome <file.fa or folder.chromFa>
                        Genome build's fasta chromosomes - .fa file or
                        .chromFa folder (required)
  -v, --verbosity       Want messages and runtime printed to stderr (optional;
                        default=False)
```

## Metadata
- **Skill**: generated
