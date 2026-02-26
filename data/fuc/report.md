# fuc CWL Generation Report

## fuc_bam-aldepth

### Tool Description
Count allelic depth from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Total Downloads**: 81.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sbslee/fuc
- **Stars**: N/A
### Original Help Text
```text
usage: fuc bam-aldepth [-h] bam sites

Count allelic depth from a BAM file.

Positional arguments:
  bam         Input alignment file.
  sites       TSV file containing two columns, chromosome and position. This
              can also be a BED or VCF file (compressed or uncompressed). 
              Input type will be detected automatically.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Provide sites with a TSV file:
  $ fuc bam-aldepth in.bam sites.tsv > out.tsv

[Example] Provide sites with a VCF file:
  $ fuc bam-aldepth in.bam sites.vcf > out.tsv
```


## fuc_bam-depth

### Tool Description
Compute per-base read depth from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc bam-depth [-h] [-r TEXT [TEXT ...]] [--zero] bams [bams ...]

Compute per-base read depth from BAM files.

Under the hood, the command computes read depth using the 'samtools depth'
command.

Positional arguments:
  bams                  One or more input BAM files. Alternatively, you can
                        provide a text file (.txt, .tsv, .csv, or .list)
                        containing one BAM file per line.

Optional arguments:
  -h, --help            Show this help message and exit.
  -r TEXT [TEXT ...], --regions TEXT [TEXT ...]
                        By default, the command counts all reads in BAM
                        files, which can be excruciatingly slow for large
                        files (e.g. whole genome sequencing). Therefore, use
                        this argument to only output positions in given
                        regions. Each region must have the format
                        chrom:start-end and be a half-open interval with
                        (start, end]. This means, for example, chr1:100-103
                        will extract positions 101, 102, and 103.
                        Alternatively, you can provide a BED file (compressed
                        or uncompressed) to specify regions. Note that the
                        'chr' prefix in contig names (e.g. 'chr1' vs. '1')
                        will be automatically added or removed as necessary
                        to match the input BAM's contig names.
  --zero                Output all positions including those with zero depth.

[Example] Specify regions manually:
  $ fuc bam-depth 1.bam 2.bam \
  -r chr1:100-200 chr2:400-500 > out.tsv

[Example] Specify regions with a BED file:
  $ fuc bam-depth bam.list \
  -r in.bed > out.tsv
```


## fuc_bam-head

### Tool Description
Print the header of a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc bam-head [-h] bam

Print the header of a BAM file.

Positional arguments:
  bam         Input alignment file.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Print the header of a BAM file:
  $ fuc bam-head in.bam
```


## fuc_bam-index

### Tool Description
Index a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc bam-index [-h] bam

Index a BAM file.

Positional arguments:
  bam         Input alignment file.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Index a BAM file:
  $ fuc bam-index in.bam
```


## fuc_bam-rename

### Tool Description
Rename the sample in a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc bam-rename [-h] bam name

Rename the sample in a BAM file.

Positional arguments:
  bam         Input alignment file.
  name        New sample name.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Write a new BAM file after renaming:
  $ fuc bam-rename in.bam NA12878 > out.bam
```


## fuc_bam-slice

### Tool Description
Slice a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc bam-slice [-h] [--format TEXT] [--fasta PATH]
                     bam regions [regions ...]

Slice a BAM file.

Positional arguments:
  bam            Input BAM file. It must be already indexed to allow random
                 access. You can index a BAM file with the bam-index command.
  regions        One or more regions to be sliced. Each region must have the
                 format chrom:start-end and be a half-open interval with
                 (start, end]. This means, for example, chr1:100-103 will
                 extract positions 101, 102, and 103. Alternatively, you can
                 provide a BED file (compressed or uncompressed) to specify
                 regions. Note that the 'chr' prefix in contig names (e.g.
                 'chr1' vs. '1') will be automatically added or removed as
                 necessary to match the input BED's contig names.

Optional arguments:
  -h, --help     Show this help message and exit.
  --format TEXT  Output format (default: 'BAM') (choices: 'SAM', 'BAM',
                 'CRAM').
  --fasta PATH   FASTA file. Required when --format is 'CRAM'.

[Example] Specify regions manually:
  $ fuc bam-slice in.bam 1:100-300 2:400-700 > out.bam

[Example] Speicfy regions with a BED file:
  $ fuc bam-slice in.bam regions.bed > out.bam

[Example] Slice a CRAM file:
  $ fuc bam-slice in.bam regions.bed --format CRAM --fasta ref.fa > out.cram
```


## fuc_bed-intxn

### Tool Description
Find the intersection of BED files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc bed-intxn [-h] bed [bed ...]

Find the intersection of BED files.

Positional arguments:
  bed         Input BED files.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Find the intersection of three BED files:
  $ fuc bed-intxn in1.bed in2.bed in3.bed > out.bed
```


## fuc_bed-sum

### Tool Description
Summarize a BED file.

This command will compute various summary statistics for a BED file. The
returned statistics include the total numbers of probes and covered base
pairs for each chromosome.

By default, covered base pairs are displayed in bp, but if you prefer you
can, for example, use '--bases 1000' to display in kb.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc bed-sum [-h] [--bases INT] [--decimals INT] bed

Summarize a BED file.

This command will compute various summary statistics for a BED file. The
returned statistics include the total numbers of probes and covered base
pairs for each chromosome.

By default, covered base pairs are displayed in bp, but if you prefer you
can, for example, use '--bases 1000' to display in kb.

Positional arguments:
  bed             Input BED file.

Optional arguments:
  -h, --help      Show this help message and exit.
  --bases INT     Number to divide covered base pairs (default: 1).
  --decimals INT  Number of decimals (default: 0).
```


## fuc_cov-concat

### Tool Description
Concatenate depth of coverage files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc cov-concat [-h] [--axis INT] tsv [tsv ...]

Concatenate depth of coverage files.

Positional arguments:
  tsv         Input TSV files.

Optional arguments:
  -h, --help  Show this help message and exit.
  --axis INT  The axis to concatenate along (default: 0) (choices:
              0, 1 where 0 is index and 1 is columns).

[Example] Concatenate vertically:
  $ fuc cov-concat in1.tsv in2.tsv > out.tsv

[Example] Concatenate horizontally:
  $ fuc cov-concat in1.tsv in2.tsv --axis 1 > out.tsv
```


