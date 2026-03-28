[Genomedata](index.html)

* Genomedata 1.7.4.dev0+gc3c94bccd documentation
  + [Installation](#installation)
    - [Installing HDF5](#installing-hdf5)
    - [Installing from source](#installing-from-source)
    - [Installing Genomedata](#installing-genomedata)
  + [Overview](#overview)
  + [Implementation](#implementation)
  + [Creation](#creation)
    - [Example](#example)
  + [Genomedata usage](#genomedata-usage)
    - [Python interface](#python-interface)
    - [Basic usage](#basic-usage)
    - [BigWig differences](#bigwig-differences)
      * [Command-line interface](#command-line-interface)
    - [genomedata-load](#genomedata-load)
      * [Chromosome naming](#chromosome-naming)
    - [genomedata-load-seq](#genomedata-load-seq)
    - [genomedata-open-data](#genomedata-open-data)
    - [genomedata-hardmask](#genomedata-hardmask)
    - [genomedata-load-data](#genomedata-load-data)
    - [genomedata-close-data](#genomedata-close-data)
    - [genomedata-erase-data](#genomedata-erase-data)
    - [genomedata-info](#genomedata-info)
    - [genomedata-query](#genomedata-query)
      * [Python API](#python-api)
  + [Tips and tricks](#tips-and-tricks)
  + [Technical matters](#technical-matters)
    - [Chunking and chunk cache overhead](#chunking-and-chunk-cache-overhead)
  + [Bugs](#bugs)
  + [Support](#support)

[Genomedata](index.html)

* Genomedata 1.7.4.dev0+gc3c94bccd documentation
* [View page source](_sources/genomedata.rst.txt)

---

# Genomedata 1.7.4.dev0+gc3c94bccd documentation[](#genomedata-version-documentation "Link to this heading")

Website:
:   <http://pmgenomics.ca/hoffmanlab/proj/genomedata/>

Author:
:   Michael M. Hoffman <michael dot hoffman at utoronto dot ca>

Organization:
:   Princess Margaret Cancer Centre

Address:
:   Toronto Medical Discovery Tower 11-311, 101 College St, M5G 1L7, Toronto, Ontario, Canada

Copyright:
:   2009-2014 Michael M. Hoffman

For a broad overview, see the paper:

> Hoffman MM, Buske OJ, Noble WS. (2010). [The Genomedata format for storing
> large-scale functional genomics data](http://bioinformatics.oxfordjournals.org/content/26/11/1458.full).
> *Bioinformatics*, **26**(11):1458-1459; doi:10.1093/bioinformatics/btq164

Please cite this paper if you use Genomedata.

## Installation[](#installation "Link to this heading")

Python 3.7 (or later) and HDF5 are required before you can install Genomedata.

### Installing HDF5[](#installing-hdf5 "Link to this heading")

Ubuntu/Debian:

```
sudo apt-get install hdf5-tools
```

CentOS/RHEL/Fedora:

```
sudo yum -y install hdf5
```

OpenSUSE:

```
sudo zypper in hdf5 libhdf5
```

If HDF5 has been installed from source, set the HDF5\_DIR environment variable to the
directory where it was installed.

### Installing from source[](#installing-from-source "Link to this heading")

Additional packages are necessary when installing from source.

Ubuntu/Debian:

```
sudo apt-get install libhdf5-serial-dev
```

CentOS/RHEL/Fedora:

```
sudo yum -y install hdf5-devel
```

OpenSUSE:

```
sudo zypper in hdf5-devel
```

### Installing Genomedata[](#installing-genomedata "Link to this heading")

Genomedata can be installed through pip or Bioconda.

With Bioconda:

```
conda install genomedata
```

With Python 3.7 or later installed:

```
pip install genomedata
```

Note

The latest version of genomedata will not install with older versions of pip
due to updated build dependencies. You can update your pip using the command:

```
pip install --upgrade pip
```

Note

Genomedata is only supported on 64 bit systems.

Note

The following are prerequisites:

* Linux/Unix
  :   This software has been tested on Linux and Mac OS X systems.
      We would love to add support for other systems in the future and
      will gladly accept any contributions toward this end.
* Zlib

Note

For questions, comments, or troubleshooting, please refer to
the [support](#support) section.

## Overview[](#overview "Link to this heading")

Genomedata is a file format and Python API for accessing large-scale functional
genomics data. The file format is both space-efficient and allows efficient random-access.
The Python API works with Genomedata archives and bigWig files.

Under the surface, the Genomedata file format is [implemented](#implementation)
as one or more HDF5 files, but Genomedata provides a transparent
interface to interact with your underlying data without having to
worry about the mess of repeatedly parsing large data files or having
to keep them in memory for random access.
The Genomedata archives are currently write-once, although we are working to fix this.

The Genomedata hierarchy:

> Each [`Genome`](#genomedata.Genome "genomedata.Genome") contains many `Chromosomes`
> :   Each `Chromosome` contains many `Supercontigs`
>     :   Each `Supercontig` contains one `continuous` data set
>         :   Each `continuous` data set is a numpy.array of floating
>             point numbers with a column for each data track and a row
>             for each base in the data set.

Why have `Supercontigs`?
:   Genomic data seldom covers the entire genome but instead tends to be defined
    in large but scattered regions. In order to avoid storing the undefined
    data between the regions, chromosomes are divided into separate supercontigs
    when regions of defined data are far enough apart. They also serve as
    a convenient chunk since they can usually fit entirely in memory.

## Implementation[](#implementation "Link to this heading")

Genomedata archives are implemented as one or more HDF5 files.
The [API](#python-api) handles both single-file
and directory archives transparently, but the implementation options
exist for several performance reasons.

Use a **directory** with few chromosomes/scaffolds:
:   * Parallel load/access
    * Smaller file sizes

Use a **single file** with many chromosomes/scaffolds:
:   * More efficient access with many chromosomes/scaffolds
    * Easier archive distribution

Implementing the archive as a directory makes it easier to
parallelize access to the data. In particular, it makes it easy to
create the archives in parallel with one chromosome on each
machine. It also reduces the likelihood of running into the
2 GB file limit applicable to older applications and older versions
of 32-bit UNIX. We are currently using an 81-track Genomedata
archive for our research which has a total size of 18 GB, but the
largest single file (chr1) is only 1.6 GB.

A directory-based Genomedata archive is not ideal for all circumstances,
however, such as when working with genomes with many chromosomes, contigs,
or scaffolds. In these situations, a single file implementation would be much
more efficient. Additionally, having the archive as a single file allows
the archive to be distributed much more easily (without tar/zip/etc).

Note

The default behavior is to implement the Genomedata archive as a
directory if there are fewer than 100 sequences being loaded and as
a single file otherwise.

Added in version 1.1: Single-file-based Genomedata archives

## Creation[](#creation "Link to this heading")

A Genomedata archive contains sequence and may also contain
numerical data associated with that sequence. You can easily load
sequence and numerical data into a Genomedata archive with the
[genomedata-load](#genomedata-load) command (see command details additional details):

```
genomedata-load [-t trackname=signalfile]... [-s sequencefile]... GENOMEDATAFILE
```

This command is a user-friendly shortcut to the typical workflow. The
underlying commands are still installed and may be used if more
fine-grained control is required (for instance, parallel data loading
or adding additional tracks later). The commands and required ordering
are:

1. [genomedata-load-seq](#genomedata-load-seq)
2. [genomedata-open-data](#genomedata-open-data)
3. [genomedata-load-data](#genomedata-load-data)
4. [genomedata-close-data](#genomedata-close-data)

Entire data tracks can later be replaced with the following pipeline:

1. [genomedata-erase-data](#genomedata-erase-data)
2. [genomedata-load-data](#genomedata-load-data)
3. [genomedata-close-data](#genomedata-close-data)

Added in version 1.1: The ability to replace data tracks.

Additional data tracks can be added to an existing archive with the
following pipeline:

1. [genomedata-open-data](#genomedata-open-data)
2. [genomedata-load-data](#genomedata-load-data)
3. [genomedata-close-data](#genomedata-close-data)

Added in version 1.2: The ability to add data tracks.

As of the current version, Genomedata archives must include the
underlying genomic sequence and can only be created with
[genomedata-load-seq](#genomedata-load-seq). A Genomedata archive can be created
without any tracks, however, using the following pipeline:

1. [genomedata-load-seq](#genomedata-load-seq)
2. [genomedata-close-data](#genomedata-close-data)

Added in version 1.2: The ability to create an archive without any data tracks.

Additionally, you may remove portions of data from tracks by hardmasking the
specified data tracks. This can be done anytime after loading in data and
unless specified otherwise will automatically close the archive as well. A
track can be loaded and filtered with the following pipeline:

1. [genomedata-open-data](#genomedata-open-data)
2. [genomedata-load-data](#genomedata-load-data)
3. [genomedata-hardmask](#genomedata-hardmask)

Added in version 1.4: The ability to hardmask tracks.

Note

A call to **h5repack** after
[genomedata-close-data](#genomedata-close-data) may be used to
transparently compress the data.

### Example[](#example "Link to this heading")

The following is a brief example for creating a Genomedata archive from
sequence and signal files.

Given the following two sequence files:

1. A text file, chr1.fa:

   ```
   >chr1
   taaccctaaccctaaccctaaccctaaccctaaccctaaccctaacccta
   accctaaccctaaccctaaccctaaccct
   ```
2. A compressed text file, chrY.fa.gz:

   ```
   >chrY
   ctaaccctaaccctaaccctaaccctaaccctaaccctCTGaaagtggac
   ```

and the following two signal files:

1. signal\_low.wigFix:

   ```
   fixedStep chrom=chr1 start=5 step=1
   0.372
   -2.540
   0.371
   -2.611
   0.372
   -2.320
   ```
2. signal\_high.bed.gz:

   ```
   chrY    0       12      4.67
   chrY    20      23      9.24
   chr1    1       3       2.71
   chr1    3       6       1.61
   chr1    6       24      3.14
   ```

A Genomedata archive (`genomedata.test`) could then be created with the
following command:

```
genomedata-load -s chr1.fa -s chrY.fa.gz -t low=signal_low.wigFix \
    -t high=signal_high.bed.gz genomedata.test
```

or the following pipeline:

```
genomedata-load-seq genomedata.test chr1.fa chrY.fa.gz
genomedata-open-data genomedata.test low high
genomedata-load-data genomedata.test low < signal_low.wigFix
zcat signal_high.bed.gz | genomedata-load-data genomedata.test high
genomedata-close-data genomedata.test
```

Note

chr1.fa and chrY.fa.gz could also be combined into a single
sequence file with two sequences.

Note

If using a glob syntax for your sequence files, remember to put the
glob filename in quotes to avoid having your shell expand the glob
before it genomedata-load uses it (e.g. -s “chr\*.agp.gz”)

Warning

It is important that the sequence names (chrY, chr1) in the signal files
match the sequence identifiers in the sequence files exactly.

## Genomedata usage[](#genomedata-usage "Link to this heading")

### Python interface[](#python-interface "Link to this heading")

The data in Genomedata is accessed through the hierarchy described in
[Overview](#genomedata-overview). A full [Python API](#python-api) is
also available.

Note

The Python API expects that a genomedata archive has already been created.
This can be done manually via the [genomedata-load](#genomedata-load) command.
Alternatively, this can be done programmatically using
:\_load\_seq:load\_seq.

To appreciate the full benefit of Genomedata,
it is most easily used as a context manager:

```
from genomedata import Genome
[...]
gdfilename = "/path/to/genomedata/archive" # or bigWig file
with Genome(gdfilename) as genome:
    [...]
```

Note

If Genome is used as a context manager, it will clean up any opened
Chromosomes automatically.
If not, the Genome object (and all opened chromosomes) should be
closed manually with a call to [`Genome.close()`](#genomedata.Genome.close "genomedata.Genome.close").

### Basic usage[](#basic-usage "Link to this heading")

Genomedata is designed to make it easy to get to the data you want.

Here are a few examples:

**Get arbitrary sequence** (10-bp sequence starting at chr2:1423):

```
>>> chromosome = genome["chr2"]
>>> seq = chromosome.seq[1423:1433]
>>> seq
array([116,  99,  99,  99,  99, 103, 103, 103, 103, 103], dtype=uint8)
>>> seq.tostring()
'tccccggggg'
```

**Get arbitrary data** (data from first 3 tracks for region chr8:999-1000):

```
>>> chromosome = genome["chr8"]
>>> chromosome[999:1001, 0:3]  # Note the half-open, zero-based indexing
array([[ NaN,  NaN,  NaN],
       [ 3. ,  5.5,  3.5], dtype=float32)
```

**Get data for a specific track** (specified data in first 5-bp of chr1):

```
>>> chromosome = genome["chr1"]
>>> data = chromosome[0:5, "sample_track"]
>>> data
array([ 47.,  NaN,  NaN,  NaN,  NaN], dtype=float32)
```

*Only specified data*:

```
>>> from numpy import isfinite
>>> data[isfinite(data)]
array([ 47.], dtype=float32)
```

Note

Specify a slice for the track to keep the data in column form:

```
>>> col_index = chromosome.index_continuous("sample_track")
>>> data = chromosome[0:5, col_index:col_index+1]
```

### BigWig differences[](#bigwig-differences "Link to this heading")

There are a number of minor differences between using the genomedata file
format and the bigWig file format:

* There is only one track per bigWig file and it is implicitly set to the
  filename of the bigWig.
* Track indexing is only used to shape dimensionality of output.
* Summary statistics are taken from the bigWig file formation definition
  which are stored as integers. There may be some differences precision.
* Each `Chromosome` is represented with 1 underlying
  `Supercontig`.

#### Command-line interface[](#command-line-interface "Link to this heading")

Genomedata archives can be created and loaded from the command line
with the [genomedata-load](#genomedata-load) command.

### genomedata-load[](#genomedata-load "Link to this heading")

This is a convenience script that will do everything necessary to
create a Genomedata archive. This script takes as input:

* assembly files in either [FASTA](http://www.ncbi.nlm.nih.gov/blast/fasta.shtml) (`.fa` or `.fa.gz`) format (where the
  sequence identifiers are the names of the chromosomes/scaffolds to
  create), or assembly files in AGP format (when used with
  `--assembly`). This is **mandatory**, despite having an
  option interface.
* trackname, datafile pairs (specified as `trackname=datafile`), where:
  :   + trackname is a `string` i