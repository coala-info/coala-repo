[scHiCExplorer](../../index.html)

latest

* [Installation](../installation.html)
* [scHiCExplorer tools](../list-of-tools.html)
* [News](../News.html)
* [Analysis of single-cell Hi-C data](../Example_analysis.html)

[scHiCExplorer](../../index.html)

* [Docs](../../index.html) »
* scHicDemultiplex
* [Edit on GitHub](https://github.com/joachimwolff/scHiCExplorer/blob/master/docs/content/tools/scHicDemultiplex.rst)

---

# scHicDemultiplex[¶](#schicdemultiplex "Permalink to this headline")

scHicDemultiplex demultiplexes fastq files from Nagano 2017: “Cell-cycle dynamics of chromosomal organization at single-cell resolution” according their barcodes to a seperated forward and reverse strand fastq files per cell.

```
usage: scHicDemultiplex --fastq list of fastq files to demultiplex
                        [list of fastq files to demultiplex ...] --barcodeFile
                        list of fastq files to demultiplex. Use
                        GSE94489_README.txt file. --srrToSampleFile
                        SRRTOSAMPLEFILE [--outputFolder FOLDER]
                        [--threads THREADS] [--bufferSize BUFFERSIZE] [--help]
                        [--version]
```

## Required arguments[¶](#Required arguments "Permalink to this headline")

`--fastq, -f`
:   The fastq files to demultiplex of Nagano 2017 Cell cycle dynamics of chromosomal organization at single-cell resolutionGEO: GSE94489. Files need to have four FASTQ lines per read:/1 forward; /2 barcode forward; /3 bardcode reverse; /4 reverse read.Please be aware the files can be downloaded via the command fastq-dump to be in the right format:fastq-dump –accession SRR5229025 –split-files –defline-seq ‘@$sn[\_$rn]/$ri’ –defline-qual ‘+’ –split-spot –stdout SRR5229025 > SRR5229025.fastq

`--barcodeFile, -bf`
:   The fastq files to demultiplex

`--srrToSampleFile, -s`
:   The mappings from SRR number to sample id as given in the barcode file.

`--outputFolder, -o`
:   Path of folder to save the demultiplexed files

    Default: “demultiplexed”

## Optional arguments[¶](#Optional arguments "Permalink to this headline")

`--threads, -t`
:   Number of threads. Using the python multiprocessing module.

    Default: 4

`--bufferSize, -bs`
:   Number of lines to buffer in memory, if full, write the data to disk.

    Default: 20000000.0

`--version`
:   show program’s version number and exit

---

© Copyright 2019, Joachim Wolff
Revision `8aebb444`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).