## fuc_cov-rename

### Tool Description
Rename the samples in a depth of coverage file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc cov-rename [-h] [--mode TEXT] [--range INT INT] [--sep TEXT]
                      tsv names

Rename the samples in a depth of coverage file.

There are three different renaming modes using the names file:
  - 'MAP': Default mode. Requires two columns, old names in the first
    and new names in the second.
  - 'INDEX': Requires two columns, new names in the first and 0-based
    indicies in the second.
  - 'RANGE': Requires only one column of new names but --range must
    be specified.

Positional arguments:
  tsv              TSV file (compressed or uncompressed).
  names            Text file containing information for renaming the samples.

Optional arguments:
  -h, --help       Show this help message and exit.
  --mode TEXT      Renaming mode (default: 'MAP') (choices: 'MAP', 
                   'INDEX', 'RANGE').
  --range INT INT  Index range to use when renaming the samples.
                   Applicable only with the 'RANGE' mode.
  --sep TEXT       Delimiter to use when reading the names file
                   (default: '\t').

[Example] Using the default 'MAP' mode:
  $ fuc cov-rename in.tsv old_new.tsv > out.tsv

[Example] Using the 'INDEX' mode:
  $ fuc cov-rename in.tsv new_idx.tsv --mode INDEX > out.tsv

[Example] Using the 'RANGE' mode:
  $ fuc cov-rename in.tsv new_only.tsv --mode RANGE --range 2 5 > out.tsv
```


## fuc_fa-filter

### Tool Description
Filter sequence records in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fa-filter [-h] [--contigs TEXT [TEXT ...]] [--exclude] fasta

Filter sequence records in a FASTA file.

Positional arguments:
  fasta                 Input FASTA file (compressed or uncompressed).

Optional arguments:
  -h, --help            Show this help message and exit.
  --contigs TEXT [TEXT ...]
                        One or more contigs to be selected. Alternatively, you can
                        provide a file containing one contig per line.
  --exclude             Exclude specified contigs.

[Example] Select certain contigs:
  $ fuc fa-filter in.fasta --contigs chr1 chr2 > out.fasta

[Example] Select certain contigs:
  $ fuc fa-filter in.fasta --contigs contigs.list --exclude > out.fasta
```


## fuc_fq-count

### Tool Description
Count sequence reads in FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fq-count [-h] [fastq ...]

Count sequence reads in FASTQ files.

Positional arguments:
  fastq       Input FASTQ files (compressed or uncompressed) (default: stdin).

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] When the input is a FASTQ file:
  $ fuc fq-count in1.fastq in2.fastq

[Example] When the input is stdin:
  $ cat fastq.list | fuc fq-count
```


## fuc_fq-sum

### Tool Description
Summarize a FASTQ file.

This command will output a summary of the input FASTQ file. The summary
includes the total number of sequence reads, the distribution of read
lengths, and the numbers of unique and duplicate sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fq-sum [-h] fastq

Summarize a FASTQ file.

This command will output a summary of the input FASTQ file. The summary
includes the total number of sequence reads, the distribution of read
lengths, and the numbers of unique and duplicate sequences.

Positional arguments:
  fastq       Input FASTQ file (compressed or uncompressed).

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Summarize a FASTQ file:
  $ fuc fq-sum in.fastq
```


## fuc_fuc-bgzip

### Tool Description
Write a BGZF compressed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fuc-bgzip [-h] [file ...]

Write a BGZF compressed file.

BGZF (Blocked GNU Zip Format) is a modified form of gzip compression which
can be applied to any file format to provide compression with efficient
random access. In addition to being required for random access to and writing
of BAM files, the BGZF format can also be used for most of the sequence data
formats (e.g. FASTA, FASTQ, GenBank, VCF, MAF).

Positional arguments:
  file        Input file to be compressed (default: stdin).

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] When the input is a VCF file:
  $ fuc fuc-bgzip in.vcf > out.vcf.gz

[Example] When the input is stdin:
  $ cat in.vcf | fuc fuc-bgzip > out.vcf.gz
```


## fuc_fuc-compf

### Tool Description
Compare the contents of two files.

This command will compare the contents of two files, returning 'True' if they
are identical and 'False' otherwise.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fuc-compf [-h] left right

Compare the contents of two files.

This command will compare the contents of two files, returning 'True' if they
are identical and 'False' otherwise.

Positional arguments:
  left        Input left file.
  right       Input right file.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Compare two files:
  $ fuc fuc-compf left.txt right.txt
```


## fuc_fuc-demux

### Tool Description
Parse the Reports directory from bcl2fastq.

This command will parse, and extract various statistics from, HTML files in
the Reports directory created by the bcl2fastq or bcl2fastq2 prograrm. After
creating an output directory, the command will write the following files:
  - flowcell-summary.csv
  - lane-summary.csv
  - top-unknown-barcodes.csv
  - reports.pdf

Use --sheet to sort samples in the lane-summary.csv file in the same order
as your SampleSheet.csv file. You can also provide a modified version of your
SampleSheet.csv file to subset samples for the lane-summary.csv and
reports.pdf files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fuc-demux [-h] [--sheet PATH] reports output

Parse the Reports directory from bcl2fastq.

This command will parse, and extract various statistics from, HTML files in
the Reports directory created by the bcl2fastq or bcl2fastq2 prograrm. After
creating an output directory, the command will write the following files:
  - flowcell-summary.csv
  - lane-summary.csv
  - top-unknown-barcodes.csv
  - reports.pdf

Use --sheet to sort samples in the lane-summary.csv file in the same order
as your SampleSheet.csv file. You can also provide a modified version of your
SampleSheet.csv file to subset samples for the lane-summary.csv and
reports.pdf files.

