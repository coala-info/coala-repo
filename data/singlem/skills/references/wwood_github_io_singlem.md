☰
[ ]

[![SingleM logo](/singlem/sandpiper.png)](/singlem/)

## [SingleM](/singlem/)

S

* [Lyrebird (phage profiling)](/singlem/Lyrebird)
* [Installation](/singlem/Installation)
* [Glossary](/singlem/Glossary)
* [FAQ](/singlem/FAQ)
* [Usage](/singlem/tools)

+ [SingleM data](/singlem/tools/data)
+ [SingleM pipe](/singlem/tools/pipe)
+ [SingleM summarise](/singlem/tools/summarise)
+ [SingleM renew](/singlem/tools/renew)
+ [SingleM supplement](/singlem/tools/supplement)
+ [SingleM prokaryotic\_fraction](/singlem/tools/prokaryotic_fraction)
+ [SingleM appraise](/singlem/tools/appraise)
+ [Lyrebird data](/singlem/tools/lyrebird_data)
+ [Lyrebird pipe](/singlem/tools/lyrebird_pipe)

* [Advanced modes](/singlem/advanced)

+ [SingleM query](/singlem/advanced/query)
+ [SingleM makedb](/singlem/advanced/makedb)
+ [SingleM condense](/singlem/advanced/condense)
+ [SingleM seqs](/singlem/advanced/seqs)
+ [SingleM create](/singlem/advanced/create)
+ [SingleM metapackage](/singlem/advanced/metapackage)
+ [SingleM regenerate](/singlem/advanced/regenerate)
+ [Lyrebird condense](/singlem/advanced/lyrebird_condense)
+ [Lyrebird renew](/singlem/advanced/lyrebird_renew)

