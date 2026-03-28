### Navigation

* [index](../genindex/ "General Index")
* [next](Configure/ "7.1.1. Mikado configure") |
* [previous](../Tutorial/Adapting/ "6. Adapting Mikado to specific user-cases") |
* [Mikado](../) »

# 7. Usage[¶](#usage "Permalink to this headline")

Mikado is composed of four different programs (`configure`, `prepare`, `serialise`, `pick`) which have to be executed serially to go from an ensemble of different assemblies to the final dataset. In addition to these core programs, Mikado provides a utility to compare annotations, similarly to CuffCompare and ParsEval (*compare*), and various other minor utilities to perform operations such as extracting regions from a GFF, convert between different gene annotation formats, etc.

## 7.1. Mikado pipeline stages[¶](#mikado-pipeline-stages "Permalink to this headline")

* [7.1.1. Mikado configure](Configure/)
* [7.1.2. Mikado prepare](Prepare/)
* [7.1.3. Mikado serialise](Serialise/)
* [7.1.4. Mikado pick](Pick/)

The Mikado pipeline is composed of four different stages, that have to be executed serially:

1. [Mikado configure](Configure/#configure), for creating the configuration file that will be used throughout the run.
2. [Mikado prepare](Prepare/#prepare), for collapsing the input assemblies into a single file. After this step, it is possible to perform additional analyses on the data such as TransDecoder (highly recommended), [Portcullis](https://github.com/maplesond/portcullis), or BLAST.
3. [Mikado serialise](Serialise/#serialise), to gather all external data into a single database.
4. [Mikado pick](Pick/#pick), to perform the actual selection of the best transcripts in each locus.

## 7.2. Compare[¶](#compare "Permalink to this headline")

* [7.2.1. Compare](Compare/)

Mikado also comprises a dedicated utility, [Mikado compare](Compare/#compare), to assess the similarity between two annotations.

## 7.3. Daijin[¶](#daijin "Permalink to this headline")

* [7.3.1. The Daijin pipeline for driving Mikado](Daijin/)

Mikado provides a pipeline manager, [Daijin](Daijin/#daijin), to align and assemble transcripts with multiple methods and subsequently choose the best assemblies among the options. The pipeline is implemented using Snakemake [[Snake]](../References/#snake).

## 7.4. Miscellaneous utilities[¶](#miscellaneous-utilities "Permalink to this headline")

* [7.4.1. Mikado miscellaneous scripts](Utilities/)
  + [7.4.1.1. awk\_gtf](Utilities/#awk-gtf)
  + [7.4.1.2. class\_codes](Utilities/#class-codes)
  + [7.4.1.3. convert](Utilities/#convert)
  + [7.4.1.4. grep](Utilities/#grep)
  + [7.4.1.5. merge\_blast](Utilities/#merge-blast)
  + [7.4.1.6. metrics](Utilities/#metrics)
  + [7.4.1.7. stats](Utilities/#stats)
  + [7.4.1.8. trim](Utilities/#trim)
* [7.4.2. Included scripts](Utilities/#included-scripts)
  + [7.4.2.1. add\_transcript\_feature\_to\_gtf.py](Utilities/#add-transcript-feature-to-gtf-py)
  + [7.4.2.2. align\_collect.py](Utilities/#align-collect-py)
  + [7.4.2.3. asm\_collect.py](Utilities/#asm-collect-py)
  + [7.4.2.4. bam2gtf.py](Utilities/#bam2gtf-py)
  + [7.4.2.5. class\_run.py](Utilities/#class-run-py)
  + [7.4.2.6. getFastaFromIds.py](Utilities/#getfastafromids-py)
  + [7.4.2.7. gffjunc\_to\_bed12.py](Utilities/#gffjunc-to-bed12-py)
  + [7.4.2.8. grep.py](Utilities/#grep-py)
  + [7.4.2.9. merge\_junction\_bed12.py](Utilities/#merge-junction-bed12-py)
  + [7.4.2.10. remove\_from\_embl.py](Utilities/#remove-from-embl-py)
  + [7.4.2.11. sanitize\_blast\_db.py](Utilities/#sanitize-blast-db-py)
  + [7.4.2.12. split\_fasta.py](Utilities/#split-fasta-py)
  + [7.4.2.13. trim\_long\_introns.py](Utilities/#trim-long-introns-py)

Finally, Mikado provides some dedicated utilities to perform common tasks.

* Some of the utilities are [integral to the Mikado suite](Utilities/#utils) and can be accessed as subcommands of Mikado. These utilities comprise programs to calculate annotation statistics, retrieve or exclude specific loci from a file, etc.
* Other utilities are provided as [stand-alone scripts](Utilities/#included-scripts); while some of them directly depend on the Mikado library, this is not necessarily the case for them all.

[![Logo](../_static/mikado-logo.png)](../)

### [Table of Contents](../)

* [1. Introduction](../Introduction/)
* [2. Installation](../Installation/)
* [3. Tutorial](../Tutorial/)
* [4. Tutorial for Daijin](../Tutorial/Daijin_tutorial/)
* [5. Tutorial: how to create a scoring configuration file](../Tutorial/Scoring_tutorial/)
* [6. Adapting Mikado to specific user-cases](../Tutorial/Adapting/)
* 7. Usage
  + [7.1. Mikado pipeline stages](#mikado-pipeline-stages)
  + [7.2. Compare](#compare)
  + [7.3. Daijin](#daijin)
  + [7.4. Miscellaneous utilities](#miscellaneous-utilities)
* [8. Mikado core algorithms](../Algorithms/)
* [9. Scoring files](../Scoring_files/)
* [10. References](../References/)
* [11. Mikado](../Library/modules/)

#### Previous topic

[6. Adapting Mikado to specific user-cases](../Tutorial/Adapting/ "previous chapter")

#### Next topic

[7.1.1. Mikado configure](Configure/ "next chapter")

### This Page

* [Show Source](../_sources/Usage/index.rst.txt)

### Quick search

### Navigation

* [index](../genindex/ "General Index")
* [next](Configure/ "7.1.1. Mikado configure") |
* [previous](../Tutorial/Adapting/ "6. Adapting Mikado to specific user-cases") |
* [Mikado](../) »

© Copyright 2015-2021, Venturini Luca, Caim Shabhonam, Mapleson Daniel, Luis Yanes, Kaithakottil Gemy George, Swarbreck David.
Last updated on 06 April 2021.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.5.