Positional arguments:
  reports       Input Reports directory.
  output        Output directory (will be created).

Optional arguments:
  -h, --help    Show this help message and exit.
  --sheet PATH  SampleSheet.csv file. Used for sorting and/or subsetting
                samples.
```


## fuc_fuc-exist

### Tool Description
Check whether certain files exist.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fuc-exist [-h] [files ...]

Check whether certain files exist.

This command will check whether or not specified files including directories
exist, returning 'True' if they exist and 'False' otherwise.

Positional arguments:
  files       Files and directories to be tested (default: stdin).

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Test a file:
  $ fuc fuc-exist in.txt

[Example] Test a directory:
  $ fuc fuc-exist dir

[Example] When the input is stdin:
  $ cat test.list | fuc fuc-exist
```


## fuc_fuc-find

### Tool Description
Retrieve absolute paths of files whose name matches a specified pattern, optionally recursively.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fuc-find [-h] [-r] [-d PATH] pattern

Retrieve absolute paths of files whose name matches a specified pattern,
optionally recursively.

Positional arguments:
  pattern               Filename pattern.

Optional arguments:
  -h, --help            Show this help message and exit.
  -r, --recursive       Turn on recursive retrieving.
  -d PATH, --directory PATH
                        Directory to search in (default: current directory).

[Example] Retrieve VCF files in the current directory only:
  $ fuc fuc-find "*.vcf"

[Example] Retrieve VCF files recursively:
  $ fuc fuc-find "*.vcf" -r

[Example] Retrieve VCF files in a specific directory:
  $ fuc fuc-find "*.vcf" -d /path/to/dir
```


## fuc_fuc-undetm

### Tool Description
Compute top unknown barcodes using undertermined FASTQ from bcl2fastq.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc fuc-undetm [-h] [--count INT] fastq

Compute top unknown barcodes using undertermined FASTQ from bcl2fastq.

This command will compute top unknown barcodes using undertermined FASTQ from
the bcl2fastq or bcl2fastq2 prograrm.

Positional arguments:
  fastq        Undertermined FASTQ (compressed or uncompressed).

Optional arguments:
  -h, --help   Show this help message and exit.
  --count INT  Number of top unknown barcodes to return (default: 30).

[Example] Compute top unknown barcodes:
  $ fuc fuc-undetm Undetermined_S0_R1_001.fastq.gz
```


## fuc_maf-maf2vcf

### Tool Description
Convert a MAF file to a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc maf-maf2vcf [-h] [--fasta PATH] [--ignore_indels]
                       [--cols TEXT [TEXT ...]] [--names TEXT [TEXT ...]]
                       maf

Convert a MAF file to a VCF file.

In order to handle INDELs the command makes use of a reference assembly (i.e.
FASTA file). If SNVs are your only concern, then you do not need a FASTA file
and can just use --ignore_indels.

If you are going to provide a FASTA file, please make sure to select the
appropriate one (e.g. one that matches the genome assembly).

In addition to basic genotype calls (e.g. '0/1'), you can extract more
information from the MAF file by specifying the column(s) that contain
additional genotype data of interest with the '--cols' argument. If provided,
this argument will append the requested data to individual sample genotypes
(e.g. '0/1:0.23').

You can also control how these additional genotype information appear in the
FORMAT field (e.g. AF) with the '--names' argument. If this argument is not
provided, the original column name(s) will be displayed.

Positional arguments:
  maf                   MAF file (compressed or uncompressed).

Optional arguments:
  -h, --help            Show this help message and exit.
  --fasta PATH          FASTA file (required to include INDELs in the output).
  --ignore_indels       Use this flag to exclude INDELs from the output.
  --cols TEXT [TEXT ...]
                        Column(s) in the MAF file.
  --names TEXT [TEXT ...]
                        Name(s) to be displayed in the FORMAT field.

[Example] Convert both SNVs and indels:
  $ fuc maf-maf2vcf in.maf --fasta hs37d5.fa > out.vcf

[Example] Convert SNVs only:
  $ fuc maf-maf2vcf in.maf --ignore_indels > out.vcf

[Example] Extract AF field:
  $ fuc maf-maf2vcf \
  in.maf \
  --fasta hs37d5.fa \
  --cols i_TumorVAF_WU \
  --names AF > out.vcf
```


## fuc_maf-oncoplt

### Tool Description
Create an oncoplot with a MAF file.
The format of output image (PDF/PNG/JPEG/SVG) will be automatically
determined by the output file's extension.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc maf-oncoplt [-h] [--count INT] [--figsize FLOAT FLOAT]
                       [--label_fontsize FLOAT] [--ticklabels_fontsize FLOAT]
                       [--legend_fontsize FLOAT]
                       maf out

Create an oncoplot with a MAF file.

The format of output image (PDF/PNG/JPEG/SVG) will be automatically
determined by the output file's extension.

Positional arguments:
  maf                   Input MAF file.
  out                   Output image file.

Optional arguments:
  -h, --help            Show this help message and exit.
  --count INT           Number of top mutated genes to display (default: 10).
  --figsize FLOAT FLOAT
                        Width, height in inches (default: [15, 10]).
  --label_fontsize FLOAT
                        Font size of labels (default: 15).
  --ticklabels_fontsize FLOAT
                        Font size of tick labels (default: 15).
  --legend_fontsize FLOAT
                        Font size of legend texts (default: 15).

[Example] Output a PNG file:
  $ fuc maf-oncoplt in.maf out.png

[Example] Output a PDF file:
  $ fuc maf-oncoplt in.maf out.pdf
```


## fuc_maf-sumplt

### Tool Description
Create a summary plot with a MAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc maf-sumplt [-h] [--figsize FLOAT FLOAT] [--title_fontsize FLOAT]
                      [--ticklabels_fontsize FLOAT] [--legend_fontsize FLOAT]
                      maf out

Create a summary plot with a MAF file.

The format of output image (PDF/PNG/JPEG/SVG) will be automatically
determined by the output file's extension.

Positional arguments:
  maf                   Input MAF file.
  out                   Output image file.

