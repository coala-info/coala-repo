[pyfastx](index.html)

Contents:

* [Installation](installation.html)
* [FASTX](usage.html)
* [FASTA](usage.html#fasta)
* [Sequence](usage.html#sequence)
* [FASTQ](usage.html#fastq)
* [Read](usage.html#read)
* [FastaKeys](usage.html#fastakeys)
* [FastqKeys](usage.html#fastqkeys)
* [Command line interface](commandline.html)
* [Multiple processes](advance.html)
* [Drawbacks](drawbacks.html)
* Changelog
  + [Version 2.1.0 (2024-02-28)](#version-2-1-0-2024-02-28)
  + [Version 2.0.2 (2023-11-25)](#version-2-0-2-2023-11-25)
  + [Version 2.0.1 (2023-09-18)](#version-2-0-1-2023-09-18)
  + [Version 2.0.0 (2023-09-05)](#version-2-0-0-2023-09-05)
  + [Version 1.1.0 (2023-04-19)](#version-1-1-0-2023-04-19)
  + [Version 1.0.1 (2023-03-28)](#version-1-0-1-2023-03-28)
  + [Version 1.0.0 (2023-03-24)](#version-1-0-0-2023-03-24)
  + [Version 0.9.1 (2022-12-31)](#version-0-9-1-2022-12-31)
  + [Version 0.9.0 (2022-12-30)](#version-0-9-0-2022-12-30)
  + [Older versions](#older-versions)
    - [Version 0.8.4 (2021-06-30)](#version-0-8-4-2021-06-30)
    - [Version 0.8.3 (2021-04-25)](#version-0-8-3-2021-04-25)
    - [Version 0.8.2 (2021-01-02)](#version-0-8-2-2021-01-02)
    - [Version 0.8.1 (2020-12-16)](#version-0-8-1-2020-12-16)
    - [Version 0.8.0 (2020-12-15)](#version-0-8-0-2020-12-15)
    - [Version 0.7.0 (2020-09-20)](#version-0-7-0-2020-09-20)
    - [Version 0.6.17 (2020-08-31)](#version-0-6-17-2020-08-31)
    - [Version 0.6.16 (2020-08-27)](#version-0-6-16-2020-08-27)
    - [Version 0.6.15 (2020-08-25)](#version-0-6-15-2020-08-25)
    - [Version 0.6.14 (2020-07-31)](#version-0-6-14-2020-07-31)
    - [Version 0.6.13 (2020-07-09)](#version-0-6-13-2020-07-09)
    - [Version 0.6.12 (2020-06-14)](#version-0-6-12-2020-06-14)
    - [Version 0.6.11 (2020-05-18)](#version-0-6-11-2020-05-18)
    - [Version 0.6.10 (2020-04-22)](#version-0-6-10-2020-04-22)
    - [Version 0.6.9 (2020-04-12)](#version-0-6-9-2020-04-12)
    - [Version 0.6.8 (2020-03-14)](#version-0-6-8-2020-03-14)
    - [Version 0.6.7 (2020-03-03)](#version-0-6-7-2020-03-03)
    - [Version 0.6.6 (2020-02-15)](#version-0-6-6-2020-02-15)
    - [Version 0.6.5 (2020-01-31)](#version-0-6-5-2020-01-31)
    - [Version 0.6.4 (2020-01-14)](#version-0-6-4-2020-01-14)
    - [Version 0.6.3 (2020-01-08)](#version-0-6-3-2020-01-08)
    - [Version 0.6.2 (2020-01-04)](#version-0-6-2-2020-01-04)
    - [Version 0.6.1 (2020-01-03)](#version-0-6-1-2020-01-03)
    - [Version 0.6.0 (2020-01-02)](#version-0-6-0-2020-01-02)
    - [Version 0.5.10 (2019-11-20)](#version-0-5-10-2019-11-20)
    - [Version 0.5.9 (2019-11-17)](#version-0-5-9-2019-11-17)
    - [Version 0.5.8 (2019-11-10)](#version-0-5-8-2019-11-10)
    - [Version 0.5.7 (2019-11-09)](#version-0-5-7-2019-11-09)
    - [Version 0.5.6 (2019-11-08)](#version-0-5-6-2019-11-08)
    - [Version 0.5.5 (2019-11-07)](#version-0-5-5-2019-11-07)
    - [Version 0.5.4 (2019-11-04)](#version-0-5-4-2019-11-04)
    - [Version 0.5.3 (2019-10-23)](#version-0-5-3-2019-10-23)
    - [Version 0.5.2 (2019-10-18)](#version-0-5-2-2019-10-18)
    - [Version 0.5.1 (2019-10-17)](#version-0-5-1-2019-10-17)
    - [Version 0.5.0 (2019-10-13)](#version-0-5-0-2019-10-13)
    - [Version 0.4.1 (2019-10-05)](#version-0-4-1-2019-10-05)
    - [Version 0.4.0 (2019-09-29)](#version-0-4-0-2019-09-29)
    - [Version 0.3.10 (2019-09-27)](#version-0-3-10-2019-09-27)
    - [Version 0.3.9 (2019-09-26)](#version-0-3-9-2019-09-26)
    - [Version 0.3.8 (2019-09-25)](#version-0-3-8-2019-09-25)
    - [Version 0.3.7 (2019-09-24)](#version-0-3-7-2019-09-24)
    - [Version 0.3.6 (2019-09-20)](#version-0-3-6-2019-09-20)
    - [Version 0.3.5 (2019-09-08)](#version-0-3-5-2019-09-08)
    - [Version 0.3.4 (2019-09-07)](#version-0-3-4-2019-09-07)
    - [Version 0.3.3 (2019-09-07)](#version-0-3-3-2019-09-07)
    - [Version 0.3.2 (2019-09-07)](#version-0-3-2-2019-09-07)
    - [Version 0.3.1 (2019-09-07)](#version-0-3-1-2019-09-07)
    - [Version 0.3.0 (2019-09-07)](#version-0-3-0-2019-09-07)
    - [Version 0.2.11 (2019-08-31)](#version-0-2-11-2019-08-31)
    - [Version 0.2.10 (2019-08-28)](#version-0-2-10-2019-08-28)
    - [Version 0.2.9 (2019-08-27)](#version-0-2-9-2019-08-27)
    - [Version 0.2.8 (2019-08-26)](#version-0-2-8-2019-08-26)
    - [Version 0.2.7 (2019-08-26)](#version-0-2-7-2019-08-26)
    - [Version 0.2.6 (2019-08-26)](#version-0-2-6-2019-08-26)
    - [Version 0.2.5 (2019-08-25)](#version-0-2-5-2019-08-25)
    - [Version 0.2.4 (2019-08-25)](#version-0-2-4-2019-08-25)
    - [Version 0.2.3 (2019-08-24)](#version-0-2-3-2019-08-24)
    - [Version 0.2.2 (2019-07-19)](#version-0-2-2-2019-07-19)
    - [Version 0.2.1 (2019-07-15)](#version-0-2-1-2019-07-15)
    - [Version 0.2.0 (2019-07-09)](#version-0-2-0-2019-07-09)
* [API Reference](api_reference.html)
* [Acknowledgements](acknowledgements.html)

[pyfastx](index.html)

* Changelog
* [View page source](_sources/changelog.rst.txt)

---

# Changelog[](#changelog "Link to this heading")

## Version 2.1.0 (2024-02-28)[](#version-2-1-0-2024-02-28 "Link to this heading")

* Added support for Python 3.12
* Fixed fasta sequence composition error
* Fixed fastq continuous reading error

## Version 2.0.2 (2023-11-25)[](#version-2-0-2-2023-11-25 "Link to this heading")

* Fixed subsequence return None error

## Version 2.0.1 (2023-09-18)[](#version-2-0-1-2023-09-18 "Link to this heading")

* Speedup the gzip index writing to index file

## Version 2.0.0 (2023-09-05)[](#version-2-0-0-2023-09-05 "Link to this heading")

* Added support for file name with wide char
* Added support for specifying index file path
* Added support for more characters in DNA sequence
* Added reverse complement function for DNA conversion
* Improved the performance of kseq library
* Optimized gzip index importing and saving without temp file
* Fixed segmentation fault when using sequence composition
* Fixed memory leak in Fastq read quality integer
* Fixed zlib download url broken error when building

## Version 1.1.0 (2023-04-19)[](#version-1-1-0-2023-04-19 "Link to this heading")

* Fixed unicode error when reading fastq file

## Version 1.0.1 (2023-03-28)[](#version-1-0-1-2023-03-28 "Link to this heading")

* Fixed invalid uppercase when iterating fastx

## Version 1.0.0 (2023-03-24)[](#version-1-0-0-2023-03-24 "Link to this heading")

* Added support for fasta header without space
* Fixed some files missing in pypi tar.gz file

## Version 0.9.1 (2022-12-31)[](#version-0-9-1-2022-12-31 "Link to this heading")

* Fixed unicode decode error when parsing large fasta/q file
* Fixed sequence retrival error when using sequence object from loop after break

## Version 0.9.0 (2022-12-30)[](#version-0-9-0-2022-12-30 "Link to this heading")

* Added support for Python3.10, 3.11
* Added support for aarch64 and musllinux
* Added using tab as fasta sequence name splitter
* Fixed repeat sequence comment error
* Fixed the quality score parsing error from fastq
* Fixed the reference of sequence returned from function

## Older versions[](#older-versions "Link to this heading")

### Version 0.8.4 (2021-06-30)[](#version-0-8-4-2021-06-30 "Link to this heading")

* Added slice feature to FastaKeys
* Fixed FastaKeys and FastqKeys iteration memory leak
* Optimized FastaKeys and FastqKeys creation

### Version 0.8.3 (2021-04-25)[](#version-0-8-3-2021-04-25 "Link to this heading")

* Fixed Fastx iteration for next function
* Fixed Fastx uppercase for reading fasta

### Version 0.8.2 (2021-01-02)[](#version-0-8-2-2021-01-02 "Link to this heading")

* Fixed sample segfault error caused by fastq iteration error
* Fixed gzip index import error in multiple processes
* Fixed fastq iteration segfault error with full\_name=True
* Fixed all objects iteration to support built-in next function

### Version 0.8.1 (2020-12-16)[](#version-0-8-1-2020-12-16 "Link to this heading")

* Fixed pip install error from source code
* Removed support for python39 32bit due to dll load error

### Version 0.8.0 (2020-12-15)[](#version-0-8-0-2020-12-15 "Link to this heading")

* Added Fastx object as a simple sequence iterator
* Added FastqKeys object to obtain read names
* Added full\_name option to Fastq object
* Added support for Python 3.9
* Fixed Fasta object error identifier order
* Optimized speed of containing test and iteration
* Changed Identifier object to FastaKeys object

### Version 0.7.0 (2020-09-20)[](#version-0-7-0-2020-09-20 "Link to this heading")

* Added support for extracting flank sequences
* Added support for indexing super large gzip file
* Reduced memory consumption when building gzip index
* Improved the speed of random access to reads from fastq
* Fixed sequence dealloc error cuasing no fasta delloc trigger
* Fixed fastq max and min quality score return value

### Version 0.6.17 (2020-08-31)[](#version-0-6-17-2020-08-31 "Link to this heading")

* Fixed gzip index loading error when no write permission

### Version 0.6.16 (2020-08-27)[](#version-0-6-16-2020-08-27 "Link to this heading")

* Increased the buff size of kseq to speedup sequence iteration
* Removed warning message from fasta.c when building full index

### Version 0.6.15 (2020-08-25)[](#version-0-6-15-2020-08-25 "Link to this heading")

* Fixed key\_func error caused by free operation
* Fixed full name error when reading sequence without whitespace in names
* Fixed a hidden bug in fasta/q iteration when reading attributes (not seq)
* Fixed fasta/fastq size and sequence count error on Windows when parsing large file
* Fixed zlib 2gb and 4gb limit on windows x64 to support large file
* Reduced seek point span size to speedup random access from gzip file

### Version 0.6.14 (2020-07-31)[](#version-0-6-14-2020-07-31 "Link to this heading")

* Added support for using full header as identifier without building index
* Improved the speed of fasta sequence iteration
* Improved the speed of gzipped fastq read iteration
* Fixed a bug in fastq read reader

### Version 0.6.13 (2020-07-09)[](#version-0-6-13-2020-07-09 "Link to this heading")

* Fixed fastq read iteration error
* Fixed fastq cache buffer reader
* Added cache for mean, median and N50 length
* Speedup fasta iteration by reduced seeks

### Version 0.6.12 (2020-06-14)[](#version-0-6-12-2020-06-14 "Link to this heading")

* Fixed DeprecationWarning on py38 caused by ‘#’ formats args
* Fixed some memory leak bugs
* Cached sequence name to speedup fetch method
* Used random string as gzip index temp file to support multiple processes

### Version 0.6.11 (2020-05-18)[](#version-0-6-11-2020-05-18 "Link to this heading")

* Fixed iteration error on Windows
* Fixed test error on Windows
* Fixed fastq composition error on 32bit OS
* Improved the speed of fasta identifier sort and filter

### Version 0.6.10 (2020-04-22)[](#version-0-6-10-2020-04-22 "Link to this heading")

* Improved the speed of sequence reading
* Improved the speed of sequence line iteration
* Added avglen, minlen, maxlen, minqual and maxqual to Fastq object
* Fixed read retrieval error
* Fixed some hidden memory leaks
* Changed fastq index file structure to save more information

### Version 0.6.9 (2020-04-12)[](#version-0-6-9-2020-04-12 "Link to this heading")

* Added buffreader to improve speed for reading from gzipped file
* Added extract subcommand to extract sequences from fasta/q file
* Added build subcommand to just build index
* Changed info subcommand output to a tab seperated table
* Changed Fastq object composition parameter to full\_index

### Version 0.6.8 (2020-03-14)[](#version-0-6-8-2020-03-14 "Link to this heading")

* Fixed large offset seek error on windows
* Fixed PyUnicode\_AsUTF8 const char type warning
* Changed sequence read line by line function
* Changed gzread to fread for fastq information

### Version 0.6.7 (2020-03-03)[](#version-0-6-7-2020-03-03 "Link to this heading")

* Added check for fasta/q format when open file
* Added benchmark scripts for evaluating performance
* Speed up the fasta/q object iteration
* Optimzed str length warning caused by strlen

### Version 0.6.6 (2020-02-15)[](#version-0-6-6-2020-02-15 "Link to this heading")

* Fixed incorrect sliced sequence name
* Fixed seq,identifier,read object memory dealloc
* Changed description text into description length in index file

### Version 0.6.5 (2020-01-31)[](#version-0-6-5-2020-01-31 "Link to this heading")

* Reduced memory usage when building index for large fasta
* Removed rebuild\_index method from Fasta object due to segmentation fault
* Optimized compatibility between sqlite3 and python GIL

### Version 0.6.4 (2020-01-14)[](#version-0-6-4-2020-01-14 "Link to this heading")

* Fixed last sequence fetching error caused by missing n
* Improved fasta/q object key error message to make it more human

### Version 0.6.3 (2020-01-08)[](#version-0-6-3-2020-01-08 "Link to this heading")

* Added .raw attribute to sequence object to get seq raw string
* Added .raw attribute to read object to get read raw string
* Added .description to read object to get full header line
* Added iteration for sequence object from FASTA object
* Added iteration for tuple from FASTQ object
* Changed FASTA class parameter composition to full\_index

### Version 0.6.2 (2020-01-04)[](#version-0-6-2-2020-01-04 "Link to this heading")

* Fixed sample sequence index error
* Fixed ci deploy error

### Version 0.6.1 (2020-01-03)[](#version-0-6-1-2020-01-03 "Link to this heading")

* Added sample sequences command line
* Added get subsequence command line

### Version 0.6.0 (2020-01-02)[](#version-0-6-0-2020-01-02 "Link to this heading")

* Fixed FASTA object parameter error
* Fixed identifier sprintf warning
* Fixed fasta description end r retained
* Fixed error byte length when slice sequence
* Removed support for python2.7 and python3.4
* Removed python2 compat
* Disabled export gzip index when building memory index

### Version 0.5.10 (2019-11-20)[](#version-0-5-10-2019-11-20 "Link to this heading")

* Added identifier filter function
* Remove tp\_new for Read, Sequence and Identifier
* Fixed module method error

### Version 0.5.9 (2019-11-17)[](#version-0-5-9-2019-11-17 "Link to this heading")

* Added get longest and shortest sequence object
* Added composition argument to speedup getting GC content
* Added memory index to keep index in memory rather than local file
* Fixed command line error
* Changed sqlite to higher version
* Removed journal\_mode OFF
* Speedup index building

### Version 0.5.8 (2019-11-10)[](#version-0-5-8-2019-11-10 "Link to this heading")

* Fixed fasta NL function parameter check
* Fixed read id error when fastq iteration

### Version 0.5.7 (2019-11-09)[](#version-0-5-7-2019-11-09 "Link to this heading")

* Fixed SystemError caused caused by Python 2.7 seperated int and long type
* Fixed String type check on Python 2.7
* Fixed objects memory deallocation

### Version 0.5.6 (2019-11-08)[](#version-0-5-6-2019-11-08 "Link to this heading")

* Optimized random access from plain file
* Reduced memory