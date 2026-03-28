[adVNTR](index.html)

latest

* [FAQ](faq.html)
* [Installation](installation.html)
* Quick Start
  + [Install](#install)
  + [Genotype Predefined VNTR in Simulated Data](#genotype-predefined-vntr-in-simulated-data)
  + [Genotype Custom VNTR](#genotype-custom-vntr)
* [Tutorial](tutorial.html)

[adVNTR](index.html)

* [Docs](index.html) »
* Quick Start
* [Edit on GitHub](https://github.com/mehrdadbakhtiari/adVNTR/blob/master/docs/quickstart.rst)

---

# Quick Start[¶](#quick-start "Permalink to this headline")

To help verify the installation and showing the workflow, we include a small data set and commands to genotype
this simulated dataset. If you have already installed adVNTR, jump to [Genotype Predefined VNTR in Simulated Data](#genotype-simulated-dataset).

## Install[¶](#install "Permalink to this headline")

The easiest way to get started is to [Install adVNTR with conda](installation.html#install-with-conda).
To install adVNTR, run these commands:

```
conda config --add channels bioconda
conda install advntr
```

## Genotype Predefined VNTR in Simulated Data[¶](#genotype-predefined-vntr-in-simulated-data "Permalink to this headline")

To genotype a VNTR in the simulated dataset, one option is to use predefined models.
Download [vntr\_data\_recommended\_loci.zip](https://cseweb.ucsd.edu/~mbakhtia/adVNTR/vntr_data_recommended_loci.zip) and
extract it inside the project directory to use these models from human genome. Here, we genotype a VNTR with id 301645
that corresponds to a disease-linked VNTR. The list of some known VNTRs and their ID is available at
[Disease-linked-VNTRs page](https://github.com/mehrdadbakhtiari/adVNTR/wiki/Disease-linked-VNTRs) in wiki.

Then, download [simulated sequencing data of a human sample](https://cseweb.ucsd.edu/~mbakhtia/adVNTR/quickstart/).
It only includes reads around a VNTR in CSTB gene which is known to be linked to progressive myoclonus epilepsies.
Run this command to get 2/5 genotype for this VNTR.

```
advntr genotype --vntr_id 301645 --alignment_file CSTB_2_5_testdata.bam --working_directory working_dir
```

## Genotype Custom VNTR[¶](#genotype-custom-vntr "Permalink to this headline")

You can train a new model for a VNTR that doesn’t exist in predefined models. Instead of downloading
[vntr\_data\_recommended\_loci.zip](https://cseweb.ucsd.edu/~mbakhtia/adVNTR/vntr_data_recommended_loci.zip), you need
the organism (here, human) reference genome to train a model for a specific VNTR.
[Download chromosome 21 of hg19](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr21.fa.gz) and extract it.
It is recommended to have full reference genome of the organism to add the model, however, we use a single chromosome
in quickstart since it is easier to download and runs faster.
Run this command to add the VNTR in CSTB gene and train VNTR-specific scores:

```
advntr addmodel -r chr21.fa -p CGCGGGGCGGGG -s 45196324 -e 45196360 -c chr21
```

If you run the above command without using predefined models, this VNTR gets the first id.
Run `genotype` command to get 2/5 genotype:

```
advntr genotype --vntr_id 1 --alignment_file CSTB_2_5_testdata.bam --working_directory working_dir
```

[Next](tutorial.html "Tutorial")
 [Previous](publication.html "<no title>")

---

© Copyright 2018, Mehrdad Bakhtiari
Revision `87ac49e4`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).