Optional arguments:
  -h, --help            Show this help message and exit.
  --figsize FLOAT FLOAT
                        Width, height in inches (default: [15, 10]).
  --title_fontsize FLOAT
                        Font size of subplot titles (default: 16).
  --ticklabels_fontsize FLOAT
                        Font size of tick labels (default: 12).
  --legend_fontsize FLOAT
                        Font size of legend texts (default: 12).

[Example] Output a PNG file:
  $ fuc maf-sumplt in.maf out.png

[Example] Output a PNG file:
  $ fuc maf-sumplt in.maf out.pdf
```


## fuc_maf-vcf2maf

### Tool Description
Convert a VCF file to a MAF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc maf-vcf2maf [-h] vcf

Convert a VCF file to a MAF file.

Positional arguments:
  vcf         Annotated VCF file.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Convert VCF to MAF:
  $ fuc maf-vcf2maf in.vcf > out.maf
```


## fuc_ngs-bam2fq

### Tool Description
Pipeline for converting BAM files to FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc ngs-bam2fq [-h] [--thread INT] [--qsub TEXT] [--force]
                      manifest output

Pipeline for converting BAM files to FASTQ files.

This pipeline assumes that input BAM files consist of paired-end reads, and
will output two zipped FASTQ files for each sample (forward and reverse
reads). That is, SAMPLE.bam will produce SAMPLE_R1.fastq.gz and
SAMPLE_R2.fastq.gz.

By default, the pipeline will be run in a local environment. Use --qsub to
leverage a parallel environment, in which case SGE is required.

External dependencies:
  - [Required] SAMtools: Required for BAM to FASTQ conversion.
  - [Optional] SGE: Required for job submission (i.e. qsub).

Manifest columns:
  - [Required] BAM: Input BAM file.

Positional arguments:
  manifest      Sample manifest CSV file.
  output        Output directory.

Optional arguments:
  -h, --help    Show this help message and exit.
  --thread INT  Number of threads to use (default: 1).
  --qsub TEXT   SGE resoruce to request with qsub for BAM to FASTQ
                conversion. Since this oppoeration supports multithreading,
                it is recommended to speicfy a parallel environment (PE)
                to speed up the process (also see --thread).
  --force       Overwrite the output directory if it already exists.

[Example] Run in local environment:
  $ fuc ngs-bam2fq \
  manifest.csv \
  output_dir \
  --thread 10
  $ sh output_dir/shell/runme.sh

[Example] Run in parallel environment with specific queue:
  $ fuc ngs-bam2fq \
  manifest.csv \
  output_dir \
  --qsub "-q queue_name -pe pe_name 10" \
  --thread 10
  $ sh output_dir/shell/runme.sh

[Example] Run in parallel environment with specific nodes:
  $ fuc ngs-bam2fq \
  manifest.csv \
  output_dir \
  --qsub "-l h='node_A|node_B' -pe pe_name 10" \
  --thread 10
  $ sh output_dir/shell/runme.sh
```


## fuc_ngs-fq2bam

### Tool Description
Pipeline for converting FASTQ files to analysis-ready BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc ngs-fq2bam [-h] [--qsub TEXT] [--bed PATH] [--thread INT]
                      [--platform TEXT] [--job TEXT] [--force] [--keep]
                      manifest fasta output java vcf [vcf ...]

Pipeline for converting FASTQ files to analysis-ready BAM files.

Here, "analysis-ready" means that the final BAM files are: 1) aligned to a
reference genome, 2) sorted by genomic coordinate, 3) marked for duplicate
reads, 4) recalibrated by BQSR model, and 5) ready for downstream analyses
such as variant calling.

By default, the pipeline will be run in a local environment. Use --qsub to
leverage a parallel environment, in which case SGE is required.

External dependencies:
  - [Required] BWA: Required for read alignment (i.e. BWA-MEM).
  - [Required] SAMtools: Required for sorting and indexing BAM files.
  - [Required] GATK: Required for marking duplicate reads and recalibrating BAM files.
  - [Optional] SGE: Required for job submission (i.e. qsub).

Manifest columns:
  - Name: Sample name.
  - Read1: Path to forward FASTA file.
  - Read2: Path to reverse FASTA file.

Positional arguments:
  manifest         Sample manifest CSV file.
  fasta            Reference FASTA file.
  output           Output directory.
  java             Java resoruce to request for GATK.
  vcf              One or more reference VCF files containing known variant
                   sites (e.g. 1000 Genomes Project).

Optional arguments:
  -h, --help       Show this help message and exit.
  --qsub TEXT      SGE resoruce to request for qsub.
  --bed PATH       BED file.
  --thread INT     Number of threads to use (default: 1).
  --platform TEXT  Sequencing platform (default: 'Illumina').
  --job TEXT       Job submission ID for SGE.
  --force          Overwrite the output directory if it already exists.
  --keep           Keep temporary files.

[Example] Run in local environment:
  $ fuc ngs-fq2bam \
  manifest.csv \
  ref.fa \
  output_dir \
  "-Xmx15g -Xms15g" \
  1.vcf 2.vcf 3.vcf \
  --thread 10
  $ sh output_dir/shell/runme.sh

[Example] Run in parallel environment with specific queue:
  $ fuc ngs-fq2bam \
  manifest.csv \
  ref.fa \
  output_dir \
  "-Xmx15g -Xms15g" \
  1.vcf 2.vcf 3.vcf \
  --qsub "-q queue_name -pe pe_name 10" \
  --thread 10
  $ sh output_dir/shell/runme.sh

[Example] Run in parallel environment with specific nodes:
  $ fuc ngs-fq2bam \
  manifest.csv \
  ref.fa \
  output_dir \
  "-Xmx15g -Xms15g" \
  1.vcf 2.vcf 3.vcf \
  --qsub "-l h='node_A|node_B' -pe pe_name 10" \
  --thread 10
  $ sh output_dir/shell/runme.sh
```


## fuc_ngs-hc

