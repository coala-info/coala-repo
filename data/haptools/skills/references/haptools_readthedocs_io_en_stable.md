haptools

Overview

* [Installation](project_info/installation.html)
* [Example files](project_info/example_files.html)
* [Contributing](project_info/contributing.html)

File Formats

* [Genotypes](formats/genotypes.html)
* [Haplotypes](formats/haplotypes.html)
* [Phenotypes and Covariates](formats/phenotypes.html)
* [Linkage disequilibrium](formats/ld.html)
* [Summary Statistics](formats/linear.html)
* [Causal SNPs](formats/snplist.html)
* [Breakpoints](formats/breakpoints.html)
* [Sample Info](formats/sample_info.html)
* [Models](formats/models.html)
* [Maps](formats/maps.html)

Commands

* [simgenotype](commands/simgenotype.html)
* [simphenotype](commands/simphenotype.html)
* [karyogram](commands/karyogram.html)
* [transform](commands/transform.html)
* [index](commands/index.html)
* [clump](commands/clump.html)
* [ld](commands/ld.html)

API

* [data](api/data.html)
* [haptools](api/modules.html)
* [examples](api/examples.html)

haptools

* haptools
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/index.rst)

---

# haptools[](#haptools "Link to this heading")

Haptools is a collection of tools for simulating and analyzing genotypes and phenotypes while taking into account haplotype and ancestry information.

We support fast simulation of admixed genomes, visualization of admixture tracks, simulating haplotype- and local ancestry-specific phenotype effects, and computing a variety of common file operations and statistics in a haplotype-aware manner.

At the core of haptools lies the [.hap file](formats/haplotypes.html), our new file format for haplotypes designed for speed, extensibility, and ease-of-use.

## Commands[](#commands "Link to this heading")

* [haptools simgenotype](commands/simgenotype.html): Simulate genotypes for admixed individuals under user-specified demographic histories.
* [haptools simphenotype](commands/simphenotype.html): Simulate a complex trait, taking into account local ancestry- or haplotype- specific effects. `haptools simphenotype` takes as input a VCF file (usually from `haptools transform`) and outputs simulated phenotypes for each sample.
* [haptools karyogram](commands/karyogram.html): Visualize a “chromosome painting” of local ancestry labels based on breakpoints output by `haptools simgenotype`.
* [haptools transform](commands/transform.html): Transform a set of genotypes via a list of haplotypes. Create a new VCF containing haplotypes instead of variants.
* [haptools index](commands/index.html): Sort, compress, and index our custom file format for haplotypes.
* [haptools clump](commands/clump.html): Convert variants in LD with one another into clumps.
* [haptools ld](commands/ld.html): Compute Pearson’s correlation coefficient between a target haplotype and a set of haplotypes.

![Overview of haptools commands](https://github.com/CAST-genomics/haptools/assets/23412689/7de95547-3138-45c6-99d8-46bca5716c26)

Outputs produced by these utilities are compatible with each other.
For example `haptools simgenotype` outputs a VCF file with local ancestry information annotated for each variant.
The VCF and breakpoints file output by `haptools simgenotype` can be used as input to `haptools transform`, which is then used by `haptools simphenotype` to simulate phenotypes for a list of haplotypes.
The local ancestry breakpoints from `haptools simgenotype` can also be visualized using `haptools karyogram`.

Detailed information about each command can be found in the *Commands* section of our documentation. Examples there utilize a set of example files described [here](project_info/example_files.html).

## Logging[](#logging "Link to this heading")

All commands output log messages to standard error. The universal `--verbosity` flag controls the level of detail in our logging messages. By default, this is set to `INFO`, which will yield errors, warnings, and info messages. To get more detailed messages, set it to `DEBUG`. To get only error messages, set it to `ERROR`. To get errors *and* warnings, set it to `WARNING`. Refer to [the Python documentation on logging levels](https://docs.python.org/3/library/logging.html#levels) for more information.

## Contributing[](#contributing "Link to this heading")

We gladly welcome any contributions to `haptools`!

Please read our [contribution guidelines](project_info/contributing.html) and then submit a [Github issue](https://github.com/cast-genomics/haptools/issues).

## Citing[](#citing "Link to this heading")

There is an option to *Cite this repository* on the right sidebar of [the repository homepage](https://github.com/CAST-genomics/haptools).

> Arya R Massarat, Michael Lamkin, Ciara Reeve, Amy L Williams, Matteo D’Antonio, Melissa Gymrek, Haptools: a toolkit for admixture and haplotype analysis, Bioinformatics, 2023;, btad104, <https://doi.org/10.1093/bioinformatics/btad104>

[Next](project_info/installation.html "Installation")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).