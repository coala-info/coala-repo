[panGWAS](./index.html)

* [Home](./index.html)
* [Tutorials](./tutorials/tutorials.html)
* [Manual](./manual/table_of_contents.html)
* [Pipeline](./pipeline/pipeline.html)
* [Code Coverage](./coverage/index.html)
* [Developers](./developers/developers.html)

## On this page

* [panGWAS](#pangwas)
  + [Table of Contents](#table-of-contents)
  + [Why panGWAS?](#why-pangwas)
  + [Method](#method)
  + [Install](#install)
    - [Conda](#conda)
    - [Docker](#docker)
    - [Nextflow](#nextflow)
    - [Source](#source)
  + [Usage](#usage)
    - [CLI](#cli)
    - [Python](#python)
    - [Nextflow](#nextflow-1)
  + [Output](#output)
  + [Credits](#credits)
    - [Contributors](#contributors)
  + [License](#license)

# panGWAS

[![All Contributors](https://img.shields.io/badge/all_contributors-17-orange.svg?style=flat-square)](#credits) [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://github.com/phac-nml/pangwas/blob/master/LICENSE) [![GitHub issues](https://img.shields.io/github/issues/phac-nml/pangwas.svg)](https://github.com/phac-nml/pangwas/issues) [![Tests](https://github.com/phac-nml/pangwas/actions/workflows/test.yaml/badge.svg)](https://github.com/phac-nml/pangwas/actions/workflows/test.yaml)

**panGWAS** is a pipeline for pangenome wide association studies. It reconstructs a pangenome from genomic assemblies, performs annotation and variant calling, estimates population structure, and models the association between genomic variants and variables of interest.

![](docs/images/pipeline.png)

**panGWAS** is implemented as a `python` package and CLI tool, that can be run on any POSIX-based system (Linux, Mac). We additionally provide a `nextflow` pipeline for end-to-end analysis.

Please see the extended documentation at: <https://phac-nml.github.io/pangwas/>

## Table of Contents

1. [Why panGWAS?](#why-pangwas)
2. [Method](#method)
3. [Install](#install)
4. [Usage](#usage)
5. [Output](#output)
6. [Credits](#credits)

## Why panGWAS?

**panGWAS** is distinct from other pangenome/GWAS workflows because it:

1. Provides end-to-end analysis, from genomic assemblies to GWAS results.
2. Includes both coding and non-coding sequences in the pangenome.
3. Ensures reproducible, deterministic results.
4. Offers both sensible defaults and extensive customization of underlying tools.
5. Keeps variants tightly linked to their annotations for easier interpretation at each stage.

## Method

**panGWAS** performs the following analyses:

1. **Annotate**: Standardized annotation of genomes\* with [`bakta`](https://github.com/oschwengers/bakta).
2. **Cluster**: Identify genomic regions with shared homology using [`MMseqs2`](https://github.com/soedinglab/mmseqs2).
3. **Align**: Concatenate and align clusters with [`mafft`](https://mafft.cbrc.jp/).
4. **Variants**: SNPs, presence absence, and structural variants.
5. **Tree**: Estimate a maximum-likelihood tree with [`IQ-TREE`](http://www.iqtree.org/).
6. **GWAS**: Model the association between variants and traits with [`pyseer`](https://pyseer.readthedocs.io/en/master/index.html).
7. **Plot**: Manhattan plots, tree visualizations, heatmaps of signficant variants, QQ plots.

\* For non-bacterial genomes, you will need to bring your own `gff` annotations.

## Install

### Conda

> ❗ Pending release of the [bioconda recipe](https://github.com/bioconda/bioconda-recipes/pull/54760).

```
conda create -n pangwas -c conda-forge -c bioconda pangwas
```

### Docker

> ❗ Pending release of the [bioconda recipe](https://github.com/bioconda/bioconda-recipes/pull/54760).

```
docker pull quay.io/biocontainers/pangwas:latest
```

### Nextflow

```
nextflow pull phac-nml/pangwas
```

### Source

Install `pangwas` from the github repository:

```
micromamba env create -f environment.yml -n pangwas
micromamba activate pangwas
pip install .
```

Build the `Docker` image from the github repository:

```
docker build -t phac-nml/pangwas:latest .
```

## Usage

> For more information, please see the [Manual](https://phac-nml.github.io/pangwas/manual/table_of_contents.html) and [Pipeline Documentation](https://phac-nml.github.io/pangwas/pipeline/pipeline.html).

### CLI

Individual commands can be run via the command-line interface:

```
pangwas extract --gff sample1.gff3
pangwas extract --gff sample2.gff3
pangwas collect --tsv sample1.tsv sample2.tsv
pangwas cluster --fasta sequences.fasta
...
```

For an end-to-end example using the CLI, please see the [Command-Line Interface](https://phac-nml.github.io/pangwas/pipeline/pipeline.html#command-line-interface) example.

### Python

Individual commands can be run as `python` functions:

```
import pangwas

pangwas.extract(gff="sample1.gff3")
pangwas.extract(gff="sample2.gff3")
pangwas.collect(tsv=["sample1.tsv", "sample2.tsv"])
pangwas.cluster(fasta="sequences.fasta")
...
```

For an end-to-end example using python, please see the [Python Package](https://phac-nml.github.io/pangwas/pipeline/pipeline.html#python-package) example.

### Nextflow

An end-to-end pipeline is provided via `nextflow`:

```
nextflow run phac-nml/pangwas -profile test
```

For more examples, please see the [tutorials](https://phac-nml.github.io/pangwas/tutorials/tutorials.html). We recommend the [Pyseer tutorial](https://phac-nml.github.io/pangwas/tutorials/03_pyseer_tutorial.html), which automates and reproduces the results from the [penicillin resistance GWAS](https://pyseer.readthedocs.io/en/master/tutorial.html) created by the `pyseer` authors:

![](docs/images/core_vs_pangenome.png)

## Output

1. **Plots**: PNG and SVG files under the `manhattan` and `heatmap` directories.

   > ❗**Tip**: Open the SVG in Edge or Firefox, to get hovertext!

   | Manhattan | Heatmap | QQ Plot |
   | --- | --- | --- |
   | ![manhattan](docs/images/core_manhattan_hovertext.png) | ![heatmap](docs/images/heatmap_hovertext.png) | ![](docs/images/penicillin.qq_plot.png) |
2. **GWAS Tables**: Statistic results per variant.

   | variant | af | filter-pvalue | lrt-pvalue | beta | beta-std-err | variant\_h2 | notes | -log10(p) | bonferroni | … |
   | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
   | pbpX|snp:G761A | 3.78E-01 | 6.12E-94 | 3.01E-25 | 7.42E-01 | 6.82E-02 | 4.05E-01 |  | 24.521433504406158 | 1.180414561594032e-06 | … |
   | pbpX|snp:T1077C | 3.85E-01 | 1.11E-95 | 1.43E-24 | 7.23E-01 | 6.76E-02 | 4.00E-01 |  | 23.844663962534938 | 1.180414561594032e-06 | … |
3. **Trees**: We recommend [Arborview](https://phac-nml.github.io/ArborView/html/table.html) for interactive visualization of the newick files!

   ![](docs/images/arborview_tree.png)

   arborview
4. **Pangenome**: We recommend [Bandage](https://github.com/rrwick/Bandage) for interactive visualization of the pangenome graph!

   * [GFA](https://github.com/GFA-spec/GFA-spec) files can be found under `summarize` for both the full and linearized version of the pangenome.

   ![](docs/images/pangenome_bandage.png)

And much more!

## Credits

[panGWAS](https://github.com/phac-nml/pangwas) is built and maintained by [Katherine Eaton](https://ktmeaton.github.io/) at the [National Microbiology Laboratory (NML)](https://github.com/phac-nml) of the Public Health Agency of Canada (PHAC).

If you have any questions, please email ktmeaton@gmail.com.

|  |
| --- |
| [![](https://s.gravatar.com/avatar/0b9dc28b3e64b59f5ce01e809d214a4e?s=80) **Katherine Eaton**](https://ktmeaton.github.io) [💻](https://github.com/phac-nml/pangwas/commits?author=ktmeaton "Code") [📖](https://github.com/phac-nml/pangwas/commits?author=ktmeaton "Documentation") [🎨](#design-ktmeaton "Design") [🤔](#ideas-ktmeaton "Ideas, Planning, & Feedback") [🚇](#infra-ktmeaton "Infrastructure (Hosting, Build-Tools, etc)") [🚧](#maintenance-ktmeaton "Maintenance") |

### Contributors

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification ([emoji key](https://allcontributors.org/docs/en/emoji-key)). Contributions of any kind welcome!

Special thanks go to the developers of [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN). The **Cluster** and **Align** steps are heavily inspired by [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN), and in fact, **panGWAS** uses a modified version of PPanGGOLiN’s defragmentation algorithm.

|  |  |  |  |
| --- | --- | --- | --- |
| [![](https://avatars.githubusercontent.com/u/17834092?v=4&s=100)   **Guillaume Gautreau**](https://github.com/ggautreau)    [🎨](https://github.com/labgem/PPanGGOLiN "Design: PPanGGOLiN") [🤔](https://github.com/labgem/PPanGGOLiN "Ideas: PPanGGOLiN") | [![](https://avatars.githubusercontent.com/u/28706177?v=4&s=100)   **Jean Mainguy**](https://github.com/JeanMainguy)    [🎨](https://github.com/labgem/PPanGGOLiN "Design: PPanGGOLiN") [🤔](https://github.com/labgem/PPanGGOLiN "Ideas: PPanGGOLiN") | [![](https://avatars.githubusercontent.com/u/39793176?v=4&s=100)   **Jérôme Arnoux**](https://github.com/jpjarnoux)    [🎨](https://github.com/labgem/PPanGGOLiN "Design: PPanGGOLiN") [🤔](https://github.com/labgem/PPanGGOLiN "Ideas: PPanGGOLiN") | [![](https://avatars.githubusercontent.com/u/30264003?v=4&s=100)   **Jérôme Arnoux**](https://github.com/axbazin)    [🎨](https://github.com/labgem/PPanGGOLiN "Design: PPanGGOLiN") [🤔](https://github.com/labgem/PPanGGOLiN "Ideas: PPanGGOLiN") |

Thanks go to the following people, who participated in the development of **panGWAS**:

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| [![](https://ui-avatars.com/api/?name=IMartin?s=100)   **Irene Martin**](https://github.com/phac-nml)    [🤔](https://github.com/phac-nml "Ideas: GWAS") [🔣](https://github.com/phac-nml "Data: iGAS") | [![](https://ui-avatars.com/api/?name=AGolden?s=100)   **Alyssa Golden**](https://github.com/phac-nml)    [🤔](https://github.com/phac-nml "Ideas: GWAS") [🔣](https://github.com/phac-nml "Data: iGAS") | [![](https://avatars.githubusercontent.com/u/37002890?v=4&s=100)   **Shelley Peterson**](https://github.com/ShelleyPeterson)    [🤔](https://github.com/phac-nml "Ideas: GWAS") [🔣](https://github.com/ShelleyPeterson "Data: iGAS") | [![](https://ui-avatars.com/api/?name=NKnox?s=100)   **Natalie Knox**](https://github.com/phac-nml)    [🤔](https://github.com/phac-nml "Ideas: GWAS") | [![](https://ui-avatars.com/api/?name=ATyler?s=100)   **Andrea Tyler**](https://github.com/phac-nml)    [🤔](https://github.com/phac-nml "Ideas: GWAS") |
| [![](https://avatars.githubusercontent.com/u/46600008?v=4)   **Darian Hole**](https://github.com/DarianHole)    [👀](https://github.com/phac-nml "Review: Pull Request") [⚠️](https://github.com/DarianHole "Testing") [🛡️](https://github.com/DarianHole "Security") | [![](https://avatars.githubusercontent.com/u/24962136?v=4)   **Connor Chato**](https://github.com/ConnorChato)    [🔬](https://github.com/ConnorChato "Research: Clustering") [🤔](https://github.com/ConnorChato "Ideas: Clustering") | [![](https://avatars.githubusercontent.com/u/89413643?v=4)   **Amber Papineau**](https://github.com/apapineau)    [🔣](https://github.com/apapineau "Data: Heatmap") [🔬](https://github.com/apapineau "Research: Heatmap") | [![](https://avatars.githubusercontent.com/u/141779800?v=4)   **Molly Pratt**](https://github.com/molpratt)    [🎨](https://github.com/molpratt "Design: Workflow Flowchart") | [![](https://avatars.githubusercontent.com/u/60520877?v=4)   **Kirsten Palmier**](https://github.com/KirstenPalmier)    [🔬](https://github.com/KirstenPalmier "Literature Review, Research: GWAS") |
| [![](https://avatars.githubusercontent.com/u/11616351?v=4)   **Adrian Azetner**](https://github.com/TheZetner)    [🤔](https://github.com/TheZetner "Ideas: Plots") | [![](https://avatars.githubusercontent.com/u/69822095?v=4)   **Ana Duggan**](https://github.com/atduggan)    [🤔](https://github.com/atduggan "Ideas: Trees") [👀](https://github.com/atduggan "Review: Pull Request") [📆](https://github.com/atduggan "Project Management") | [![](https://avatars.githubusercontent.com/u/52721825?v=4)   **Emily Haverhold**](https://github.com/GH-Emily)    [📆](https://github.com/GH-Emily "Project Management") |
|

## License

Copyright 2025 Government of Canada

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this work except in compliance with the License. You may obtain a copy of the License at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.