### Tool Description
Pipeline for germline short variant discovery.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc ngs-hc [-h] [--bed PATH] [--dbsnp PATH] [--thread INT]
                  [--batch INT] [--job TEXT] [--force] [--keep] [--posix]
                  manifest fasta output qsub java1 java2

Pipeline for germline short variant discovery.

External dependencies:
  - SGE: Required for job submission (i.e. qsub).
  - GATK: Required for variant calling (i.e. HaplotypeCaller) and filtration.

Manifest columns:
  - BAM: Recalibrated BAM file.

Positional arguments:
  manifest      Sample manifest CSV file.
  fasta         Reference FASTA file.
  output        Output directory.
  qsub          SGE resoruce to request for qsub.
  java1         Java resoruce to request for single-sample variant calling.
  java2         Java resoruce to request for joint variant calling.

Optional arguments:
  -h, --help    Show this help message and exit.
  --bed PATH    BED file.
  --dbsnp PATH  VCF file from dbSNP.
  --thread INT  Number of threads to use (default: 1).
  --batch INT   Batch size used for GenomicsDBImport (default: 0). This
                controls the number of samples for which readers are
                open at once and therefore provides a way to minimize
                memory consumption. The size of 0 means no batching (i.e.
                readers for all samples will be opened at once).
  --job TEXT    Job submission ID for SGE.
  --force       Overwrite the output directory if it already exists.
  --keep        Keep temporary files.
  --posix       Set GenomicsDBImport to allow for optimizations to improve
                the usability and performance for shared Posix Filesystems
                (e.g. NFS, Lustre). If set, file level locking is disabled
                and file system writes are minimized by keeping a higher
                number of file descriptors open for longer periods of time.
                Use with --batch if keeping a large number of file
                descriptors open is an issue.

[Example] Specify queue:
  $ fuc ngs-hc \
  manifest.csv \
  ref.fa \
  output_dir \
  "-q queue_name" \
  "-Xmx15g -Xms15g" \
  "-Xmx30g -Xms30g" \
  --dbsnp dbSNP.vcf

[Example] Specify nodes:
  $ fuc ngs-hc \
  manifest.csv \
  ref.fa \
  output_dir \
  "-l h='node_A|node_B'" \
  "-Xmx15g -Xms15g" \
  "-Xmx30g -Xms30g" \
  --bed in.bed
```


## fuc_ngs-m2

### Tool Description
Pipeline for somatic short variant discovery.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc ngs-m2 [-h] [--bed PATH] [--force] [--keep]
                  manifest fasta output pon germline qsub java

Pipeline for somatic short variant discovery.

External dependencies:
  - SGE: Required for job submission (i.e. qsub).
  - GATK: Required for variant calling (i.e. Mutect2) and filtration.

Manifest columns:
  - Tumor: Recalibrated BAM file for tumor.
  - Normal: Recalibrated BAM file for matched normal.

Positional arguments:
  manifest    Sample manifest CSV file.
  fasta       Reference FASTA file.
  output      Output directory.
  pon         PoN VCF file.
  germline    Germline VCF file.
  qsub        SGE resoruce to request for qsub.
  java        Java resoruce to request for GATK.

Optional arguments:
  -h, --help  Show this help message and exit.
  --bed PATH  BED file.
  --force     Overwrite the output directory if it already exists.
  --keep      Keep temporary files.
```


## fuc_ngs-pon

### Tool Description
Pipeline for constructing a panel of normals (PoN).

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc ngs-pon [-h] [--bed PATH] [--force] [--keep]
                   manifest fasta output qsub java

Pipeline for constructing a panel of normals (PoN).

Dependencies:
  - GATK: Required for constructing PoN.

Manifest columns:
  - BAM: Path to recalibrated BAM file.

Positional arguments:
  manifest    Sample manifest CSV file.
  fasta       Reference FASTA file.
  output      Output directory.
  qsub        SGE resoruce to request for qsub.
  java        Java resoruce to request for GATK.

Optional arguments:
  -h, --help  Show this help message and exit.
  --bed PATH  BED file.
  --force     Overwrite the output directory if it already exists.
  --keep      Keep temporary files.

[Example] Specify queue:
  $ fuc ngs-pon \
  manifest.csv \
  ref.fa \
  output_dir \
  "-q queue_name" \
  "-Xmx15g -Xms15g"

[Example] Specify nodes:
  $ fuc ngs-pon \
  manifest.csv \
  ref.fa \
  output_dir \
  "-l h='node_A|node_B'" \
  "-Xmx15g -Xms15g"
```


## fuc_ngs-quant

### Tool Description
Pipeline for running RNAseq quantification from FASTQ files with Kallisto.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc ngs-quant [-h] [--thread INT] [--bootstrap INT] [--job TEXT]
                     [--force] [--posix] [--stranded TEXT]
                     manifest index output qsub

Pipeline for running RNAseq quantification from FASTQ files with Kallisto.

External dependencies:
  - SGE: Required for job submission (i.e. qsub).
  - kallisto: Required for RNAseq quantification.

Manifest columns:
  - Name: Sample name.
  - Read1: Path to forward FASTA file.
  - Read2: Path to reverse FASTA file.

Positional arguments:
  manifest         Sample manifest CSV file.
  index            Kallisto index file.
  output           Output directory.
  qsub             SGE resoruce to request for qsub.

Optional arguments:
  -h, --help       Show this help message and exit.
  --thread INT     Number of threads to use (default: 1).
  --bootstrap INT  Number of bootstrap samples (default: 50).
  --job TEXT       Job submission ID for SGE.
  --force          Overwrite the output directory if it already exists.
  --posix          Set the environment variable HDF5_USE_FILE_LOCKING=FALSE
                   before running Kallisto. This is required for shared Posix
                   Filesystems (e.g. NFS, Lustre).
  --stranded TEXT  Strand specific reads (default: 'none') (choices:
                   'none', 'forward', 'reverse').

[Example] Specify queue:
  $ fuc ngs-quant \
  manifest.csv \
  transcripts.idx \
  output_dir \
  "-q queue_name -pe pe_name 10" \
  --thread 10
```


