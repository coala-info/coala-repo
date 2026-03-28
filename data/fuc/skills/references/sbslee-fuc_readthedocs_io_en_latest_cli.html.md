[fuc](index.html)

latest

Contents:

* [README](readme.html)
* [Glossary](glossary.html)
* CLI
  + [Introduction](#introduction)
  + [bam-aldepth](#bam-aldepth)
  + [bam-depth](#bam-depth)
  + [bam-head](#bam-head)
  + [bam-index](#bam-index)
  + [bam-rename](#bam-rename)
  + [bam-slice](#bam-slice)
  + [bed-intxn](#bed-intxn)
  + [bed-sum](#bed-sum)
  + [cov-concat](#cov-concat)
  + [cov-rename](#cov-rename)
  + [fa-filter](#fa-filter)
  + [fq-count](#fq-count)
  + [fq-sum](#fq-sum)
  + [fuc-bgzip](#fuc-bgzip)
  + [fuc-compf](#fuc-compf)
  + [fuc-demux](#fuc-demux)
  + [fuc-exist](#fuc-exist)
  + [fuc-find](#fuc-find)
  + [fuc-undetm](#fuc-undetm)
  + [maf-maf2vcf](#maf-maf2vcf)
  + [maf-oncoplt](#maf-oncoplt)
  + [maf-sumplt](#maf-sumplt)
  + [maf-vcf2maf](#maf-vcf2maf)
  + [ngs-bam2fq](#ngs-bam2fq)
  + [ngs-fq2bam](#ngs-fq2bam)
  + [ngs-hc](#ngs-hc)
  + [ngs-m2](#ngs-m2)
  + [ngs-pon](#ngs-pon)
  + [ngs-quant](#ngs-quant)
  + [ngs-trim](#ngs-trim)
  + [tabix-index](#tabix-index)
  + [tabix-slice](#tabix-slice)
  + [tbl-merge](#tbl-merge)
  + [tbl-sum](#tbl-sum)
  + [vcf-call](#vcf-call)
  + [vcf-filter](#vcf-filter)
  + [vcf-index](#vcf-index)
  + [vcf-merge](#vcf-merge)
  + [vcf-rename](#vcf-rename)
  + [vcf-slice](#vcf-slice)
  + [vcf-split](#vcf-split)
  + [vcf-vcf2bed](#vcf-vcf2bed)
  + [vcf-vep](#vcf-vep)
* [API](api.html)
* [Tutorials](tutorials.html)
* [Changelog](changelog.html)

[fuc](index.html)

* CLI
* [Edit on GitHub](https://github.com/sbslee/fuc/blob/main/docs/cli.rst)

---

# CLI[](#cli "Permalink to this heading")

## Introduction[](#introduction "Permalink to this heading")

This section describes command line interface (CLI) for the fuc package.

For getting help on the fuc CLI:

```
$ fuc -h
usage: fuc [-h] [-v] COMMAND ...

positional arguments:
  COMMAND
    bam-aldepth  Compute allelic depth from a BAM file.
    bam-depth    Compute per-base read depth from BAM files.
    bam-head     Print the header of a BAM file.
    bam-index    Index a BAM file.
    bam-rename   Rename the sample in a BAM file.
    bam-slice    Slice a BAM file.
    bed-intxn    Find the intersection of BED files.
    bed-sum      Summarize a BED file.
    cov-concat   Concatenate depth of coverage files.
    cov-rename   Rename the samples in a depth of coverage file.
    fa-filter    Filter sequence records in a FASTA file.
    fq-count     Count sequence reads in FASTQ files.
    fq-sum       Summarize a FASTQ file.
    fuc-bgzip    Write a BGZF compressed file.
    fuc-compf    Compare the contents of two files.
    fuc-demux    Parse the Reports directory from bcl2fastq.
    fuc-exist    Check whether certain files exist.
    fuc-find     Retrieve absolute paths of files whose name matches a
                 specified pattern, optionally recursively.
    fuc-undetm   Compute top unknown barcodes using undertermined FASTQ from
                 bcl2fastq.
    maf-maf2vcf  Convert a MAF file to a VCF file.
    maf-oncoplt  Create an oncoplot with a MAF file.
    maf-sumplt   Create a summary plot with a MAF file.
    maf-vcf2maf  Convert a VCF file to a MAF file.
    ngs-bam2fq   Pipeline for converting BAM files to FASTQ files.
    ngs-fq2bam   Pipeline for converting FASTQ files to analysis-ready BAM
                 files.
    ngs-hc       Pipeline for germline short variant discovery.
    ngs-m2       Pipeline for somatic short variant discovery.
    ngs-pon      Pipeline for constructing a panel of normals (PoN).
    ngs-quant    Pipeline for running RNAseq quantification from FASTQ files
                 with Kallisto.
    ngs-trim     Pipeline for trimming adapters from FASTQ files.
    tabix-index  Index a GFF/BED/SAM/VCF file with Tabix.
    tabix-slice  Slice a GFF/BED/SAM/VCF file with Tabix.
    tbl-merge    Merge two table files.
    tbl-sum      Summarize a table file.
    vcf-call     Call SNVs and indels from BAM files.
    vcf-filter   Filter a VCF file.
    vcf-index    Index a VCF file.
    vcf-merge    Merge two or more VCF files.
    vcf-rename   Rename the samples in a VCF file.
    vcf-slice    Slice a VCF file for specified regions.
    vcf-split    Split a VCF file by individual.
    vcf-vcf2bed  Convert a VCF file to a BED file.
    vcf-vep      Filter a VCF file by annotations from Ensembl VEP.

optional arguments:
  -h, --help     Show this help message and exit.
  -v, --version  Show the version number and exit.
```

For getting help on a specific command (e.g. vcf-merge):

```
$ fuc vcf-merge -h
```

## bam-aldepth[](#bam-aldepth "Permalink to this heading")

```
$ fuc bam-aldepth -h
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

## bam-depth[](#bam-depth "Permalink to this heading")

```
$ fuc bam-depth -h
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

## bam-head[](#bam-head "Permalink to this heading")

```
$ fuc bam-head -h
usage: fuc bam-head [-h] bam

Print the header of a BAM file.

Positional arguments:
  bam         Input alignment file.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Print the header of a BAM file:
  $ fuc bam-head in.bam
```

## bam-index[](#bam-index "Permalink to this heading")

```
$ fuc bam-index -h
usage: fuc bam-index [-h] bam

Index a BAM file.

Positional arguments:
  bam         Input alignment file.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Index a BAM file:
  $ fuc bam-index in.bam
```

## bam-rename[](#bam-rename "Permalink to this heading")

```
$ fuc bam-rename -h
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

## bam-slice[](#bam-slice "Permalink to this heading")

```
$ fuc bam-slice -h
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

## bed-intxn[](#bed-intxn "Permalink to this heading")

```
$ fuc bed-intxn -h
usage: fuc bed-intxn [-h] bed [bed ...]

Find the intersection of BED files.

Positional arguments:
  bed         Input BED files.

Optional arguments:
  -h, --help  Show this help message and exit.

[Example] Find the intersection of three BED files:
  $ fuc bed-intxn in1.bed in2.bed in3.bed > out.bed
```

## bed-sum[](#bed-sum "Permalink to this heading")

```
$ fuc bed-sum -h
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

## cov-concat[](#cov-concat "Permalink to this heading")

```
$ fuc cov-concat -h
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

## cov-rename[](#cov-rename "Permalink to this heading")

```
$ fuc cov-rename -h
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

## fa-filter[](#fa-filter "Permalink to this heading")

```
$ fuc fa-filter -h
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

## fq-count[](#fq-count "Permalink to this heading")

```
$ fuc fq-count -h
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

## fq-sum[](#fq-sum "Permalink to this heading")

```
$ fuc fq-sum -h
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

## fuc-bgzip[](#fuc-bgzip "Permalink to this heading")

```
$ fuc fuc-bgzip -h
usage: fuc fuc-bgzip [-h] [file ...]

Write a BGZF compressed file.

BGZF (Blocked GNU Zip Format) is a modified form of gzip compression which
can be applied to any file format to provide compression with efficient
random access. In addition to being required for random access to and writing
of BAM files, the BGZF format c