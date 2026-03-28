[![Logo](_static/GTDBTk.svg)](index.html)

2.6.1

Getting started

* [Announcements](announcements.html)
* [Installing GTDB-Tk](installing/index.html)
* [FAQ](faq.html)

Running GTDB-Tk

* [Performance and Accuracy](performance/index.html)
* [Commands](commands/index.html)
* [Files](files/index.html)
* [Example](examples/classify_wf.html)

About

* Change log
  + [2.6.1](#id1)
    - [2.6.0](#id3)
    - [2.5.2](#id11)
    - [2.5.1](#id14)
    - [2.5.0](#id16)
    - [2.4.1](#id20)
    - [2.4.0](#id22)
    - [2.3.2](#id27)
    - [2.3.0](#id31)
    - [2.2.6](#id38)
    - [2.2.5](#id40)
    - [2.2.5](#id42)
    - [2.2.4](#id44)
    - [2.2.3](#id46)
    - [2.2.2](#id47)
    - [2.2.1](#id49)
    - [2.2.0](#id51)
    - [2.1.1](#id61)
    - [2.1.0](#id65)
    - [2.0.0](#id69)
    - [1.7.0](#id76)
    - [1.6.0](#id81)
    - [1.5.1](#id84)
    - [1.5.0](#id87)
    - [1.4.2](#id89)
    - [1.4.1](#id92)
    - [1.4.0](#id95)
    - [1.3.0](#id102)
    - [1.2.0](#id103)
    - [1.1.0](#id111)
    - [1.0.2](#id120)
    - [1.0.0](#id121)
    - [0.3.3](#id122)
    - [0.3.2](#id123)
    - [0.3.1](#id124)
    - [0.3.0](#id125)
    - [0.2.1](#id126)
    - [0.1.3](#id127)
    - [0.1.0](#id128)
* [References](references.html)

[GTDB-Tk](index.html)

* »
* Change log
* [Edit on GitHub](https://github.com/Ecogenomics/GTDBTk/blob/master/docs/src/changelog.rst)

---

# Change log[¶](#change-log "Permalink to this headline")

## 2.6.1[¶](#id1 "Permalink to this headline")

Bug Fixes:

* ([#680](https://github.com/Ecogenomics/GTDBTk/issues/680)) This release resolves the check\_install error that reports `Path not set for StageLogger`

### 2.6.0[¶](#id3 "Permalink to this headline")

Major Changes:

* GTDB-Tk has now a fixed version for skani (v0.3.1) and pplacer (v1.1.alpha19) to i) ensure reproducibility of results and ii) use the sketch format compatible with skani v0.3.1.
* The limit of number of genomes compared in dense genera has been removed.This ensures that all representative genomes in a genus are compared, preventing incorrect species assignments when the closest genome by ANI is outside the previous 100-genome limit. This is especially important in dense genera like Collinsella and significantly improves classification accuracy, even if runtime increases slightly.

Bug Fixes:

* ([#670](https://github.com/Ecogenomics/GTDBTk/issues/670)), ([#674](https://github.com/Ecogenomics/GTDBTk/issues/674)),([#668](https://github.com/Ecogenomics/GTDBTk/issues/668)) Fixed an issue where GTDB-Tk would crash when using pplacer v1.1.alpha20. This issue is now resolved by fixing pplacer to v1.1.alpha19.
* ([#671](https://github.com/Ecogenomics/GTDBTk/issues/671)) The limit of number of genomes compared in dense genera has been removed.
* ([#672](https://github.com/Ecogenomics/GTDBTk/issues/672)) skani is now fixed to v0.3.1 to and uses sketch + search commands instead of dist.
* ([#665](https://github.com/Ecogenomics/GTDBTk/issues/665)) GTDB-Tk now uses skani v0.3.1 and have a option to save the sketch db for reference genomes for future use( –skani\_sketch\_dir ).
* ([#669](https://github.com/Ecogenomics/GTDBTk/issues/669)) BaseModel from pydantic is now replaces by DataClass to avoid warnings with pydantic v2.x.

### 2.5.2[¶](#id11 "Permalink to this headline")

Bug Fixes:

* This release resolves the ani\_screen error that reports `TypeError: bool() undefined when iterable == total == None`. ([#663](https://github.com/Ecogenomics/GTDBTk/issues/663)) ([#662](https://github.com/Ecogenomics/GTDBTk/issues/662))

### 2.5.1[¶](#id14 "Permalink to this headline")

Bug Fixes:
\* ([#658](https://github.com/Ecogenomics/GTDBTk/issues/658)) Implement progress bar for comparison process.

### 2.5.0[¶](#id16 "Permalink to this headline")

Major Changes:
\* GTDB-Tk now uses **Skani exclusively** for genome clustering, replacing the previous Mash/Skani hybrid approach. This change simplifies the CLI and removes the dependency on Mash, streamlining installation and execution.

Bug Fixes:
\* ([#644](https://github.com/Ecogenomics/GTDBTk/issues/644)), ([#641](https://github.com/Ecogenomics/GTDBTk/issues/641)) Fixed compatibility with recent versions of NumPy (≥1.24), which removed the `tostring()` method from `numpy.ndarray`.
\* ([#650](https://github.com/Ecogenomics/GTDBTk/issues/650)) Update CLI with an up-to-date taxon.

### 2.4.1[¶](#id20 "Permalink to this headline")

Bug Fixes:
\* ([#630](https://github.com/Ecogenomics/GTDBTk/issues/630)) Fixed SyntaxWarning in Python 3.12 by using raw strings for regex in HMMResultsIO.py

### 2.4.0[¶](#id22 "Permalink to this headline")

Bug Fixes:

* ([#576](https://github.com/Ecogenomics/GTDBTk/issues/576)) When all genomes fail the prodigal step in the classify\_wf, The

bac120 summary file is still produced with the all failed genomes listed as ‘Unclassified’
\* ([#573](https://github.com/Ecogenomics/GTDBTk/issues/573)) When running the 3 classify steps independently, a genome can be filtered out in the align
step but still be classified in the identify step. To avoid duplication of row, the genome is classified with a warning.
\* ([#540](https://github.com/Ecogenomics/GTDBTk/issues/540)) Empty files are skipped during the sketch step of Mash,
they are then catch in the prodigal step and are returned as ‘Unclassified’
\* ([#549](https://github.com/Ecogenomics/GTDBTk/issues/549)) : –force has been modified to deal with #540. Prodigal
wasn’t returning the empty files as failed genomes, it was only skipping them. These genomes are now returned in the summary file and flagged as Unclassified.

Major Changes:

* FastANI has been replaced by skani as the primary tool for computing Average Nucleotide Identity (ANI).Users may notice slight variations in the results compared to those obtained using FastANI.
* In the generated summary.tsv files, several columns have been renamed for clarity and consistency. The following columns have been affected:

  > + “fastani\_reference” column has been renamed to “closest\_genome\_reference”.
  > + “fastani\_reference\_radius” column has been renamed to “closest\_genome\_reference\_radius”.
  > + “fastani\_taxonomy” column has been renamed to “closest\_genome\_taxonomy”.
  > + “fastani\_ani” column has been renamed to “closest\_genome\_ani”.
  > + “fastani\_af” column has been renamed to “closest\_genome\_af”.

> These changes have been implemented to improve the readability and understanding of the data within the summary.tsv files. Users should update their scripts or processes accordingly to reflect these renamed column headers.

### 2.3.2[¶](#id27 "Permalink to this headline")

Bug Fixes:

* ([#528](https://github.com/Ecogenomics/GTDBTk/issues/528)) ([#529](https://github.com/Ecogenomics/GTDBTk/issues/529)) setup.py has been modified to restrict pydantic version to >=1.9.2 and < 2.0a1

Minor Changes:

* ([#526](https://github.com/Ecogenomics/GTDBTk/issues/526)) change captures the Mash stderr in a separate buffer ( Thanks @wasade for your contribution)

### 2.3.0[¶](#id31 "Permalink to this headline")

Bug Fixes:

* ([#508](https://github.com/Ecogenomics/GTDBTk/issues/508)) ([#509](https://github.com/Ecogenomics/GTDBTk/issues/509)) If **ALL** genomes for a specific domain are either filtered out or classified with ANI they are now reported in the summary file.

Minor changes:

* ([#491](https://github.com/Ecogenomics/GTDBTk/issues/491)) ([#498](https://github.com/Ecogenomics/GTDBTk/issues/498)) Allow GTDB-Tk to show `--help` and `-v` without `GTDBTK_DATA_PATH` being set.
  \* WARNING: This is a breaking change if you are importing GTDB-Tk as a library and importing values from `gtdbtk.config.config`, instead you need to import as `from gtdbtk.config.common import CONFIG` then access values via `CONFIG.<var>`
* ([#508](https://github.com/Ecogenomics/GTDBTk/issues/508)) Mash distance is changed from 0.1 to 0.15 . This is will increase the number of FastANI comparisons but will cover cases wheere genomes have a larger Mash distance but a small ANI.
* ([#497](https://github.com/Ecogenomics/GTDBTk/issues/497)) Add a `convert_to_species` function is GTDB-Tk to replace GCA/GCF ids with their GTDB species name
* Add `--db_version` flag to `check_install` to check the version of previous GTDB-Tk packages.

### 2.2.6[¶](#id38 "Permalink to this headline")

Bug Fixes:

* ([#493](https://github.com/Ecogenomics/GTDBTk/issues/493)) Fix issue with –full-tree flag (related to skipping ANI steps)

Minor changes:

* Change URL for documentation to ‘<https://ecogenomics.github.io/GTDBTk/installing/index.html>’
* Improve portability of the ANI\_screen step by regenerating the paths of reference genomes in the current filesystem for mash\_db.msh

### 2.2.5[¶](#id40 "Permalink to this headline")

Bug Fixes:

* gtdbtk.json is now reset when the pipeline is re run and the status of ani\_Screen is not ‘complete’

Minor changes:

* When using ‘–genes’ , ANI steps are skipped and Warnings are raised to the user to
  :   inform them that classification is less accurate.
* ([#486](https://github.com/Ecogenomics/GTDBTk/issues/486)) Environment variables can be used in GTDBTK\_DATA\_PATH
* ‘is\_consistent’ function in ‘mash.py’ compares only the filenames, not the full paths
* Add cutoff arguments to PfamScan ( Thanks @AroneyS for the contribution)

### 2.2.5[¶](#id42 "Permalink to this headline")

Bug Fixes:

* gtdbtk.json is now reset when the pipeline is re run and the status of ani\_Screen is not ‘complete’

Minor changes:

* When using ‘–genes’ , ANI steps are skipped and Warnings are raised to the user to inform them that classification is less accurate.
* ([#486](https://github.com/Ecogenomics/GTDBTk/issues/486)) Environment variables can be used in GTDBTK\_DATA\_PATH
* ‘is\_consistent’ function in ‘mash.py’ compares only the filenames, not the full paths
* Add cutoff arguments to PfamScan ( Thanks @AroneyS for the contribution)

### 2.2.4[¶](#id44 "Permalink to this headline")

Bug Fixes:

* ([#475](https://github.com/Ecogenomics/GTDBTk/issues/475)) If all genomes are classified using ANI, Tk will skip the identify step and align steps

Minor changes:

* Add hidden ‘–skip\_pplacer’ flag to skip pplacer step ( useful for debugging)
* Improve documentation
* Convert stage\_logger to a Singleton class
* Use existing ANI results if available

### 2.2.3[¶](#id46 "Permalink to this headline")

Bug Fixes:

* Fix prodigal\_fail\_counter issue

### 2.2.2[¶](#id47 "Permalink to this headline")

Bug Fixes:

* ([#471](https://github.com/Ecogenomics/GTDBTk/issues/471)) Fix Pplacer issue

### 2.2.1[¶](#id49 "Permalink to this headline")

Build:

* ([#470](https://github.com/Ecogenomics/GTDBTk/issues/470)) Add missing Pydantic dependency.

### 2.2.0[¶](#id51 "Permalink to this headline")

Minor changes:

* ([#433](https://github.com/Ecogenomics/GTDBTk/issues/433)) Added additional checks to ensure that the –outgroup\_taxon cannot be set to a domain (root, de\_novo\_wf).
* ([#459](https://github.com/Ecogenomics/GTDBTk/issues/459) / [#462](https://github.com/Ecogenomics/GTDBTk/issues/462) ) Fix deprecated np.bool in prodigal\_biolib.py. Special thanks to @neoformit for his contribution.
* ([#466](http://github.com/Ecogenomics/GTDBTk/issues/466)) RED value has been rounded to 5 decimals after the comma.
* ([#451](http://github.com/Ecogenomics/GTDBTk/issues/451)) Extra checks have been added when Prodigal fails.
* ([#448](http://github.com/Ecogenomics/GTDBTk/issues/448)) Warning has been added when all the genomes are filtered out and not classified.

Bug Fixes:

* ([#420](https://github.com/Ecogenomics/GTDBTk/issues/420)) Fixed an issue where GTDB-Tk might hang when classifying TIGRFAM markers (identify, classify\_wf, de\_novo\_wf). Special thanks to @lfenske-93 and @sjaenick for their contribution.
* ([#428](https://github.com/Ecogenomics/GTDBTk/issues/428)) Fixed an issue where the –gtdbtk\_classification\_file would raise an error trying to read the classify summary (root, de\_novo\_wf).
* ([#439](https://github.com/Ecogenomics/GTDBTk/issues/439)) Fix the pipeline when using protein files instead of nucleotide files. symlink uses absolute path instead.

### 2.1.1[¶](#id61 "Permalink to this headline")

Documentation:

* ([#410](https://github.com/Ecogenomics/GTDBTk/issues/410)) Add documentation for convert\_to\_itol

Bug Fixes:

* ([#399](https://github.com/Ecogenomics/GTDBTk/issues/399)) Fix –genes option attempting to create a directory.
* ([#400](https://github.com/Ecogenomics/GTDBTk/issues/400)) Updated contig.py to fix inconsistent pplacer paths causing the program to crash.

### 2.1.0[¶](#id65 "Permalink to this headline")

Major changes:

* GTDB-TK now uses a **divide-and-conquer** approach where the bacterial reference tree is split into multiple **class**-level subtrees. This reduces the memory requirements of GTDB-Tk from **320 GB** of RAM when using the full GTDB R07-RS207 reference tree to approximately **55 GB**. A manuscript describing this approach is in preparation. If you wish to continue using the full GTDB reference tree use the –full-tree flag. This is the main change from v2.0.0. The split tree approach has been modified from order-level trees to class-level trees to resolve specific classification issues (see [#383](https://github.com/Ecogenomics/GTDBTk/issues/383)).
* Genomes that cannot be assigned to a domain (e.g. genomes with no bacterial or archaeal markers or genomes with no genes called by Prodigal) are now reported in the gtdbtk.bac120.summary.tsv as ‘Unclassified’
* Genomes filtered out during the alignment step are now reported in the gtdbtk.bac120.summary.tsv or gtdbtk.ar53.summary.tsv as ‘Unclassified Bacteria/Archaea’
* –write\_single\_copy\_genes flag in now available in the classify\_wf and de\_novo\_wf workflows.

Features:

* ([#392](https://github.com/Ecogenomics/GTDBTk/issues/392)) –write\_single\_copy\_genes flag available in workflows.
* ([#387](https://github.com/Ecogenomics/GTDBTk/issues/392)) specific memory requirements set in classify\_wf depending on the classification approach.

### 2.0.0[¶](#id69 "Permalink to this headline")

Major changes:

* GTDB-TK now uses a **divide-and-conquer** approach where the bacterial reference tree is split into multiple order-level subtrees. This reduces the memory requirements of GTDB-Tk from **320 GB** of RAM when using the full GTDB R07-RS207 reference tree to approximately **35 GB**. A manuscript describing this approach is in preparation. If you wish to continue using the full GTDB reference tree use the –full-tree flag.
* Archaeal classification now uses a refined set of 53 archaeal-specific marker genes based on the recent publication by [Dombrowski et al., 2020](https://www.nature.com/articles/s41467-020-17408-w). This set of archaeal marker genes is now used by GTDB for curating the archaeal taxonomy.
* By default, all directories containing intermediate results are **now removed** by default at the end of the classify\_wf and d