## fuc_ngs-trim

### Tool Description
Pipeline for trimming adapters from FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc ngs-trim [-h] [--thread INT] [--job TEXT] [--force]
                    manifest output qsub

Pipeline for trimming adapters from FASTQ files.

External dependencies:
  - SGE: Required for job submission (i.e. qsub).
  - cutadapt: Required for trimming adapters.

Manifest columns:
  - Name: Sample name.
  - Read1: Path to forward FASTA file.
  - Read2: Path to reverse FASTA file.

Positional arguments:
  manifest      Sample manifest CSV file.
  output        Output directory.
  qsub          SGE resoruce to request for qsub.

Optional arguments:
  -h, --help    Show this help message and exit.
  --thread INT  Number of threads to use (default: 1).
  --job TEXT    Job submission ID for SGE.
  --force       Overwrite the output directory if it already exists.

[Example] Specify queue:
  $ fuc ngs-trim \
  manifest.csv \
  output_dir \
  "-q queue_name -pe pe_name 10" \
  --thread 10
```


## fuc_tabix-index

### Tool Description
Index a GFF/BED/SAM/VCF file with Tabix.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc tabix-index [-h] [--force] file

Index a GFF/BED/SAM/VCF file with Tabix.

The Tabix program is used to index a TAB-delimited genome position file
(GFF/BED/SAM/VCF) and create an index file (.tbi). The input data file must
be position sorted and compressed by bgzip.

Positional arguments:
  file        File to be indexed.

Optional arguments:
  -h, --help  Show this help message and exit.
  --force     Force to overwrite the index file if it is present.

[Example] Index a GFF file:
  $ fuc tabix-index in.gff.gz

[Example] Index a BED file:
  $ fuc tabix-index in.bed.gz

[Example] Index a SAM file:
  $ fuc tabix-index in.sam.gz

[Example] Index a VCF file:
  $ fuc tabix-index in.vcf.gz
```


## fuc_tabix-slice

### Tool Description
Slice a GFF/BED/SAM/VCF file with Tabix.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc tabix-slice [-h] file regions [regions ...]

Slice a GFF/BED/SAM/VCF file with Tabix.

After creating an index file (.tbi), the Tabix program is able to quickly
retrieve data lines overlapping regions specified in the format
'chr:start-end'. Coordinates specified in this region format are 1-based and
inclusive.

Positional arguments:
  file        File to be sliced.
  regions     One or more regions.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Slice a VCF file:
  $ fuc tabix-slice in.vcf.gz chr1:100-200 > out.vcf
```


## fuc_tbl-merge

### Tool Description
Merge two table files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc tbl-merge [-h] [--how TEXT] [--on TEXT [TEXT ...]] [--lsep TEXT]
                     [--rsep TEXT] [--osep TEXT]
                     left right

Merge two table files.

This command will merge two table files using one or more shared columns.
The command essentially wraps the 'pandas.DataFrame.merge' method from the
pandas package. For details on the merging algorithms, please visit the
method's documentation page.

Positional arguments:
  left                  Input left file.
  right                 Input right file.

Optional arguments:
  -h, --help            Show this help message and exit.
  --how TEXT            Type of merge to be performed (default: 'inner')
                        (choices: 'left', 'right', 'outer', 'inner', 'cross').
  --on TEXT [TEXT ...]  Column names to join on.
  --lsep TEXT           Delimiter to use for the left file (default: '\t').
  --rsep TEXT           Delimiter to use for the right file (default: '\t').
  --osep TEXT           Delimiter to use for the output file (default: '\t').

[Example] Merge two tables:
  $ fuc tbl-merge left.tsv right.tsv > merged.tsv

[Example] When the left table is a CSV:
  $ fuc tbl-merge left.csv right.tsv --lsep , > merged.tsv

[Example] Merge with the outer algorithm:
  $ fuc tbl-merge left.tsv right.tsv --how outer > merged.tsv
```


## fuc_tbl-sum

### Tool Description
Summarize a table file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc tbl-sum [-h] [--sep TEXT] [--skiprows TEXT]
                   [--na_values TEXT [TEXT ...]] [--keep_default_na]
                   [--expr TEXT] [--columns TEXT [TEXT ...]] [--dtypes PATH]
                   table_file

Summarize a table file.

Positional arguments:
  table_file            Table file.

Optional arguments:
  -h, --help            Show this help message and exit.
  --sep TEXT            Delimiter to use (default: '\t').
  --skiprows TEXT       Comma-separated line numbers to skip (0-indexed) or
                        number of lines to skip at the start of the file
                        (e.g. `--skiprows 1,` will skip the second line,
                        `--skiprows 2,4` will skip the third and fifth lines,
                        and `--skiprows 10` will skip the first 10 lines).
  --na_values TEXT [TEXT ...]
                        Additional strings to recognize as NA/NaN (by
                        default, the following values are interpreted
                        as NaN: '', '#N/A', '#N/A N/A', '#NA', '-1.#IND',
                        '-1.#QNAN', '-NaN', '-nan', '1.#IND', '1.#QNAN',
                        '<NA>', 'N/A', 'NA', 'NULL', 'NaN', 'n/a', 'nan',
                        'null').
  --keep_default_na     Whether or not to include the default NaN values when
                        parsing the data (see 'pandas.read_table' for details).
  --expr TEXT           Query the columns of a pandas.DataFrame with a
                        boolean expression (e.g. `--query "A == 'yes'"`).
  --columns TEXT [TEXT ...]
                        Columns to be summarized (by default, all columns
                        will be included).
  --dtypes PATH         File of column names and their data types (either
                        'categorical' or 'numeric'); one tab-delimited pair of
                        column name and data type per line.

[Example] Summarize a table:
  $ fuc tbl-sum table.tsv
