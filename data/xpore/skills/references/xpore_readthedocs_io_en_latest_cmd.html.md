[xpore](index.html)

latest

* [Installation](installation.html)
* [Quickstart - Detection of differential RNA modifications](quickstart.html)
* [Output table description](outputtable.html)
* [Configuration file](configuration.html)
* [Data preparation from raw reads](preparation.html)
* [Data](data.html)
* Command line arguments
  + [`xpore-dataprep`](#xpore-dataprep)
  + [`xpore-diffmod`](#xpore-diffmod)
  + [`xpore-postprocessing`](#xpore-postprocessing)
* [Citing xPore](citing.html)
* [Getting Help](help.html)

[xpore](index.html)

* [Docs](index.html) »
* Command line arguments
* [Edit on GitHub](https://github.com/GoekeLab/xpore/blob/master/docs/source/cmd.rst)

---

# Command line arguments[¶](#command-line-arguments "Permalink to this headline")

We provide 2 main scripts to run the analysis of differential RNA modifications as the following.

## `xpore-dataprep`[¶](#xpore-dataprep "Permalink to this headline")

* Input

Output files from `nanopolish eventalgin`. Please refer to [Data preparation](preparation.html#preparation) for the full Nanopolish command.

| Argument name | Required | Default value | Description |
| --- | --- | --- | --- |
| –eventalign=FILE | Yes | NA | Eventalign filepath, the output from nanopolish. |
| –out\_dir=DIR | Yes | NA | Output directory. |
| –gtf\_path\_or\_url | No | NA | GTF file path or url used for mapping transcriptomic to genomic coordinates. |
| –transcript\_fasta\_paths\_or\_urls | No | NA | Transcript FASTA paths or urls used for mapping transcriptomic to genomic coordinates. |
| –skip\_eventalign\_indexing | No | False | To skip indexing the eventalign nanopolish output. |
| –genome | No | False | To run on Genomic coordinates. Without this argument, the program will run on transcriptomic coordinates. |
| –n\_processes=NUM | No | 1 | Number of processes to run. |
| –readcount\_max=NUM | No | 1000 | Maximum read counts per gene. |
| –readcount\_min=NUM | No | 1 | Minimum read counts per gene. |
| –resume | No | False | With this argument, the program will resume from the previous run. |

* Output

| File name | File type | Description |
| --- | --- | --- |
| eventalign.index | csv | File index indicating the position in the eventalign.txt file (the output of nanopolish eventalign) where the segmentation information of each read index is stored, allowing a random access. |
| data.json | json | Intensity level mean for each position. |
| data.index | csv | File index indicating the position in the data.json file where the intensity level means across positions of each gene is stored, allowing a random access. |
| data.log | txt | Gene ids being processed. |
| data.readcount | csv | Summary of readcounts per gene. |

## `xpore-diffmod`[¶](#xpore-diffmod "Permalink to this headline")

* Input

Output files from `xpore-dataprep`.

| Argument name | Required | Default value | Description |
| --- | --- | --- | --- |
| –config=FILE | Yes | NA | YAML configurtaion filepath. |
| –n\_processes=NUM | No | 1 | Number of processes to run. |
| –save\_models | No | False | With this argument, the program will save the model parameters for each id. |
| –resume | No | False | With this argument, the program will resume from the previous run. |
| –ids=LIST | No | [] | Gene / Transcript ids to model. |

* Output

| File name | File type | Description |
| --- | --- | --- |
| diffmod.table | csv | Output table information of differential modification rates. Please refer to [Output table description](outputtable.html#outputtable) for the full description. |
| diffmod.log | txt | Gene/Transcript ids being processed. |

## `xpore-postprocessing`[¶](#xpore-postprocessing "Permalink to this headline")

* Input

The `diffmod.table` file from `xpore-diffmod`.

| Argument name | Required | Description |
| --- | --- | --- |
| –diffmod\_dir | Yes | Path of the directory containing `diffmod.table`. |

[Next](citing.html "Citing xPore")
 [Previous](data.html "Data")

---

© Copyright 2020, Ploy N. Pratanwanich
Revision `3bf7114e`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).