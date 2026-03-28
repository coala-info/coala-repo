AMPtk

latest

* [AMPtk Overview](overview.html)
* [AMPtk Quick Start](quick-start.html)
* [AMPtk file formats](file-formats.html)
* [AMPtk Pre-Processing](pre-processing.html)
* [AMPtk Clustering](clustering.html)
* [AMPtk OTU Table Filtering](filtering.html)
* [AMPtk Taxonomy](taxonomy.html)
* [AMPtk Commands](commands.html)
* [AMPtk Downstream Tools](downstream.html)

AMPtk

* AMPtk documentation
* [Edit on GitHub](https://github.com/nextgenusfs/amptk/blob/master/docs/index.rst)

---

# AMPtk documentation[¶](#amptk-documentation "Link to this heading")

AMPtk is a series of scripts to process NGS amplicon data using USEARCH and VSEARCH, it can also be used to process any NGS amplicon data and includes databases setup for analysis of fungal ITS, fungal LSU, bacterial 16S, and insect COI amplicons. It can handle Ion Torrent, MiSeq, and 454 data. At least USEARCH v9.1.13 and VSEARCH v2.2.0 were required as of AMPtk v0.7.0.

Update November 2021: As of AMPtk v1.5.1, USEARCH is no longer a dependency as all of the processing can be done with VSEARCH 64-bit. This means that default/hybrid taxonomy assignment uses just global alignment and SINTAX – however the added benefit here is that we are not constrained by the 4 GB RAM limit of the 32-bit version of USEARCH.

# Citation[¶](#citation "Link to this heading")

```
Palmer JM, Jusino MA, Banik MT, Lindner DL. 2018. Non-biological synthetic spike-in controls
        and the AMPtk software pipeline improve mycobiome data. PeerJ 6:e4925;
        DOI 10.7717/peerj.4925. https://peerj.com/articles/4925/
```

# Install[¶](#install "Link to this heading")

There are several ways to install AMPtk, the easiest and recommended way is with Conda

```
#setup your conda env with bioconda, type the following in order to setup channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

#create amptk env (optional)
conda create -n amptk amptk
```

You can install the python portion of AMPtk with pip, but you will need to then install the external dependencies such as usearch, vsearch, DADA2 and the amptk stats script will need to install R dependencies.

```
pip install amptk
```

Users can also install manually, download a [release](https://github.com/nextgenusfs/amptk/releases). You can also build the latest unreleased version from github:

```
#clone the repository
git clone https://github.com/nextgenusfs/amptk.git

#then install, optional add --prefix to control location
python setup.py install --prefix /User/Tools/amptk
```

# Dependencies Requiring Manual Install for Older version of AMPtk (Deprecated)[¶](#dependencies-requiring-manual-install-for-older-version-of-amptk-deprecated "Link to this heading")

1. AMPtk utilizes USEARCH9 which must be installed manually from the developer [here](http://www.drive5.com/usearch/download.html). Obtain the proper version of USEARCH v9.2.64 and softlink into the PATH:

```
#make executable
sudo chmod +x /path/to/usearch9.2.64_i86osx32

#create softlink
sudo ln -s /path/to/usearch9.2.64_i86osx32 /usr/local/bin/usearch9
```

1b) (optional) One script also requires USEARCH10, so you can download usearch10 and put into your path as follows:

```
#make executable
sudo chmod +x /path/to/usearch10.0.240_i86osx32

#create softlink
sudo ln -s /path/to/usearch10.0.240_i86osx32 /usr/local/bin/usearch10
```

2. (optional) LULU post-clustering OTU table filtering via `amptk lulu` requires the R package [LULU](https://github.com/tobiasgf/lulu). Install requires devtools.

```
#install devtools if you don't have already
install.packages('devtools')
library('devtools')
install_github("tobiasgf/lulu")

#not listed as dependency but on my system also requires dpylr
install.packages('dpylr') or perhaps all of tidyverse install.packages('tidyverse')

#could also install tidyverse from conda
conda install r-tidyverse
```

# Dependencies installed via package managers[¶](#dependencies-installed-via-package-managers "Link to this heading")

You only need to worry about these dependencies if you installed manually and/or some will be necessary if used homebrew for installation (for example homebrew doesn’t install R packages)

1. AMPtk requires VSEARCH, which you can install from [here](https://github.com/torognes/vsearch). Note, if you use homebrew recipe it will be install automatically or can use conda.

```
#install vsearch with homebrew
brew install vsearch

#or with bioconda
conda install -c bioconda vsearch
```

2. Several Python modules are also required, they can be installed with pip or conda:

```
#install with pip
pip install -U biopython natsort pandas numpy matplotlib seaborn edlib biom-format psutil

#install with conda
conda install biopython natsort pandas numpy matplotlib seaborn python-edlib biom-format psutil
```

3. (optional) DADA2 denoising algorithm requires installation of R and DADA2. Instructions are located [here](http://benjjneb.github.io/dada2/).

```
#install with conda/bioconda
conda install r-base bioconductor-dada2
```

4. (optional) To run some preliminary community ecology stats via `amptk stats` you will also need the R package [Phyloseq](https://joey711.github.io/phyloseq/). One way to install with conda:

```
#install with conda/bioconda
conda install r-base bioconductor-phyloseq
```

# Run from Docker[¶](#run-from-docker "Link to this heading")

There is a base installation of AMPtk on Docker at nextgenusfs/amptk-base and then one with taxonomy databases at nextgenusfs/amptk. I’ve written a wrapper script that will run the docker image, simply have to download the script and ensure its executable.

1. Download the Dockerfile build file.

```
$ wget -O amptk-docker https://raw.githubusercontent.com/nextgenusfs/amptk/master/amptk-docker
$ chmod +x amptk-docker
```

# More Information[¶](#more-information "Link to this heading")

* [AMPtk Overview](overview.html#overview) - an overview of the steps in AMPtk.
* [AMPtk Quick Start](quick-start.html#quick-start) - walkthrough of test data.
* [AMPtk Pre-Processing](pre-processing.html#pre-processing) - details of the critical pre-processing steps.
* [AMPtk Clustering](clustering.html#clustering) - overview of clustering/denoising algorithms in AMPtk
* [AMPtk OTU Table Filtering](filtering.html#filtering) - OTU table filtering based on Mock community
* [AMPtk Taxonomy](taxonomy.html#taxonomy) - assigning taxonomy in AMPtk
* [AMPtk all commands](commands.html#commands) - all commands in AMPtk

[Next](overview.html "AMPtk Overview")

---

© Copyright 2017, Jon Palmer.
Revision `15f497c3`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).