```


## fuc_vcf-call

### Tool Description
Call SNVs and indels from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-call [-h] [-r TEXT [TEXT ...]] [--min-mq INT] [--max-depth INT]
                    [--dir-path PATH] [--gap_frac FLOAT]
                    [--group-samples PATH]
                    fasta bams [bams ...]

Call SNVs and indels from BAM files.

Under the hood, the command utilizes the bcftool program to call variants.

Positional arguments:
  fasta                 Reference FASTA file.
  bams                  One or more input BAM files. Alternatively, you can
                        provide a text file (.txt, .tsv, .csv, or .list)
                        containing one BAM file per line.

Optional arguments:
  -h, --help            Show this help message and exit.
  -r TEXT [TEXT ...], --regions TEXT [TEXT ...]
                        By default, the command looks at each genomic
                        position with coverage in BAM files, which can be
                        excruciatingly slow for large files (e.g. whole
                        genome sequencing). Therefore, use this argument to
                        only call variants in given regions. Each region must
                        have the format chrom:start-end and be a half-open
                        interval with (start, end]. This means, for example,
                        chr1:100-103 will extract positions 101, 102, and
                        103. Alternatively, you can provide a BED file
                        (compressed or uncompressed) to specify regions. Note
                        that the 'chr' prefix in contig names (e.g. 'chr1'
                        vs. '1') will be automatically added or removed as
                        necessary to match the input BAM's contig names.
  --min-mq INT          Minimum mapping quality for an alignment to be used
                        (default: 1).
  --max-depth INT       At a position, read maximally this number of reads
                        per input file (default: 250).
  --dir-path PATH       By default, intermediate files (likelihoods.bcf,
                        calls.bcf, and calls.normalized.bcf) will be stored
                        in a temporary directory, which is automatically
                        deleted after creating final VCF. If you provide a
                        directory path, intermediate files will be stored
                        there.
  --gap_frac FLOAT      Minimum fraction of gapped reads for calling indels
                        (default: 0.002).
  --group-samples PATH  By default, all samples are assumed to come from a
                        single population. This option allows to group
                        samples into populations and apply the HWE assumption
                        within but not across the populations. To use this
                        option, provide a tab-delimited text file with sample
                        names in the first column and group names in the
                        second column. If '--group-samples -' is given
                        instead, no HWE assumption is made at all and
                        single-sample calling is performed. Note that in low
                        coverage data this inflates the rate of false
                        positives. Therefore, make sure you know what you are
                        doing.

[Example] Specify regions manually:
  $ fuc vcf-call ref.fa 1.bam 2.bam \
  -r chr1:100-200 chr2:400-500 > out.vcf

[Example] Specify regions with a BED file:
  $ fuc vcf-call ref.fa bam.list \
  -r in.bed > out.vcf
```


## fuc_vcf-filter

### Tool Description
Filter a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-filter [-h] [--expr TEXT] [--samples PATH]
                      [--drop_duplicates [TEXT ...]] [--greedy] [--opposite]
                      [--filter_empty]
                      vcf

Filter a VCF file.

Positional arguments:
  vcf                   VCF file (compressed or uncompressed).

Optional arguments:
  -h, --help            Show this help message and exit.
  --expr TEXT           Expression to evaluate.
  --samples PATH        File of sample names to apply the marking (one
                        sample per line).
  --drop_duplicates [TEXT ...]
                        Only consider certain columns for identifying
                        duplicates, by default use all of the columns.
  --greedy              Use this flag to mark even ambiguous genotypes
                        as missing.
  --opposite            Use this flag to mark all genotypes that do not
                        satisfy the query expression as missing and leave
                        those that do intact.
  --filter_empty        Use this flag to remove rows with no genotype
                        calls at all.

[Example] Mark genotypes with 0/0 as missing:
  $ fuc vcf-filter in.vcf --expr 'GT == "0/0"' > out.vcf

[Example] Mark genotypes that are not 0/0 as missing:
  $ fuc vcf-filter in.vcf --expr 'GT != "0/0"' > out.vcf

[Example] Mark genotypes whose DP is less than 30 as missing:
  $ fuc vcf-filter in.vcf --expr 'DP < 30' > out.vcf

[Example] Same as above, but also mark ambiguous genotypes as missing:
  $ fuc vcf-filter in.vcf --expr 'DP < 30' --greedy > out.vcf

[Example] Build a complex query to select genotypes to be marked missing:
  $ fuc vcf-filter in.vcf --expr 'AD[1] < 10 or DP < 30' --opposite > out.vcf

[Example] Compute summary statistics and subset samples:
  $ fuc vcf-filter in.vcf \
  --expr 'np.mean(AD) < 10' --greedy --samples sample.list > out.vcf

[Example] Drop duplicate rows:
  $ fuc vcf-filter in.vcf --drop_duplicates CHROM POS REF ALT > out.vcf

[Example] Filter out rows without genotypes:
  $ fuc vcf-filter in.vcf --filter_empty > out.vcf
```


## fuc_vcf-index

### Tool Description
Index a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-index [-h] [--force] vcf

Index a VCF file.

This command will create an index file (.tbi) for the input VCF.

Positional arguments:
  vcf         Input VCF file to be indexed. When an uncompressed file is
              given, the command will automatically create a BGZF
              compressed copy of the file (.gz) before indexing.

Optional arguments:
  -h, --help  Show this help message and exit.
  --force     Force to overwrite the index file if it is already present.

[Example] Index a compressed VCF file:
  $ fuc vcf-index in.vcf.gz

[Example] Index an uncompressed VCF file (will create a compressed VCF first):
  $ fuc vcf-index in.vcf
```


## fuc_vcf-merge

### Tool Description
Merge two or more VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-merge [-h] [--how TEXT] [--format TEXT] [--sort] [--collapse]
                     vcf_files [vcf_files ...]

Merge two or more VCF files.

Positional arguments:
  vcf_files      VCF files (compressed or uncompressed). Note that the 'chr'
                 prefix in contig names (e.g. 'chr1' vs. '1') will be
                 automatically added or removed as necessary to match the
                 contig names of the first VCF.

