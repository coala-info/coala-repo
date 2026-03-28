[genomepy](../index.html)

* [Home](../index.html)
* [Installation](installation.html)
* Command line documentation
  + [Command line interface](#command-line-interface)
    - [Search genomes & gene annotations](#search-genomes-gene-annotations)
    - [Inspect gene annotations](#inspect-gene-annotations)
    - [Install a genome & gene annotation](#install-a-genome-gene-annotation)
      * [Regex, masking & compression](#regex-masking-compression)
      * [Other providers (any URL/local files)](#other-providers-any-url-local-files)
      * [Reproducibility](#reproducibility)
    - [Plugins](#plugins)
      * [Genome blacklists](#genome-blacklists)
      * [Aligner indexes](#aligner-indexes)
    - [Configuration](#id1)
      * [Genome location](#genome-location)
      * [Compression](#compression)
    - [List available providers](#list-available-providers)
    - [List available genomes](#list-available-genomes)
    - [Local cache.](#local-cache)
* [Python API documentation (core)](api_core.html)
* [Python API documentation (full)](../_autosummary/genomepy.html)
* [Configuration](config.html)
* [FAQ](help_faq.html)
* [About](about.html)

[genomepy](../index.html)

* Command line documentation
* [Edit on GitHub](https://github.com/vanheeringen-lab/genomepy/blob/develop/docs/content/command_line.rst)

---

# Command line documentation[](#command-line-documentation "Permalink to this heading")

## Command line interface[](#command-line-interface "Permalink to this heading")

All commands come with a short explanation when appended with `-h`/`--help`.

```
$ genomepy --help
Usage: genomepy [OPTIONS] COMMAND [ARGS]...

Options:
  --version   Show the version and exit.
  -h, --help  Show this message and exit.

Commands:
  annotation  show 1st lines of each annotation
  clean       remove provider data
  config      manage configuration
  genomes     list available genomes
  install     install a genome & run active plugins
  plugin      manage plugins
  providers   list available providers
  search      search for genomes
```

### Search genomes & gene annotations[](#search-genomes-gene-annotations "Permalink to this heading")

Let’s say we want to download a *Xenopus tropicalis* genome & gene annotation.
First, lets find out what’s out there!

You can search by name, taxonomy ID or assembly accession ID.
Additionally, you can limit the search result to one provider with `-p`/`--provider`.
Furthermore, you can get the absolute `--size` of each genome (this option slows down the search).

```
$ genomepy search xenopus tro
name                       provider    accession           tax_id    annotation     species               other_info
                                                                      n r e k
Xenopus_tropicalis_v9.1    Ensembl     GCA_000004195.3       8364        ✓          Xenopus tropicalis    2019-04-Ensembl/2019-12
xenTro1                    UCSC        na                    8364     ✗ ✗ ✗ ✗       Xenopus tropicalis    Oct. 2004 (JGI 3.0/xenTro1)
xenTro2                    UCSC        na                    8364     ✗ ✓ ✓ ✗       Xenopus tropicalis    Aug. 2005 (JGI 4.1/xenTro2)
xenTro3                    UCSC        GCA_000004195.1       8364     ✗ ✓ ✓ ✗       Xenopus tropicalis    Nov. 2009 (JGI 4.2/xenTro3)
xenTro7                    UCSC        GCA_000004195.2       8364     ✓ ✓ ✗ ✗       Xenopus tropicalis    Sep. 2012 (JGI 7.0/xenTro7)
xenTro9                    UCSC        GCA_000004195.3       8364     ✓ ✓ ✓ ✗       Xenopus tropicalis    Jul. 2016 (Xenopus_tropicalis_v9.1/xenTro9)
Xtropicalis_v7             NCBI        GCF_000004195.2       8364        ✓          Xenopus tropicalis    DOE Joint Genome Institute
Xenopus_tropicalis_v9.1    NCBI        GCF_000004195.3       8364        ✓          Xenopus tropicalis    DOE Joint Genome Institute
UCB_Xtro_10.0              NCBI        GCF_000004195.4       8364        ✓          Xenopus tropicalis    University of California, Berkeley
ASM1336827v1               NCBI        GCA_013368275.1       8364        ✗          Xenopus tropicalis    Southern University of Science and Technology
 ^
 Use name for genomepy install
```

### Inspect gene annotations[](#inspect-gene-annotations "Permalink to this heading")

Let’s say we want to download the *Xenopus tropicalis* genome & gene annotation from UCSC.

Since we are interested in the gene annotation as well, we should check which gene annotation suits our needs.
As you can see in the search results, UCSC has several gene annotations for us to choose from.
In the search results, `n r e k` denotes which UCSC annotations are available.
These stand for **n**cbiRefSeq, **r**efGene, **e**nsGene and **k**nownGene, respectively.

We can quickly inspect these with the `genomepy annotation` command:

```
$ genomepy annotation xenTro9 -p ucsc
12:04:41 | INFO | UCSC ncbiRefSeq
chr1    genomepy        transcript      133270  152620  .       -       .       gene_id "LOC100490505"; transcript_id "XM_012956089.1";  gene_name "LOC100490505";
chr1    genomepy        exon    133270  134186  .       -       .       gene_id "LOC100490505"; transcript_id "XM_012956089.1"; exon_number "1"; exon_id "XM_012956089.1.1"; gene_name "LOC100490505";
12:04:45 | INFO | UCSC refGene
chr1    genomepy        transcript      193109390       193134311       .       +       .       gene_id "pias2"; transcript_id "NM_001078987";  gene_name "pias2";
chr1    genomepy        exon    193109390       193109458       .       +       .       gene_id "pias2"; transcript_id "NM_001078987"; exon_number "1"; exon_id "NM_001078987.1"; gene_name "pias2";
12:04:49 | INFO | UCSC ensGene
chr1    genomepy        transcript      133270  152620  .       -       .       gene_id "ENSXETG00000030302.2"; transcript_id "ENSXETT00000061673.2";  gene_name "ENSXETG00000030302.2";
chr1    genomepy        exon    133270  134186  .       -       .       gene_id "ENSXETG00000030302.2"; transcript_id "ENSXETT00000061673.2"; exon_number "1"; exon_id "ENSXETT00000061673.2.1"; gene_name "ENSXETG00000030302.2";
```

Here we can see that the `refGene` annotation has actual HGNC gene names, so lets go with this annotation.
This differs between assemblies, so be sure to check!

### Install a genome & gene annotation[](#install-a-genome-gene-annotation "Permalink to this heading")

Copy the name returned by the search function to install.

```
$ genomepy install xenTro9
```

You can choose to download gene annotation files with the `-a`/`--annotation` option.

```
$ genomepy install xenTro9 --annotation
```

For UCSC we can also select the annotation type.
See `genomepy install --help` for all provider specific options.

```
$ genomepy install xenTro9 --UCSC-annotation refGene
```

Since we did not specify the provider here, genomepy will use the first provider with `xenTro9`.
You can specify a provider by name with `-p`/`--provider`:

```
$ genomepy install xenTro9 -p UCSC
Downloading genome from http://hgdownload.soe.ucsc.edu/goldenPath/xenTro9/bigZips/xenTro9.fa.gz...
Genome download successful, starting post processing...

name: xenTro9
local name: xenTro9
fasta: ~/.local/share/genomes/xenTro9/xenTro9.fa
```

Next, the genome is downloaded to the directory specified in the config file (by default `~/.local/share/genomes`).
To choose a different directory, use the `-g`/`--genomes_dir` option:

```
$ genomepy install sacCer3 -p UCSC -g /path/to/my/genomes
Downloading genome from http://hgdownload.soe.ucsc.edu/goldenPath/sacCer3/bigZips/chromFa.tar.gz...
Genome download successful, starting post processing...

name: sacCer3
local name: sacCer3
fasta: /path/to/my/genomes/sacCer3/sacCer3.fa
```

#### Regex, masking & compression[](#regex-masking-compression "Permalink to this heading")

You can use a regular expression to filter for matching sequences
(or non-matching sequences by using the `-n`/`--no-match` option).
For instance, the following command downloads hg38 and saves only the major chromosomes:

```
$ genomepy install hg38 -p UCSC -r 'chr[0-9XY]+$'
Downloading genome from from http://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz...
Genome download successful, starting post processing...

name: hg38
local name: hg38
fasta: /data/genomes/hg38/hg38.fa

$ grep ">" /data/genomes/hg38/hg38.fa
>chr1
>chr10
>chr11
>chr12
>chr13
>chr14
>chr15
>chr16
>chr17
>chr18
>chr19
>chr2
>chr20
>chr21
>chr22
>chr3
>chr4
>chr5
>chr6
>chr7
>chr8
>chr9
>chrX
>chrY
```

By default, genome sequences are soft-masked (ACgtN).
Use `-m hard` for hard masking (ACNNN), or `-m none` for no masking (ACGTN).

```
$ genomepy install hg38 --mask hard
```

If you wish to conserve space, you can tell genomepy to compress the downloaded data by passing the `-b`/`--bgzip` option.
See [Configuration](#compression) for details.

```
$ genomepy install hg38 --bgzip
```

#### Other providers (any URL/local files)[](#other-providers-any-url-local-files "Permalink to this heading")

To use assemblies not on NCBI, UCSC, Ensembl or GENCODE, you can give a URL instead of a name, together with `--provider URL`.
Similarly, if you have a local FASTA file, you can install this using the filepath, together with `--provider Local`:

```
$ genomepy install -p url https://research.nhgri.nih.gov/hydra/download/assembly/\Hm105_Dovetail_Assembly_1.0.fa.gz
```

This will install the genome under the filename of the URL/filepath, but can be changed with the `-l`/`--localname` option.

If you add the `--annotation` flag, genomepy will search the (remote) directory for an annotation file as well.
Should this fail, you can also add a URL to the annotation with `--URL-to-annotation` with the `URL` provider,
or a filepath with `--Local-path-to-annotation` with the `Local` provider:

```
$ genomepy install -p local /path/to/genome.fa --Local-path-to-annotation /path/to/gene.annotation.gtf
```

#### Reproducibility[](#reproducibility "Permalink to this heading")

All selected options are stored in a `README.txt`.
This includes the original name, download location and other genomepy operations (such as regex filtering and time).

### Plugins[](#plugins "Permalink to this heading")

Plugins are optional steps that are executed after installing an assembly with `genomepy install`.
If you already installed an assembly, you can activate a plugin and rerun the install command.
This will not overwrite your local files, unless you use the `--force` option.

Check which plugins are enabled with `genomepy plugin list`.

#### Genome blacklists[](#genome-blacklists "Permalink to this heading")

For some model organisms, genomepy can download a genome blacklist (generated by the [Kundaje lab](https://www.nature.com/articles/s41598-019-45839-z)).
Blacklists are only available for these model organisms when downloaded from UCSC, and for the human and mouse genomes.

Enable the blacklist plugin to use it:

```
$ genomepy plugin enable blacklist
Enabled plugins: blacklist
```

#### Aligner indexes[](#aligner-indexes "Permalink to this heading")

You can also create aligner indexes for several widely used aligners.
Currently, genomepy supports:

* [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
* [BWA](http://bio-bwa.sourceforge.net/)
* [GMAP](http://research-pub.gene.com/gmap/)
* [HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml)
* [Minimap2](https://github.com/lh3/minimap2)
* [STAR](https://github.com/alexdobin/STAR)

These programs are not installed by genomepy and need to be installed separately for the indexing to work.
The easiest way to do so is with conda, e.g.: `conda install -c bioconda bwa star`

Splice-aware indexing (required for e.g. RNA-seq) can be performed by STAR and Hisat2.
This will be done automatically if the gene annotation was downloaded as well.
Finally, STAR can further improve mapping to (novel) splice junctions by indexing again (see 2-pass mapping mode in the STAR manual).
The second pass is not supported by genomepy.

You can configure the index creation with `genomepy plugin enable`, e.g.:

```
$ genomepy plugin enable bwa star
Enabled plugins: blacklist, bwa, star
```

You can pass the number of threads to use for aligner index creation with `genomepy install --threads` (default is 8).

### Configuration[](#id1 "Permalink to this heading")

All defaults can be overwritten on the command line and in Python.
However, you can create & edit the config file to change the default settings ([full description](https://vanheeringen-lab.github.io/genomepy/content/config.html)):

```
$ genomepy config generate
Created config file ~/.config/genomepy/genomepy.yaml
```

#### Genome location[](#genome-location "Permalink to this heading")

By default, genomes will be saved in `~/.local/share/genomes`.

To set the default genome directory, to `/data/genomes` for instance,
edit `~/.config/genomepy/genomepy.yaml` and change the following line:

```
genomes_dir: /data/genomes
```

#### Compression[](#compression "Permalink to this heading")

Genome FASTA files can be stored using bgzip compression.
This means that the FASTA files will take up less space on disk.
Set the following line to your config file:

```
bgzip: True
```

Most tools are able to use bgzip-compressed genome files.
One notable exception is `bedtools getfasta`.
As an alternative, you can use the `faidx` command-line script from [pyfaidx](https://github.com/mdshw5/pyfaidx)
which comes installed with genomepy.

### List available providers[](#list-available-providers "Permalink to this heading")

```
$ genomepy providers
GENCODE
Ensembl
UCSC
NCBI
Local
URL
```

### List available genomes[](#list-available-genomes "Permalink to this heading")

You can constrain the genome list by using the `-p`/`--provider` option to search only a specific provider.
Additionally, you can get the absolute `--size` of each genome (this option slows down the search).

```
$ genomepy genomes -p UCSC
name                    provider    accession          tax_id     annotation     species                                     other_info
                                                                   n r e k
ailMel1                 UCSC        GCF_000004335.2      9646      ✓ ✗ ✓ ✗       Ailuropoda melanoleuca                      Dec. 2009 (BGI-Shenzhen 1.0/ailMel1)
allMis1                 UCSC        GCA_000281125.1      8496      ✗ ✓ ✗ ✗       Alligator mississippiensis                  Aug. 2012 (allMis0.2/allMis1)
anoCar1                 UCSC        na                  28377      ✗ ✗ ✓ ✗       Anolis carolinensis                         Feb. 2007 (Broad/anoCar1)
```

### Local cache.[](#local-cache "Permalink to this heading")

Note that the first time you run `genomepy search` or `list` the command will take a while as the genome lists have to be downloaded.
The lists are cached locally, which will save time later.
The cached files are stored in `~/.cache/genomepy` and expire after 7 days (so they stay up to date).
This expiration time can