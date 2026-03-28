# minimod

Minimod is a simple tool for handling base modifications. It takes an aligned BAM file with modifications tags and the reference FASTA as inputs, and outputs base modifications (TSV) or base modification frequencies (TSV or bedmethyl).

Minimod reads base modification information encoded under `MM:Z` and `ML:B:C` SAM tags specified in [SAMtags](https://github.com/samtools/hts-specs/blob/master/SAMtags.pdf) specification.

**IMPORTANT: minimod is currently in active development. Open an [issue](https://github.com/warp9seq/minimod) if you find a problem or have a suggestion.**

[![GitHub Downloads](https://img.shields.io/github/downloads/warp9seq/minimod/total?logo=GitHub)](https://github.com/warp9seq/minimod/releases)
[![BioConda Install](https://img.shields.io/conda/dn/bioconda/minimod?label=BioConda)](https://anaconda.org/bioconda/minimod)

# Table of Contents

* [Quick start](#quick-start)
* [Installation](#installation)
  + [Building a release](#building-a-release)
* [Usage](#usage)
* [Examples](#examples)
* [minimod view](#minimod-view)
* [minimod freq](#minimod-freq)
* [minimod summary](#minimod-summary)
* [How skipped bases are handled](#how-skipped-bases-are-handled)
* [Modification codes and contexts](#modification-codes-and-contexts)
* [Modification probability](#modification-probability)
* [Modification threshold](#modification-threshold)
* [Enable insertions](#enable-insertions)
* [Enable haplotypes](#enable-haplotypes)
* [Important !](#important)
  + [Base-calling](#base-calling)
  + [Aligning](#aligning)
* [Acknowledgement](#acknowledgement)

# Quick start

If you are a Linux user and want to quickly try out download the compiled binaries from the [latest release](https://github.com/warp9seq/minimod/releases). For example:

```
VERSION=v0.5.0
wget "https://github.com/warp9seq/minimod/releases/download/$VERSION/minimod-$VERSION-x86_64-linux-binaries.tar.gz" && tar xvf minimod-$VERSION-x86_64-linux-binaries.tar.gz && cd minimod-$VERSION/
./minimod
```

Binaries should work on most Linux distributions as the only dependency is `zlib` which is available by default on most distributions. For compiled binaries to work, your operating system must have GLIBC 2.17 or higher (Linux distributions from 2014 onwards typically have this).

You can also use conda to install *minimod* as `conda install minimod -c bioconda -c conda-forge`.

# Installation

## Pre-requisites

```
sudo apt-get install zlib1g-dev  # install zlib development libraries
```

## Building a release

```
VERSION=v0.5.0
wget https://github.com/warp9seq/minimod/releases/download/$VERSION/minimod-$VERSION-release.tar.gz
tar xvf minimod-$VERSION-release.tar.gz
cd minimod-$VERSION/
scripts/install-hts.sh  # download and compile the htslib
make
```

> Major changes between releases are listed in [docs/changes.md](/minimod/docs/changes.html)

# Usage

Usage information can be printed using `minimod -h` command.

```
Usage: minimod <command> [options]

command:
         view       view base modifications
         freq       output base modifications frequencies
         summary    output summary
```

Note: *freq* was previously *mod-freq* which still works but will be deprecated soon.

# Examples

```
# view all 5mC methylations at CG context in tsv format (default mod code: m, context:CG)
minimod view ref.fa reads.bam > mods.tsv

# 5mC methylation frequencies at CG context in tsv format (default mod code: m, threshold: 0.8, context:CG)
minimod freq ref.fa reads.bam > modfreqs.tsv

# 5mC methylation frequencies at CG context in bedmethyl format (default mod code: m, threshold: 0.8, context:CG)
minimod freq -b ref.fa reads.bam > modfreqs.bedmethyl

# modification frequencies of multiple types ( m (5-methylcytosine) and h (5-hydroxymethylcytosine) in CG context with thresholds 0.8 and 0.7 respectively )
minimod freq -c m[CG],h[CG] -m 0.8,0.7 ref.fa reads.bam > mods.tsv

# summary of available modifications and counts
minimod summary reads.bam > summary.tsv
```

* See [how modification codes can be specified?](#modification-codes-and-contexts)
* See [how threshold is used in minimod?](#modification-threshold)
* See [how minimod is consistent with other tools?](/minimod/docs/notes.html)

# minimod view

```
minimod view ref.fa reads.bam > mods.tsv
```

This writes all base modifications (default modification code “m”) to a file (mods.tsv) in tsv format. Sample output is given below.

```
Usage: minimod view ref.fa reads.bam

basic options:
   -c STR                     modification code(s) (eg. m, h or mh or as ChEBI) [m]
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [20.0M]
   -h                         help
   -p INT                     print progress every INT seconds (0: per batch) [0]
   -o FILE                    output file [stdout]
   --insertions               output modifications in insertions [no]
   --haplotypes               output haplotypes [no]
   --verbose INT              verbosity level [4]
   --version                  print version
   --allow-secondary          allow secondary alignments [no]
   --skip-supplementary       skip supplementary alignments [no]
```

* See [how to consider inserted modified bases?](#enable-insertions)

**Sample mods.tsv output**
The output is ordered in the same as the order the reads appear in the input BAM file, and for each read, entries are sorted by reference contig, reference position, strand, and modification code.

```
ref_contig	ref_pos	strand	read_id	read_pos	mod_code	mod_prob
chr22	19979864	+	m84088_230609_030819_s1/55512555/ccs	14	m	0.709804
chr22	19979882	+	m84088_230609_030819_s1/55512555/ccs	32	m	0.949020
chr22	19979885	+	m84088_230609_030819_s1/55512555/ccs	35	m	0.980392
chr22	19979888	+	m84088_230609_030819_s1/55512555/ccs	38	m	0.780392
chr22	19979900	+	m84088_230609_030819_s1/55512555/ccs	50	m	0.623529
chr22	19979902	+	m84088_230609_030819_s1/55512555/ccs	52	m	0.992157
chr22	19979929	+	m84088_230609_030819_s1/55512555/ccs	79	m	0.941176
chr22	19979939	+	m84088_230609_030819_s1/55512555/ccs	89	m	0.141176
chr22	19979948	+	m84088_230609_030819_s1/55512555/ccs	98	m	0.623529
```

| Field | Type | Definition |
| --- | --- | --- |
| 1. ref\_contig | str | chromosome |
| 2. ref\_pos | int | position (0-based) of the base in reference |
| 3. strand | char | strand (+/-) of the read |
| 4. read\_id | str | name of the read |
| 5. read\_pos | int | position (0-based) of the base in read |
| 6. mod\_code | char | base modification code as in [SAMtags: 1.7 Base modifications](https://github.com/samtools/hts-specs/blob/master/SAMtags.pdf) |
| 7. mod\_prob | float | probability (0.0-1.0) of base modification |
| 8. ins\_offset | int | offset of inserted base from ref\_pos (only output when –insertions is specified) |
| 9. haplotype | int | haplotype of the read (only output when –haplotypes is specified) |

# minimod freq

```
minimod freq ref.fa reads.bam > modfreqs.tsv
```

This writes base modification frequencies (default modification code “m” in CG context with modification threshold 0.8) to a file (modfreqs.tsv) file in tsv format.

```
Usage: minimod freq ref.fa reads.bam

basic options:
   -b                         output in bedMethyl format [not set]
   -c STR                     modification code(s) (eg. m, h or mh or as ChEBI) [m]
   -m FLOAT                   min modification threshold(s). Comma separated values for each modification code given in -c [0.8]
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [20.0M]
   -h                         help
   -p INT                     print progress every INT seconds (0: per batch) [0]
   -o FILE                    output file [stdout]
   --insertions               output modifications in insertions [no]
   --haplotypes               output haplotypes [no]
   --verbose INT              verbosity level [4]
   --version                  print version
   --allow-secondary          allow output secondary alignments [no]
   --skip-supplementary       skip supplementary alignments [no]
```

**Sample modfreqs.tsv output**
The output entries are sorted by reference contig, reference position, strand, and modification code.

```
contig	start	end	strand	n_called	n_mod	freq	mod_code
chr22	20016337	20016337	+	5	0	0.000000	m
chr22	20016594	20016594	+	2	0	0.000000	m
chr22	20017045	20017045	+	1	0	0.000000	m
chr22	19970705	19970705	+	1	0	0.000000	m
chr22	19981716	19981716	+	1	1	1.000000	m
chr22	20020909	20020909	+	3	0	0.000000	m
chr22	19995719	19995719	+	4	2	0.500000	m
chr22	20017060	20017060	+	1	0	0.000000	m
chr22	19971259	19971259	+	1	1	1.000000	m
```

| Field | Type | Definition |
| --- | --- | --- |
| 1. contig | str | chromosome |
| 2. start | int | position (0-based, inclusive) of the base |
| 3. end | int | position (0-based, inclusive) of the base |
| 4. strand | char | strand (+/-) of the read |
| 5. n\_called | int | number of reads called for base modification |
| 6. n\_mod | int | number of reads with base modification |
| 7. freq | float | n\_mod/n\_called ratio |
| 8. mod\_code | char | base modification code as in [SAMtags: 1.7 Base modifications](https://github.com/samtools/hts-specs/blob/master/SAMtags.pdf) |
| 9. ins\_offset | int | offset of inserted base from ref\_pos (only output when –insertions is specified) |
| 10. haplotype | int | haplotype of the read (only output when –haplotypes is specified) |

**Sample modfreqs.bedmethyl output**

```
chr22	20016387	20016388	m	4	-	20016387	20016388	255,0,0	4	0.000000
chr22	20016820	20016821	m	1	+	20016820	20016821	255,0,0	1	0.000000
chr22	19999255	19999256	m	7	+	19999255	19999256	255,0,0	7	0.000000
chr22	20016426	20016427	m	1	+	20016426	20016427	255,0,0	1	100.000000
chr22	19988365	19988366	m	1	-	19988365	19988366	255,0,0	1	100.000000
chr22	19988168	19988169	m	1	-	19988168	19988169	255,0,0	1	100.000000
chr22	20016904	20016905	m	1	+	20016904	20016905	255,0,0	1	0.000000
chr22	20011898	20011899	m	8	-	20011898	20011899	255,0,0	8	25.000000
chr22	19990123	19990124	m	3	+	19990123	19990124	255,0,0	3	0.000000
chr22	19982787	19982788	m	1	+	19982787	19982788	255,0,0	1	0.000000
```

| Field | Type | Definition |
| --- | --- | --- |
| 1. contig | str | chromosome |
| 2. start | int | position (0-based, inclusive) of the base |
| 3. end | int | position (0-based, not inclusive) of the base |
| 4. mod\_code | char | base modification code as in [SAMtags: 1.7 Base modifications](https://github.com/samtools/hts-specs/blob/master/SAMtags.pdf) |
| 5. n\_mod | int | number of reads with base modification |
| 6. strand | char | strand (+/-) of the read |
| 7. start | int | = field 2 |
| 8. end | int | = field 3 |
| 9. color | str | always 255,0,0 (for compatibility) |
| 10. n\_mod | int | = field 5 |
| 11. freq | float | n\_mod/n\_called ratio |

# minimod summary

```
minimod summary reads.bam > summary.tsv
```

This writes all base modifications available to a file (summary.tsv) in tsv format. Sample output is given below.

```
Usage: minimod summary reads.bam

basic options:
   -t INT                     number of processing threads [8]
   -K INT                     batch size (max number of reads loaded at once) [512]
   -B FLOAT[K/M/G]            max number of bases loaded at once [20.0M]
   -h                         help
   -p INT                     print progress every INT seconds (0: per batch) [0]
   -o FILE                    output file [stdout]
   --verbose INT              verbosity level [4]
   --version                  print version
   --allow-secondary          allow secondary alignments [no]
   --skip-supplementary       skip supplementary alignments [no]

advanced options:
   --debug-break INT          break after processing the specified no. of batches
   --profile-cpu=yes|no       process section by section
```

**Sample mods.tsv output**

```
read_id	 modifications
491fb526-314e-4c18-9690-eb6930d780ea	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
52b66d0d-a21e-4334-be1b-f72486d9f9bf	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
cb481f14-7651-448c-945b-b4f5b2e8b70c	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
2cab7053-9008-47eb-8e57-c33fda56c2ec	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
37bf1305-8d8b-4973-9a0b-930303067306	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
164e336f-568d-44d5-882d-7669bbe67654	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
229bbbb9-abf9-4825-af30-a583a19864eb	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
adbaba61-604d-4897-99cc-f9a934f3e2c8	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
093bc2c6-2ae5-437d-a17c-be2755c3c689	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
92fc0cc5-b2d8-4cb1-bf25-8f8b88088f23	A|17596|. C|m|. A|a|. C|19228|. T|19227|. A|69426|. G|19229|. T|17802|.
```

The output is ordered in the same as reads appear in the input BAM file. First column of the output are the read\_id the second column contains all available modifications in that read as space separated entries. Each entry has the following format.

```
canonical_base(character such as ACGTN)|mod_code(character or ChEBI number)|status_flag(. or ?)
```

Status flag describes how skipped bases should be interpreted by downstream tools.

* **.** : skipped bases should be assumed to have low probability of modifications.
* **?** : there is no information about the modification status of skipped bases

# How skipped bases are handled

Modified base positions are encoded in MM tag as a series of integers each indicating how many bases to be skipped before the next modified base. For an example, if the MM tag starts with **C+m.**, the skipped bases should be considered to have low probability. Otherwise, if the MM tag starts with **C+m?**, the probability of skipped bases are unknown.

Minimod ignores skipped bases with unknown probability while considering each skipped bases with low probability to have mod\_prob value of 0.001953125. This value is derived from (N+0.5)/256 where N equals to 0 as explained [Modification probability](#modification-probability) section.

# Modification codes and contexts

Base modification codes and contexts can be set for both view and freq tool using -c option to take only specific base modifications found in a given contexts. The context should match in the reference and bases in unmatching contexts are ignored.

Here are the possible context formats.

* **m[CG]** : type m modifications in CG context. the modified read base should match the corresponding reference base. the whole context may not match 