Optional arguments:
  -h, --help     Show this help message and exit.
  --how TEXT     Type of merge as defined in pandas.DataFrame.merge
                 (default: 'inner').
  --format TEXT  FORMAT subfields to be retained (e.g. 'GT:AD:DP')
                 (default: 'GT').
  --sort         Use this flag to turn off sorting of records
                 (default: True).
  --collapse     Use this flag to collapse duplicate records
                 (default: False).

[Example] Merge multiple VCF files:
  $ fuc vcf-merge 1.vcf 2.vcf 3.vcf > merged.vcf

[Example] Keep the GT, AD, DP fields:
  $ fuc vcf-merge 1.vcf 2.vcf --format GT:AD:DP > merged.vcf
```


## fuc_vcf-rename

### Tool Description
Rename the samples in a VCF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-rename [-h] [--mode TEXT] [--range INT INT] [--sep TEXT]
                      vcf names

Rename the samples in a VCF file.

There are three different renaming modes using the 'names' file:
  - 'MAP': Default mode. Requires two columns, old names in the first
    and new names in the second.
  - 'INDEX': Requires two columns, new names in the first and 0-based
    indicies in the second.
  - 'RANGE': Requires only one column of new names but '--range' must
    be specified.

Positional arguments:
  vcf              VCF file (compressed or uncompressed).
  names            Text file containing information for renaming the samples.

Optional arguments:
  -h, --help       Show this help message and exit.
  --mode TEXT      Renaming mode (default: 'MAP') (choices: 'MAP',
                   'INDEX', 'RANGE').
  --range INT INT  Index range to use when renaming the samples.
                   Applicable only with the 'RANGE' mode.
  --sep TEXT       Delimiter to use for reading the 'names' file 
                   (default: '\t').

[Example] Using the default 'MAP' mode:
  $ fuc vcf-rename in.vcf old_new.tsv > out.vcf

[Example] Using the 'INDEX' mode:
  $ fuc vcf-rename in.vcf new_idx.tsv --mode INDEX > out.vcf

[Example] Using the 'RANGE' mode:
  $ fuc vcf-rename in.vcf new_only.tsv --mode RANGE --range 2 5 > out.vcf
```


## fuc_vcf-slice

### Tool Description
Slice a VCF file for specified regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-slice [-h] vcf regions [regions ...]

Slice a VCF file for specified regions.

Positional arguments:
  vcf         Input VCF file must be already BGZF compressed (.gz) and
              indexed (.tbi) to allow random access. A VCF file can be
              compressed with the fuc-bgzip command and indexed with the
              vcf-index command.
  regions     One or more regions to be sliced. Each region must have the
              format chrom:start-end and be a half-open interval with
              (start, end]. This means, for example, chr1:100-103 will
              extract positions 101, 102, and 103. Alternatively, you can
              provide a BED file (compressed or uncompressed) to specify
              regions. Note that the 'chr' prefix in contig names (e.g.
              'chr1' vs. '1') will be automatically added or removed as
              necessary to match the input VCF's contig names.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Specify regions manually:
  $ fuc vcf-slice in.vcf.gz 1:100-300 2:400-700 > out.vcf

[Example] Speicfy regions with a BED file:
  $ fuc vcf-slice in.vcf.gz regions.bed > out.vcf

[Example] Output a compressed file:
  $ fuc vcf-slice in.vcf.gz regions.bed | fuc fuc-bgzip > out.vcf.gz
```


## fuc_vcf-split

### Tool Description
Split a VCF file by individual.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-split [-h] [--clean] [--force] vcf output

Split a VCF file by individual.

Positional arguments:
  vcf         VCF file to be split.
  output      Output directory.

Optional arguments:
  -h, --help  Show this help message and exit.
  --clean     By default, the command will only return variants present in
              each individual. Use the tag to stop this behavior and make
              sure that all individuals have the same number of variants.
  --force     Overwrite the output directory if it already exists.

[Example] Split a VCF file by individual:
  $ fuc vcf-split in.vcf output_dir
```


## fuc_vcf-vcf2bed

### Tool Description
Convert a VCF file to a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-vcf2bed [-h] vcf

Convert a VCF file to a BED file.

Positional arguments:
  vcf         VCF file (compressed or uncompressed).

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Convert VCF to BED:
  $ fuc vcf-vcf2bed in.vcf > out.bed
```


## fuc_vcf-vep

### Tool Description
Filter a VCF file by annotations from Ensembl VEP.

### Metadata
- **Docker Image**: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
- **Homepage**: https://github.com/sbslee/fuc
- **Package**: https://anaconda.org/channels/bioconda/packages/fuc/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fuc vcf-vep [-h] [--opposite] [--as_zero] vcf expr

Filter a VCF file by annotations from Ensembl VEP.

Positional arguments:
  vcf         VCF file annotated by Ensembl VEP (compressed or uncompressed).
  expr        Query expression to evaluate.

Optional arguments:
  -h, --help  Show this help message and exit.
  --opposite  Use this flag to return only records that don't
              meet the said criteria.
  --as_zero   Use this flag to treat missing values as zero instead of NaN.

[Example] Select variants in the TP53 gene:
  $ fuc vcf-vep in.vcf "SYMBOL == 'TP53'" > out.vcf

[Example] Exclude variants from the TP53 gene:
  $ fuc vcf-vep in.vcf "SYMBOL != 'TP53'" > out.vcf

[Example] Same as above:
  $ fuc vcf-vep in.vcf "SYMBOL == 'TP53'" --opposite > out.vcf

[Example] Select splice donor or stop-gain variants:
  $ fuc vcf-vep in.vcf \
  "Consequence in ['splice_donor_variant', 'stop_gained']" > out.vcf

[Example] Build a complex query to select specific variants:
  $ fuc vcf-vep in.vcf \
  "(SYMBOL == 'TP53') and (Consequence.str.contains('stop_gained'))" > out.vcf

[Example] Select variants whose gnomAD AF is less than 0.001:
  $ fuc vcf-vep in.vcf "gnomAD_AF < 0.001" > out.vcf

[Example] Variants without AF data will be treated as having AF of 0:
  $ fuc vcf-vep in.vcf "gnomAD_AF < 0.001" --as_zero > out.vcf
```

