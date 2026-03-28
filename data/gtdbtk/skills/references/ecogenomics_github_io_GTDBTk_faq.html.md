[![Logo](_static/GTDBTk.svg)](index.html)

2.6.1

Getting started

* [Announcements](announcements.html)
* [Installing GTDB-Tk](installing/index.html)
* FAQ
  + [Taxonomy FAQ](#taxonomy-faq)
    - [Why is there a discrepancy in the naming system between GTDB-Tk and NCBI or Silva taxonomic names?](#why-is-there-a-discrepancy-in-the-naming-system-between-gtdb-tk-and-ncbi-or-silva-taxonomic-names)
    - [Why do I see discrepancies in classification for closely related genomes?](#why-do-i-see-discrepancies-in-classification-for-closely-related-genomes)
    - [Can you combine the bacterial and archaeal trees into a single tree?](#can-you-combine-the-bacterial-and-archaeal-trees-into-a-single-tree)
  + [GTDB-Tk FAQ](#gtdb-tk-faq)
    - [GTDB-Tk reaches the memory limit / pplacer crashes](#gtdb-tk-reaches-the-memory-limit-pplacer-crashes)
    - [How is GTDB-Tk validating species assignments using average nucleotide identity?](#how-is-gtdb-tk-validating-species-assignments-using-average-nucleotide-identity)
    - [What is the difference between the mutually exclusive options `--mash_db` and `--skip_ani_screen`?](#what-is-the-difference-between-the-mutually-exclusive-options-mash-db-and-skip-ani-screen)
  + [Deprecated FAQ](#deprecated-faq)
    - [Why is FastANI using more threads than allocated?](#why-is-fastani-using-more-threads-than-allocated)

Running GTDB-Tk

* [Performance and Accuracy](performance/index.html)
* [Commands](commands/index.html)
* [Files](files/index.html)
* [Example](examples/classify_wf.html)

About

* [Change log](changelog.html)
* [References](references.html)

[GTDB-Tk](index.html)

* »
* FAQ
* [Edit on GitHub](https://github.com/Ecogenomics/GTDBTk/blob/master/docs/src/faq.rst)

---

# FAQ[¶](#faq "Permalink to this headline")

## Taxonomy FAQ[¶](#taxonomy-faq "Permalink to this headline")

### Why is there a discrepancy in the naming system between GTDB-Tk and NCBI or Silva taxonomic names?[¶](#why-is-there-a-discrepancy-in-the-naming-system-between-gtdb-tk-and-ncbi-or-silva-taxonomic-names "Permalink to this headline")

GTDB-Tk uses the GTDB taxonomy (<https://gtdb.ecogenomic.org/>).
This taxonomy is similar, but not identical to NCBI and Silva.
In many cases the GTDB taxonomy more strictly follows the nomenclatural rules for rank suffixes which is why there is Nitrospirota instead of Nitrospirae.

### Why do I see discrepancies in classification for closely related genomes?[¶](#why-do-i-see-discrepancies-in-classification-for-closely-related-genomes "Permalink to this headline")

Discrepancies in taxonomic assignments can occur when working with closely related genomes. GTDB-Tk uses both the **Relative Evolutionary Divergence (RED)** value and the **placement of the genome in the reference tree** to determine the best taxonomic classification.
In most cases taxonomic assignments are robust, but it is possible for highly similar genomes to have sufficiently different protein sequences that their placements in the reference tree will vary slightly. This can lead to:

1. placement on different but closely related branches, or
2. placement on the same branch but at different depths.

This uncertainty in the placement of even closely related genomes can result in genomes being erroneously assigned to different taxa (e.g. closely related sister families).

**What should I do?**

If you run into this situation, here are a few strategies you can use:

1. Dereplicate your genomes.
   :   If you have a cluster of closely related genomes representing a single species, consider dereplicating them to pick a single representative based on genome quality metrics (for example, using a tool like [dRep](https://drep.readthedocs.io/en/latest/index.html) or [Galah](https://github.com/wwood/galah)). The taxonomic assignment for this species representative genomes can then be propagated to the other genomes in the cluster.
2. Build a de novo tree
   :   Another option is to construct a de novo tree including your closely related genomes plus a suitable outgroup. For instance, if you have three genomes classified as:

       * *c\_\_Atribacteria;o\_\_Atribacterales;f\_\_Atribacteraceae*
       * *c\_\_Atribacteria;o\_\_Atribacterales;f\_\_Thermatribacteraceae*
       * *c\_\_Atribacteria;o\_\_Atribacterales;f\_\_*

you could generate a tree for the class Atribacteria (with one outgroup class) and examine whether your genomes cluster together despite their different family-level assignments.

### Can you combine the bacterial and archaeal trees into a single tree?[¶](#can-you-combine-the-bacterial-and-archaeal-trees-into-a-single-tree "Permalink to this headline")

The bacterial and archaeal trees are inferred from different marker genes. Currently, the correct rootings of these trees remain an open area of research.
GTDB-Tk does not provide a tool to merge the trees but It is possible to artificially combine them by manipulating the Newick files.
One solution would be to use ([DendroPy](https://dendropy.org/)); a Python library used for phylogenetic computing.

## GTDB-Tk FAQ[¶](#gtdb-tk-faq "Permalink to this headline")

### GTDB-Tk reaches the memory limit / pplacer crashes[¶](#gtdb-tk-reaches-the-memory-limit-pplacer-crashes "Permalink to this headline")

The host may report that GTDB-Tk has exceeded the memory requirements due to how `pplacer` is implemented.
Briefly, this is only the reported value and is not true for how much memory is actually in use.

When pplacer runs, it goes through several steps notable detailed below:

1. pplacer requests an uninitialised chunk of memory from the host (say, 150 GB).

   * VIRT = 150 GB `[virtual memory memory, i.e. the amount of memory mapped]`
   * RES ~= 0 GB `[amount of memory physically in use]`
2. pplacer starts caching information to that chunk of memory

   * VIRT = 150 GB
   * RES -> 150 GB (slowly increases to 150 GB as caching information is written)

   Note

   If pplacer crashes here, you likely don’t have enough free memory on the server.
3. pplacer starts placing genomes into the tree

   1. the main pplacer thread forks for each `--pplacer_cpus` or `--cpus` (if not specified).

      * Unix uses the [copy-on-write](https://en.wikipedia.org/wiki/Copy-on-write) method for each child.

      Note

      This means that a new thread will appear using the same amount of memory as the parent (150 GB).
      Due to how copy-on-write is implemented, this is the same memory space and is not using any additional physical memory.

      Therefore, the host will report pplacer using a total of `PARENT_MEMORY * (N_CHILDREN + 1)` GB.
   2. each worker will only read from the memory space and exit once the queue of query genomes is depleted.

For example, running GTDB-Tk with on the bacterial tree (requires 150 GB of memory) with 1 CPU will require 150 GB of physical
memory, but the host will report 300 GB of memory in use.

Using the `--scratch_dir` parameter and `--pplacer_cpus 1` may help.

### How is GTDB-Tk validating species assignments using average nucleotide identity?[¶](#how-is-gtdb-tk-validating-species-assignments-using-average-nucleotide-identity "Permalink to this headline")

GTDB-Tk uses [skani](https://github.com/bluenote-1577/skani) ( it was using fastANI until v2.3.2) to estimate the ANI between genomes.
A query genome is only classified as belonging to the same species as a reference genome if the ANI between the
genomes is within the species ANI circumscription radius (typically, 95%) and the alignment fraction (AF) is >=0.5.
In some circumstances, the phylogenetic placement of a query genome may not support the species assignment.
GTDB r207+ strictly uses ANI to circumscribe species and GTDB-Tk follows this methodology.
The species-specific ANI circumscription radii are available from the [GTDB](https://gtdb.ecogenomic.org/) website.

### What is the difference between the mutually exclusive options `--mash_db` and `--skip_ani_screen`?[¶](#what-is-the-difference-between-the-mutually-exclusive-options-mash-db-and-skip-ani-screen "Permalink to this headline")

Starting with GTDB-Tk v2.2+, the `classify_wf` and `classify` function require an extra parameter to run: `--mash_db` or `--skip_ani_screen`.

With this new version of Tk, The first stage of `classify` pipelines (`classify_wf` and `classify`) is to compare all user genomes to all reference genomes and annotate them, if possible, based on ANI matches.

Using the `--mash_db` option will indicate to GTDB-Tk the path of the sketched Mash database require for ANI screening.

If no database are available ( i.e. this is the first time running classify ), the `--mash_db` option will sketch a new Mash database that can be used for subsequent calls.

The `--skip_ani_screen` option will skip the pre-screening step and classify all genomes similar to previous versions of GTDB-Tk.

## Deprecated FAQ[¶](#deprecated-faq "Permalink to this headline")

### Why is FastANI using more threads than allocated?[¶](#why-is-fastani-using-more-threads-than-allocated "Permalink to this headline")

If you are using FastANI version 1.33 then you may run into an issue where FastANI will use more threads than you allocate.
This can be problematic if running GTDB-Tk on a HPC where you have a limited number of threads available.

This issue has been [reported to the FastANI developers (#101)](https://github.com/ParBLiSS/FastANI/issues/101).

Depending on how you installed GTDB-Tk there are different ways to downgrade FastANI to version 1.32.

**Manual:**

Simplify download and install the FastANI binary from [here](https://github.com/ParBLiSS/FastANI/releases/tag/v1.32).

**Conda:**

From GTDB-Tk v2.0.0 the conda environment will automatically have FastANI v1.3 installed. Otherwise run:

`conda install -c bioconda fastani==1.32`

**Docker:**

From GTDB-Tk v2.2.2 the Docker container will automatically have FastANI v1.32 installed. Otherwise, manually
build the container from the [Dockerfile](https://github.com/Ecogenomics/GTDBTk/blob/master/Dockerfile), making
sure to specify FastANI v1.32.

[Next](performance/index.html "Performance and Accuracy")
 [Previous](installing/docker.html "Docker")

---

© Copyright 2025, Pierre-Alain Chaumeil, Aaron Mussig and Donovan Parks.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).