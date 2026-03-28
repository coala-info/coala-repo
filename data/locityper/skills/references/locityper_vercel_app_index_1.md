[Locityper](/)[AboutAbout](/about)[GitHubGitHub (opens in a new tab)](https://github.com/tprodanov/locityper)

* [Introduction](/)
* [Installation](/install)
* [Test dataset](/test_dataset)
* [Commands](/commands)
* [Input/Output](/input_output)
* [Method description](/descr)
* [Avalable data](/available_data)

Light

On This Page

* [Citation](#citation)
* [Installation](#installation)
* [Test dataset](#test-dataset)
* [Available data](#available-data)
* [Locityper applications](#locityper-applications)
* [See also](#see-also)

[Report bug/Ask question (opens in a new tab)](https://github.com/tprodanov/locityper/issues)Scroll to top

# Locityper

Locityper is targeted genotyper for complex polymorphic genes based on short and long-read whole genome sequencing.
Locityper is created by
[Timofey Prodanov (opens in a new tab)](https://marschall-lab.github.io/people/tprodanov/) `timofey.prodanov[at]hhu.de` and
[Tobias Marschall (opens in a new tab)](https://marschall-lab.github.io/people/tmarschall/) `tobias.marschall[at]hhu.de`
at the [Marschall Lab (opens in a new tab)](https://marschall-lab.github.io/),
[Heinrich Heine University Düsseldorf (opens in a new tab)](https://hhu.de).

Locityper repository can be found [here (opens in a new tab)](https://github.com/tprodanov/locityper).
Please, check if you are using the latest Locityper [release (opens in a new tab)](https://github.com/tprodanov/locityper/releases).

## Citation

Please check out our paper [here (opens in a new tab)](https://doi.org/10.1038/s41588-025-02362-4)

TextBibtex

T. Prodanov, E.G. Plender, G. Seebohm, S.G. Meuth, E.E. Eichler, T. Marschall.
Locityper enables targeted genotyping of complex polymorphic genes.
*Nature Genetics* **57**, 2901–2908 (2025).

## Installation

The easiest way to install Locityper is with
[conda (opens in a new tab)](https://conda.io/projects/conda/en/latest/user-guide/install/index.html).
For that, please enable [bioconda (opens in a new tab)](https://bioconda.github.io) channel, and run the following line:

```
conda install -c bioconda locityper
```

Installation should finish faster with
[mamba (opens in a new tab)](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html) utility
(`mamba install locityper`).

Extended installation instructions can be found [here](/install),
including instructions for the container platforms
[singularity (opens in a new tab)](https://docs.sylabs.io/guides/3.5/user-guide/introduction.html) and
[docker (opens in a new tab)](https://www.docker.com).

## Test dataset

You can find test dataset and corresponding instructions [here](/test_dataset).

## Available data

Locityper genotype predictions and preprocessed data for the 1KGP samples can be
found [here](/available_data).

## Locityper applications

Locityper is actively applied in various research settings.
You can find examples in the following manuscripts:

* E. Plender *et al*. Structural and genetic diversity in the secreted mucins, *MUC5AC* and *MUC5B*.
  *The American Journal of Human Genetics* **111**, 1700–1716 (2024),
  [doi.org/10.1016/j.ajhg.2024.06.007 (opens in a new tab)](https://doi.org/10.1016/j.ajhg.2024.06.007)
* G. Logsdon *et al*. Complex genetic variation in nearly complete human genomes.
  *Nature* **644** 430–441 (2025),
  [doi.org/10.1038/s41586-025-09140-6 (opens in a new tab)](https://doi.org/10.1038/s41586-025-09140-6)
* S. Schloissnig, S. Pani *et al*. Structural variation in 1,019 diverse humans based on long-read sequencing.
  *Nature* **644**, 442–452 (2025),
  [doi.org/10.1038/s41586-025-09290-7 (opens in a new tab)](https://doi.org/10.1038/s41586-025-09290-7)
* W. Ma & M. Chaisson. Genotyping sequence-resolved copy number variation using pangenomes reveals
  paralog-specific global diversity and expression divergence of duplicated genes.
  *Nature Genetics* (2025),
  [doi.org/10.1038/s41588-025-02346-4 (opens in a new tab)](https://doi.org/10.1038/s41588-025-02346-4)
* K. Garimella *et al*. Population-scale Long-read Sequencing in the All of Us Research Program.
  *medRxiv* (2025),
  [doi.org/10.1101/2025.10.02.25336942 (opens in a new tab)](https://doi.org/10.1101/2025.10.02.25336942)

Please, write me (`timofey.prodanov[at]hhu.de`) if you want to add your paper to this list.

## See also

Additionally, you may be interested in these tools:

* [Parascopy (opens in a new tab)](https://github.com/tprodanov/parascopy)
  for copy number analysis and variant calling within segmental duplications,
* [Pangenie (opens in a new tab)](https://github.com/eblerjana/pangenie)
  for pangenome-based short-read variant calling,
* [Pileuppy (opens in a new tab)](https://gitlab.com/tprodanov/pileuppy): fast and colorful BAM/CRAM pileup,
* [DuploMap (opens in a new tab)](https://gitlab.com/tprodanov/duplomap) for improving long read alignments to segmental duplications.

[Installation](/install "Installation")

Light

---

[Timofey Prodanov. Locityper documentation (2024).](https://github.com/tprodanov/locityper-docs)

[Created using the Nextra theme.](https://nextra.site)