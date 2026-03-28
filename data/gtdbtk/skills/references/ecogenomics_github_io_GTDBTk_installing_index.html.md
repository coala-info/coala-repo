[![Logo](../_static/GTDBTk.svg)](../index.html)

2.6.1

Getting started

* [Announcements](../announcements.html)
* Installing GTDB-Tk
  + [Sources](#sources)
    - [Bioconda](bioconda.html)
    - [pip](pip.html)
    - [Docker](docker.html)
  + [Hardware requirements](#hardware-requirements)
  + [Python libraries](#python-libraries)
  + [Third-party software](#third-party-software)
  + [GTDB-Tk reference data](#gtdb-tk-reference-data)
* [FAQ](../faq.html)

Running GTDB-Tk

* [Performance and Accuracy](../performance/index.html)
* [Commands](../commands/index.html)
* [Files](../files/index.html)
* [Example](../examples/classify_wf.html)

About

* [Change log](../changelog.html)
* [References](../references.html)

[GTDB-Tk](../index.html)

* »
* Installing GTDB-Tk
* [Edit on GitHub](https://github.com/Ecogenomics/GTDBTk/blob/master/docs/src/installing/index.rst)

---

# Installing GTDB-Tk[¶](#installing-gtdb-tk "Permalink to this headline")

GTDB-Tk is available through multiple sources, you only need to choose one.
If you are unsure which one to choose, Bioconda is generally the easiest.

## Sources[¶](#sources "Permalink to this headline")

* [Bioconda](bioconda.html)
* [pip](pip.html)
* [Docker](docker.html)

Alternatively, GTDB-Tk can be run online through [KBase](https://kbase.us/applist/apps/kb_gtdbtk/run_kb_gtdbtk) (third party). Note that the version may not be the most recent release.

## Hardware requirements[¶](#hardware-requirements "Permalink to this headline")

| Domain | Memory | Storage | Time |
| --- | --- | --- | --- |
| Archaea | ~60 GB | ~140 GB | ~90 minutes / 1,000 genomes @ 64 CPUs |
| Bacteria | ~110GB (690 GB when using –full\_tree) | ~140 GB | ~90 minutes / 1,000 genomes @ 64 CPUs |

Note

The amount reported of memory reported can vary depending on the number of pplacer threads.
See [GTDB-Tk reaches the memory limit / pplacer crashes](../faq.html#faq-pplacer) for more information.

## Python libraries[¶](#python-libraries "Permalink to this headline")

GTDB-Tk is designed for Python >=3.6 and requires the following libraries, which will be automatically installed:

| Library | Version | Reference |
| --- | --- | --- |
| [DendroPy](https://dendropy.org/) | >= 4.1.0 | Sukumaran, J. and Mark T. Holder. 2010. DendroPy: A Python library for phylogenetic computing. Bioinformatics 26: 1569-1571. |
| [NumPy](https://numpy.org/) | >= 1.9.0 | Harris, C.R., Millman, K.J., van der Walt, S.J. et al. Array programming with NumPy. Nature 585, 357–362 (2020). DOI: [0.1038/s41586-020-2649-2](https://doi.org/10.1038/s41586-020-2649-2) |
| [tqdm](https://github.com/tqdm/tqdm) | >= 4.35.0 | DOI: [10.5281/zenodo.595120](https://doi.org/10.5281/zenodo.595120) |

Please cite these libraries if you use GTDB-Tk in your work.

## Third-party software[¶](#third-party-software "Permalink to this headline")

GTDB-Tk makes use of the following 3rd party dependencies and assumes they are on your system path:

Tip

The [check\_install](../commands/check_install.html#commands-check-install) command will verify that all of the programs are on the path.

| Software | Version | Reference |
| --- | --- | --- |
| [Prodigal](http://compbio.ornl.gov/prodigal/) | >= 2.6.2 | Hyatt D, et al. 2010. [Prodigal: prokaryotic gene recognition and translation initiation site identification](https://www.ncbi.nlm.nih.gov/pubmed/20211023). *BMC Bioinformatics*, 11:119. doi: 10.1186/1471-2105-11-119. |
| [HMMER](http://hmmer.org/) | >= 3.1b2 | Eddy SR. 2011. [Accelerated profile HMM searches](https://www.ncbi.nlm.nih.gov/pubmed/22039361). *PLOS Comp. Biol.*, 7:e1002195. |
| [pplacer](http://matsen.fhcrc.org/pplacer/) | >= 1.1 | Matsen FA, et al. 2010. [pplacer: linear time maximum-likelihood and Bayesian phylogenetic placement of sequences onto a fixed reference tree](https://www.ncbi.nlm.nih.gov/pubmed/21034504). *BMC Bioinformatics*, 11:538. |
| [skani](https://github.com/bluenote-1577/skani/) | >= 0.2.1 | Shaw J. and Yu Y.W. 2023. [Fast and robust metagenomic sequence comparison through sparse chaining with skani](https://www.nature.com/articles/s41592-023-02018-3). *Nature Methods*, 20, pages1661–1665 (2023). |
| [FastTree](http://www.microbesonline.org/fasttree/) | >= 2.1.9 | Price MN, et al. 2010. [FastTree 2 - Approximately Maximum-Likelihood Trees for Large Alignments](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2835736/). *PLoS One*, 5, e9490. |

Please cite these tools if you use GTDB-Tk in your work.

## GTDB-Tk reference data[¶](#gtdb-tk-reference-data "Permalink to this headline")

GTDB-Tk requires ~140G of external data that needs to be downloaded and unarchived:

**For full package:**

```
wget https://data.ace.uq.edu.au/public/gtdb/data/releases/latest/auxillary_files/gtdbtk_package/full_package/gtdbtk_data.tar.gz
wget https://data.gtdb.ecogenomic.org/releases/latest/auxillary_files/gtdbtk_package/full_package/gtdbtk_data.tar.gz ( mirror for Australia)
tar xvzf gtdbtk_data.tar.gz
```

**For split package:**

To create an archive from the GTDB-Tk release data parts:

1. Ensure all parts of the GTDB-Tk release data are in the same directory.
2. Open a terminal or command prompt.
3. Navigate to the directory containing the parts of the GTDB-Tk release data.
4. Use the following command to concatenate all parts into a single archive:
   cat gtdbtk\_r220\_data.tar.gz.part\_\* > gtdbtk\_r220\_data.tar.gz
5. Once the command finishes executing, you will have a single archive file named ‘gtdbtk\_r220\_data.tar.gz’ in the same directory.

You can find the gtdbtk\_r226\_data.tar.gz.part\_\* files under:
<https://data.ace.uq.edu.au/public/gtdb/data/releases/release226/226.0/auxillary_files/gtdbtk_package/split_package/>

**Alias the GTDB-Tk reference data:**

GTDB-Tk requires an environment variable named `GTDBTK_DATA_PATH` to be set to the directory
containing the unarchived reference data. This is documented under:

* [pip installation](pip.html#installing-pip)
* [Bioconda installation](bioconda.html#installing-bioconda)
* [Docker installation](docker.html#installing-docker)

Note

Note that different versions of the GTDB release data may not run on all versions of GTDB-Tk, check the supported versions!

| GTDB Release | Minimum version | Maximum version | MD5 |
| --- | --- | --- | --- |
| [R226](https://data.gtdb.ecogenomic.org/releases/release226/226.0/auxillary_files/gtdbtk_package/full_package/gtdbtk_r226_data.tar.gz) | 2.4.1 | Current | 24b476ea5a4ef30519d461e56cc4a27f |
| [R220](https://data.gtdb.ecogenomic.org/releases/release220/220.0/auxillary_files/gtdbtk_package/full_package/gtdbtk_r220_data.tar.gz) | 2.4.0 | Current | 5aafa1b9c27ceda003d75adf238ed9e0 |
| [R214](https://data.gtdb.ecogenomic.org/releases/release214/214.0/auxillary_files/gtdbtk_r214_data.tar.gz) | 2.1.0 | 2.3.2 | 630745840850c532546996b22da14c27 |
| [R207\_v2](https://data.gtdb.ecogenomic.org/releases/release207/207.0/auxillary_files/gtdbtk_r207_v2_data.tar.gz) | 2.1.0 | 2.3.2 | df468d63265e8096d8ca01244cb95f30 |
| [R207](https://data.gtdb.ecogenomic.org/releases/release207/207.0/auxillary_files/gtdbtk_r207_data.tar.gz) | 2.0.0 | 2.0.0 | b04c55104b491f84e053a9011b36164a |
| [R202](https://data.gtdb.ecogenomic.org/releases/release202/202.0/auxillary_files/gtdbtk_r202_data.tar.gz) | 1.5.0 | 1.7.0 | 4986526c2b935fd4dcc2e604c0322517 |
| [R95](https://data.gtdb.ecogenomic.org/releases/release95/95.0/auxillary_files/gtdbtk_r95_data.tar.gz) | 1.3.0 | 1.4.2 | 06924c63f4b555ac6fd1525b09901186 |
| [R89](https://data.gtdb.ecogenomic.org/releases/release89/89.0/gtdbtk_r89_data.tar.gz) | 0.3.0 | 0.1.2 | 82966ef36086237d7230955e2bfff759 |
| [R86.2](https://data.gtdb.ecogenomic.org/releases/release86/86.2/gtdbtk.r86_v2_data.tar.gz) | 0.2.1 | 0.2.2 | f71408d69fa2a289f2cdc734b7a58a02 |
| [R86](https://data.gtdb.ecogenomic.org/releases/release86/86.0/gtdbtk_r86_data.tar.gz) | 0.1.0 | 0.1.6 | d019b3541746c3673181f24e666594ba |
| [R83](https://data.gtdb.ecogenomic.org/releases/release83/83.0/gtdbtk_r83_data.tar.gz) | 0.0.6 | 0.0.7 | 9cf523761da843b5787f591f6c5a80de |

[Next](bioconda.html "Bioconda")
 [Previous](../announcements.html "Announcements")

---

© Copyright 2025, Pierre-Alain Chaumeil, Aaron Mussig and Donovan Parks.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).