![emerald](emerald.png)

# EMerAld (EMA)

massachusetts institute of technology ([mit](http://web.mit.edu/))
computer science and artificial intelligence laboratory ([csail](http://www.csail.mit.edu/))
theory of computation group ([toc](http://theory.lcs.mit.edu/))
computation and biology group ([compbio](http://people.csail.mit.edu/bab/index.html))

email queries bab@mit.edu

---

### Overview

EMA is an alignment tool for barcoded short-read sequencing data, such as those produced by 10x Genomics' Chromium platform. EMA is faster and more accurate than current aligners, and produces not only the final alignments but interpretable per-alignment *probabilities*.

EMA takes a set of barcoded FASTQs as input, preprocesses them into a series of barcode buckets that can be processed in parallel, and produces a standard SAM/BAM file as output.

Source code and documentation are available [on GitHub](https://github.com/arshajii/ema/). Detailed guidelines and resources for reproducing our results are available [here](https://github.com/arshajii/ema-paper-data/).

Ariya Shajii, Ibrahim Numanagić, Bonnie Berger; [Latent variable model for aligning barcoded short-reads improves downstream analyses](https://www.biorxiv.org/content/early/2017/11/16/220236).

### Install

##### With brew 🍺

`brew install brewsci/bio/ema`

##### With conda 🐍

`conda install -c bioconda ema`

##### From source 🛠

`git clone --recursive https://github.com/arshajii/ema
cd ema
make`

### Test Datasets

**10x data**

* [NA12878](https://support.10xgenomics.com/genome-exome/datasets/2.1.0/NA12878_WGS_210) and [NA12878 v2](https://support.10xgenomics.com/genome-exome/datasets/2.1.4/NA12878_WGS_v2) from 10x Genomics
* NA24149, NA24143 and NA24385 from Broad Institute (contact arshajii@mit.edu for details)
* [10x barcode whitelist](data/4M-with-alts-february-2016.txt) (February 2016)

**Other data**

* [NA12878 Illumina TruSeq Synthetic Long-Read](https://www.ncbi.nlm.nih.gov/sra/SRX1070739%5Baccn%5D)
* [NA12878 CPT-seq](https://www.ncbi.nlm.nih.gov/sra/SRX660455%5Baccn%5D)