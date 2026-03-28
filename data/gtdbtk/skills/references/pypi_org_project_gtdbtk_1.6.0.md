[Skip to main content](#content)
Switch to mobile version

Warning
Some features may not work without JavaScript. Please try enabling it if you encounter problems.

[![PyPI](/static/images/logo-small.8998e9d1.svg)](/)

Search PyPI

Search

* [Help](/help/)
* [Docs](https://docs.pypi.org/)
* [Sponsors](/sponsors/)
* [Log in](/account/login/?next=https%3A%2F%2Fpypi.org%2Fproject%2Fgtdbtk%2F1.6.0%2F)
* [Register](/account/register/)

Menu

* [Help](/help/)
* [Docs](https://docs.pypi.org/)
* [Sponsors](/sponsors/)
* [Log in](/account/login/?next=https%3A%2F%2Fpypi.org%2Fproject%2Fgtdbtk%2F1.6.0%2F)
* [Register](/account/register/)

Search PyPI

Search

# gtdbtk 1.6.0

pip install gtdbtk==1.6.0

Copy PIP instructions

[Newer version available (2.6.1)](/project/gtdbtk/)

Released:
Aug 20, 2021

A toolkit for assigning objective taxonomic classifications to bacterial and archaeal genomes.

### Navigation

* [Project description](#description)
* [Release history](#history)
* [Download files](#files)

### Verified details

*These details have been [verified by PyPI](https://docs.pypi.org/project_metadata/#verified-details)*

###### Maintainers

[![Avatar for aaronmussig from gravatar.com](https://pypi-camo.freetls.fastly.net/2a318f8a94c402994c234fca4fb1f28fbfeee85e/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f37336361363666323638336432373536313930663466663337383361323930373f73697a653d3530 "Avatar for aaronmussig from gravatar.com")
aaronmussig](/user/aaronmussig/)

[![Avatar for dparks from gravatar.com](https://pypi-camo.freetls.fastly.net/360b9abd6bb94666813434d38144a31e9e1a0fe9/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f63623939633130616161633763323733383034343038613266386335666661653f73697a653d3530 "Avatar for dparks from gravatar.com")
dparks](/user/dparks/)

[![Avatar for pierrec from gravatar.com](https://pypi-camo.freetls.fastly.net/148046cdb7f958d764ef6c9f75df8f7dbe579c10/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f35653730376239323634396365383830346332623663643037323431623663643f73697a653d3530 "Avatar for pierrec from gravatar.com")
pierrec](/user/pierrec/)

### Unverified details

*These details have **not** been verified by PyPI*

###### Project links

* [Homepage](https://github.com/Ecogenomics/GTDBTk)

###### Meta

* **License:** GNU General Public License v3 (GPLv3) (GPL3)
* **Author:** Pierre-Alain Chaumeil, Aaron Mussig and Donovan Parks
* **Maintainer:** Pierre-Alain Chaumeil, Aaron Mussig and Donovan Parks
* **Requires:** Python >=3.6

###### Classifiers

* **Development Status**
  + [5 - Production/Stable](/search/?c=Development+Status+%3A%3A+5+-+Production%2FStable)
* **Intended Audience**
  + [Science/Research](/search/?c=Intended+Audience+%3A%3A+Science%2FResearch)
* **License**
  + [OSI Approved :: GNU General Public License v3 (GPLv3)](/search/?c=License+%3A%3A+OSI+Approved+%3A%3A+GNU+General+Public+License+v3+%28GPLv3%29)
* **Natural Language**
  + [English](/search/?c=Natural+Language+%3A%3A+English)
* **Programming Language**
  + [Python :: 3](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3)
  + [Python :: 3.6](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3.6)
  + [Python :: 3.7](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3.7)
  + [Python :: 3.8](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3.8)
* **Topic**
  + [Scientific/Engineering :: Bio-Informatics](/search/?c=Topic+%3A%3A+Scientific%2FEngineering+%3A%3A+Bio-Informatics)

[Report project as malware](https://pypi.org/project/gtdbtk/submit-malware-report/)

* [Project description](#description)
* [Project details](#data)
* [Release history](#history)
* [Download files](#files)

## Project description

# GTDB-Tk

[![PyPI](https://pypi-camo.freetls.fastly.net/5651a32c043e7a7aff0d8c2a10a5ef01615cb468/68747470733a2f2f696d672e736869656c64732e696f2f707970692f762f67746462746b2e737667)](https://pypi.python.org/pypi/gtdbtk)
[![PyPI Downloads](https://pypi-camo.freetls.fastly.net/07f9f479f13c79ff7fac770ac789e3e080b194d9/68747470733a2f2f706570792e746563682f62616467652f67746462746b)](https://pepy.tech/project/gtdbtk)
[![Bioconda](https://pypi-camo.freetls.fastly.net/159405c04c58decdc26e666e645691dec621e442/68747470733a2f2f696d672e736869656c64732e696f2f636f6e64612f766e2f62696f636f6e64612f67746462746b2e7376673f636f6c6f723d343362303261)](https://anaconda.org/bioconda/gtdbtk)
[![BioConda Downloads](https://pypi-camo.freetls.fastly.net/fe505684f8b838fae8ab8c21bd50878f1f96f241/68747470733a2f2f696d672e736869656c64732e696f2f636f6e64612f646e2f62696f636f6e64612f67746462746b2e7376673f7374796c653d666c6167266c6162656c3d646f776e6c6f61647326636f6c6f723d343362303261)](https://anaconda.org/bioconda/gtdbtk)
[![Docker Image Version (latest by date)](https://pypi-camo.freetls.fastly.net/6651fc9207603cfe21673566248d1478b11fd055/68747470733a2f2f696d672e736869656c64732e696f2f646f636b65722f762f65636f67656e6f6d69632f67746462746b3f736f72743d6461746526636f6c6f723d323939626563266c6162656c3d646f636b6572)](https://hub.docker.com/r/ecogenomic/gtdbtk)
[![Docker Pulls](https://pypi-camo.freetls.fastly.net/303d31d83421da0b9af8a5d03275571c0feacc2d/68747470733a2f2f696d672e736869656c64732e696f2f646f636b65722f70756c6c732f65636f67656e6f6d69632f67746462746b3f636f6c6f723d323939626563266c6162656c3d70756c6c73)](https://hub.docker.com/r/ecogenomic/gtdbtk)

**[GTDB-Tk v1.5.0](https://ecogenomics.github.io/GTDBTk/announcements.html) was released on April 23, 2021 along with new reference data for [GTDB R06-RS202](https://gtdb.ecogenomic.org/). Upgrading is recommended.**
 **Please note v1.5.0+ is not compatible with GTDB R05-RS95.**

GTDB-Tk is a software toolkit for assigning objective taxonomic classifications to bacterial and archaeal genomes based on the Genome Database Taxonomy [GTDB](https://gtdb.ecogenomic.org/). It is designed to work with recent advances that allow hundreds or thousands of metagenome-assembled genomes (MAGs) to be obtained directly from environmental samples. It can also be applied to isolate and single-cell genomes. The GTDB-Tk is open source and released under the [GNU General Public License (Version 3)](https://www.gnu.org/licenses/gpl-3.0.en.html).

Notifications about GTDB-Tk releases will be available through the GTDB Twitter account (<https://twitter.com/ace_gtdb>).

Please post questions and issues related to GTDB-Tk on the Issues section of the GitHub repository. Questions related to the [GTDB](https://gtdb.ecogenomic.org/) should be sent to the [GTDB team](https://gtdb.ecogenomic.org/about).

## Documentation

<https://ecogenomics.github.io/GTDBTk/>

## References

GTDB-Tk is described in:

* Chaumeil PA, et al. 2019. [GTDB-Tk: A toolkit to classify genomes with the Genome Taxonomy Database](https://academic.oup.com/bioinformatics/advance-article-abstract/doi/10.1093/bioinformatics/btz848/5626182). *Bioinformatics*, btz848.

The Genome Taxonomy Database (GTDB) is described in:

* Parks, D.H., et al. 2020. [A complete domain-to-species taxonomy for Bacteria and Archaea](https://rdcu.be/b3OI7). *Nature Biotechnology*, <https://doi.org/10.1038/s41587-020-0501-8>.
* Parks DH, et al. 2018. [A standardized bacterial taxonomy based on genome phylogeny substantially revises the tree of life](https://www.nature.com/articles/nbt.4229). *Nature Biotechnology*, <http://dx.doi.org/10.1038/nbt.4229>.

We strongly encourage you to cite the following 3rd party dependencies:

* Matsen FA, et al. 2010. [pplacer: linear time maximum-likelihood and Bayesian phylogenetic placement of sequences onto a fixed reference tree](https://www.ncbi.nlm.nih.gov/pubmed/21034504). *BMC Bioinformatics*, 11:538.
* Jain C, et al. 2019. [High-throughput ANI Analysis of 90K Prokaryotic Genomes Reveals Clear Species Boundaries](https://www.nature.com/articles/s41467-018-07641-9). *Nat. Communications*, doi: 10.1038/s41467-018-07641-9.
* Hyatt D, et al. 2010. [Prodigal: prokaryotic gene recognition and translation initiation site identification](https://www.ncbi.nlm.nih.gov/pubmed/20211023). *BMC Bioinformatics*, 11:119. doi: 10.1186/1471-2105-11-119.
* Price MN, et al. 2010. [FastTree 2 - Approximately Maximum-Likelihood Trees for Large Alignments](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2835736/). *PLoS One*, 5, e9490.
* Eddy SR. 2011. [Accelerated profile HMM searches](https://www.ncbi.nlm.nih.gov/pubmed/22039361). *PLOS Comp. Biol.*, 7:e1002195.
* Ondov BD, et al. 2016. [Mash: fast genome and metagenome distance estimation using MinHash](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-016-0997-x). *Genome Biol* 17, 132. doi: doi: 10.1186/s13059-016-0997-x.

## Copyright

Copyright 2017 Pierre-Alain Chaumeil. See LICENSE for further details.

## Project details

### Verified details

*These details have been [verified by PyPI](https://docs.pypi.org/project_metadata/#verified-details)*

###### Maintainers

[![Avatar for aaronmussig from gravatar.com](https://pypi-camo.freetls.fastly.net/2a318f8a94c402994c234fca4fb1f28fbfeee85e/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f37336361363666323638336432373536313930663466663337383361323930373f73697a653d3530 "Avatar for aaronmussig from gravatar.com")
aaronmussig](/user/aaronmussig/)

[![Avatar for dparks from gravatar.com](https://pypi-camo.freetls.fastly.net/360b9abd6bb94666813434d38144a31e9e1a0fe9/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f63623939633130616161633763323733383034343038613266386335666661653f73697a653d3530 "Avatar for dparks from gravatar.com")
dparks](/user/dparks/)

[![Avatar for pierrec from gravatar.com](https://pypi-camo.freetls.fastly.net/148046cdb7f958d764ef6c9f75df8f7dbe579c10/68747470733a2f2f7365637572652e67726176617461722e636f6d2f6176617461722f35653730376239323634396365383830346332623663643037323431623663643f73697a653d3530 "Avatar for pierrec from gravatar.com")
pierrec](/user/pierrec/)

### Unverified details

*These details have **not** been verified by PyPI*

###### Project links

* [Homepage](https://github.com/Ecogenomics/GTDBTk)

###### Meta

* **License:** GNU General Public License v3 (GPLv3) (GPL3)
* **Author:** Pierre-Alain Chaumeil, Aaron Mussig and Donovan Parks
* **Maintainer:** Pierre-Alain Chaumeil, Aaron Mussig and Donovan Parks
* **Requires:** Python >=3.6

###### Classifiers

* **Development Status**
  + [5 - Production/Stable](/search/?c=Development+Status+%3A%3A+5+-+Production%2FStable)
* **Intended Audience**
  + [Science/Research](/search/?c=Intended+Audience+%3A%3A+Science%2FResearch)
* **License**
  + [OSI Approved :: GNU General Public License v3 (GPLv3)](/search/?c=License+%3A%3A+OSI+Approved+%3A%3A+GNU+General+Public+License+v3+%28GPLv3%29)
* **Natural Language**
  + [English](/search/?c=Natural+Language+%3A%3A+English)
* **Programming Language**
  + [Python :: 3](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3)
  + [Python :: 3.6](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3.6)
  + [Python :: 3.7](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3.7)
  + [Python :: 3.8](/search/?c=Programming+Language+%3A%3A+Python+%3A%3A+3.8)
* **Topic**
  + [Scientific/Engineering :: Bio-Informatics](/search/?c=Topic+%3A%3A+Scientific%2FEngineering+%3A%3A+Bio-Informatics)

## Release history [Release notifications](/help/#project-release-notifications) | [RSS feed](/rss/project/gtdbtk/releases.xml)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.6.1

Dec 12, 2025](/project/gtdbtk/2.6.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.6.0

Dec 10, 2025](/project/gtdbtk/2.6.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.5.2

Sep 12, 2025](/project/gtdbtk/2.5.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.5.1

Sep 9, 2025](/project/gtdbtk/2.5.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.5.0

Sep 8, 2025](/project/gtdbtk/2.5.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.4.1

Apr 18, 2025](/project/gtdbtk/2.4.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.4.0

Apr 24, 2024](/project/gtdbtk/2.4.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.3.2

Jul 5, 2023](/project/gtdbtk/2.3.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.3.0

May 9, 2023](/project/gtdbtk/2.3.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.2.6

Mar 23, 2023](/project/gtdbtk/2.2.6/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.2.5

Mar 16, 2023](/project/gtdbtk/2.2.5/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.2.4

Feb 28, 2023](/project/gtdbtk/2.2.4/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.2.3

Feb 15, 2023](/project/gtdbtk/2.2.3/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.2.2

Feb 14, 2023](/project/gtdbtk/2.2.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.2.1

Feb 14, 2023](/project/gtdbtk/2.2.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.2.0

Feb 14, 2023](/project/gtdbtk/2.2.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.1.1

Jul 11, 2022](/project/gtdbtk/2.1.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.1.0

May 12, 2022](/project/gtdbtk/2.1.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[2.0.0

Apr 8, 2022](/project/gtdbtk/2.0.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.7.0

Oct 15, 2021](/project/gtdbtk/1.7.0/)

This version

![](https://pypi.org/static/images/blue-cube.572a5bfb.svg)

[1.6.0

Aug 20, 2021](/project/gtdbtk/1.6.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.5.1

Jun 24, 2021](/project/gtdbtk/1.5.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.5.0

Apr 26, 2021](/project/gtdbtk/1.5.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.4.1

Feb 3, 2021](/project/gtdbtk/1.4.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.4.0

Nov 30, 2020](/project/gtdbtk/1.4.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.3.0

Jul 18, 2020](/project/gtdbtk/1.3.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.2.0

May 29, 2020](/project/gtdbtk/1.2.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.1.1

Apr 22, 2020](/project/gtdbtk/1.1.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.1.0

Apr 14, 2020](/project/gtdbtk/1.1.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.0.2

Dec 12, 2019](/project/gtdbtk/1.0.2/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.0.1

Dec 5, 2019](/project/gtdbtk/1.0.1/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[1.0.0

Dec 5, 2019](/project/gtdbtk/1.0.0/)

![](https://pypi.org/static/images/white-cube.2351a86c.svg)

[0.3.3

Nov 15, 2019](/project/gtdbtk/0.3.3/)

![](https://pypi.or