[![Sandpiper logo](./sandpiper_small.png)](https://sandpiper.qut.edu.au)
[![Bin Chicken logo](./binchicken_small.png)](https://aroneys.github.io/binchicken)
[![Lyrebird logo](./lyrebird_small.png)](/singlem/Lyrebird)

[![Current Build](https://github.com/wwood/singlem/actions/workflows/test-singlem.yml/badge.svg)](https://github.com/wwood/singlem/actions)
[![Conda version](https://img.shields.io/conda/vn/bioconda/singlem?label=Conda&color=43b02a)](https://anaconda.org/bioconda/singlem)
[![Conda downloads](https://img.shields.io/conda/dn/bioconda/singlem?label=Downloads&color=43b02a)](https://anaconda.org/bioconda/singlem)
[![Docker version](https://img.shields.io/docker/v/wwood/singlem?label=Docker&color=1D63ED)](https://hub.docker.com/r/wwood/singlem/tags)
[![Docker pulls](https://img.shields.io/docker/pulls/wwood/singlem.svg?label=Pulls&color=1D63ED)](https://hub.docker.com/r/wwood/singlem)
[![PyPI version](https://img.shields.io/pypi/v/singlem.svg?label=PyPI&color=ffd43b)](https://pypi.org/project/singlem/)

Welcome.

At heart, SingleM is a tool for profiling shotgun (both short and long-read) metagenomes. It [shows](https://doi.org/10.1038/s41587-025-02738-1) good accuracy in estimating the relative abundances of community members, and has a particular strength in dealing with novel lineages.

It was originally designed to determine the relative abundance of bacterial and archaeal taxa in a sample. Microbial SingleM has been applied to ~700,000 public metagenomes. The resulting data are available at the [Sandpiper companion website](https://sandpiper.qut.edu.au).

Recent versions have added features:

* Long-read input support (v0.20.0). Either Nanopore >= R10.4.1 or PacBio HiFi reads are recommended to ensure reliable taxonomic profiling.
* Profiling of dsDNA phages (v0.19.0, updated DB in v0.20.0). See [Lyrebird](/singlem/Lyrebird).

The method it uses also it suitable for some related tasks, such as assessing eukaryotic contamination, finding bias in genome recovery, and lineage-targeted MAG recovery. It can also be used as the basis for choosing metagenomes which, when coassembled, maximise the recovery of novel MAGs (see [Bin Chicken](https://aroneys.github.io/binchicken/)).

The main idea of SingleM is to profile metagenomes by targeting short 20 amino acid stretches ("*windows*") within single copy marker genes. It finds reads which cover an entire window, and analyses these further. By constraining analysis to these short windows, it becomes possible to know how novel each read is compared to known genomes. Then, using the fact that each analysed gene is (almost always) found exactly once in each genome, the abundance of each lineage can be accurately estimated.

There are several tools (subcommands) which can be used after [installation](/singlem/Installation):

* [singlem pipe](/singlem/tools/pipe) - the main workflow which generates OTU tables and [GTDB](https://gtdb.ecogenomic.org/) taxonomic profiles.
* [single summarise](/singlem/tools/summarise) - Mechanical transformations of `singlem pipe` results.
* [singlem renew](/singlem/tools/renew) - Given previously generated results, re-run the pipeline with a new reference sequence/taxonomy database.
* [singlem supplement](/singlem/tools/supplement) - Add new genomes to a reference metapackage.
* [singlem prokaryotic\_fraction](/singlem/tools/prokaryotic_fraction) - How much of a metagenome is prokaryotic? (also available as `microbial_fraction`, the deprecated name)
* [singlem appraise](/singlem/tools/appraise) - How much of a metagenome do the genomes or assembly represent?

And more specialised / expert modes:

* [singlem condense](/singlem/advanced/condense) - Given an OTU table, summarise the results into a taxonomic profile.
* [singlem makedb](/singlem/advanced/makedb) & [query](/singlem/advanced/query)- Create a database of OTU sequences and query it using various sequence similarity methods e.g. [smafa](https://github.com/wwood/smafa).

## Help

If you have any questions or comments, raise a [GitHib issue](https://github.com/wwood/singlem/issues) or just send us an [email](https://research.qut.edu.au/cmr/team/ben-woodcroft/).

## How to use SingleM with AI assistants (Claude/ChatGPT/Gemini etc.)

There is a [SKILL.md](https://raw.githubusercontent.com/wwood/singlem/main/docs/SKILL.md) file that is designed to be used for teaching AI assistants about SingleM's usage.

## License

SingleM is developed by the [Woodcroft lab](https://research.qut.edu.au/cmr/team/ben-woodcroft/) at the [Centre for Microbiome Research](https://research.qut.edu.au/cmr), School of Biomedical Sciences, QUT, with contributions from many helpful people including [Samuel Aroney](https://github.com/AroneyS), [Rossen Zhao](https://github.com/rzhao-2), and [Raphael Eisenhofer](https://github.com/EisenRa). It is licensed under [GPL3 or later](https://gnu.org/licenses/gpl.html).

The source code is available at <https://github.com/wwood/singlem>.

## Citations

### Profiling microbial communities with SingleM / Sandpiper

Ben J. Woodcroft, Samuel T. N. Aroney, Rossen Zhao, Mitchell Cunningham, Joshua A. M. Mitchell, Rizky Nurdiansyah, Linda Blackall & Gene W. Tyson. *Comprehensive taxonomic identification of microbial species in metagenomic data using SingleM and Sandpiper.* Nat Biotechnol (2025). <https://doi.org/10.1038/s41587-025-02738-1>.

### SingleM prokaryotic\_fraction

Raphael Eisenhofer, Antton Alberdi, Ben J. Woodcroft, 2024. *Large-scale estimation of bacterial and archaeal DNA prevalence in metagenomes reveals biome-specific patterns.* bioRxiv, pp.2024-05; <https://doi.org/10.1101/2024.05.16.594470>.

### SingleM-powered coassembly with Bin Chicken

Samuel T. N. Aroney, Rhys J. Newell, Gene W. Tyson and Ben J. Woodcroft, 2024. *Bin Chicken: targeted metagenomic coassembly for the efficient recovery of novel genomes.* bioRxiv, pp.2024-11. <https://doi.org/10.1101/2024.11.24.625082>.

### Lyrebird

Rossen Zhao, Gene W. Tyson, Ben J. Woodcroft. *Lyrebird: a tool for profiling dsDNA phage communities in metagenomic data.* (in preparation).

On this page

* [Help](#help)
* [How to use SingleM with AI assistants (Claude/ChatGPT/Gemini etc.)](#how-to-use-singlem-with-ai-assistants-(claude/chatgpt/gemini-etc.))
* [License](#license)
* [Citations](#citations)
* [Profiling microbial communities with SingleM / Sandpiper](#profiling-microbial-communities-with-singlem-/-sandpiper)
* [SingleM prokaryotic\_fraction](#singlem-prokaryotic_fraction)
* [SingleM-powered coassembly with Bin Chicken](#singlem-powered-coassembly-with-bin-chicken)
* [Lyrebird](#lyrebird)

Powered by [Doctave](https://cli.doctave.com)