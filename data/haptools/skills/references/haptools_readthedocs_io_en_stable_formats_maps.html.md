[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](genotypes.html)
* [Haplotypes](haplotypes.html)
* [Phenotypes and Covariates](phenotypes.html)
* [Linkage disequilibrium](ld.html)
* [Summary Statistics](linear.html)
* [Causal SNPs](snplist.html)
* [Breakpoints](breakpoints.html)
* [Sample Info](sample_info.html)
* [Models](models.html)
* Maps
  + [Fields](#fields)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* Maps
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/maps.rst)

---

# Maps[](#maps "Link to this heading")

[Map format](https://www.cog-genomics.org/plink/1.9/formats#map) from plink which is space delimited.

## Fields[](#fields "Link to this heading")

* `chr` - chromosome of coordinate (1-22, X)
* `var` - variant identifier
* `pos_cM` - Position in centimorgans
* `pos_bp` - Base pair coordinate

```
chr var pos_cM pos_bp
```

Beagle Genetic Maps used in `simgenotype` (GRCh38): <https://bochet.gcc.biostat.washington.edu/beagle/genetic_maps/>

[Previous](models.html "Models")
[Next](../commands/simgenotype.html "simgenotype")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).