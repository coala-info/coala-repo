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
* Sample Info
  + [1000 Genomes sample\_info file format](#genomes-sample-info-file-format)
  + [Examples](#examples)
* [Models](models.html)
* [Maps](maps.html)

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

* Sample Info
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/sample_info.rst)

---

# Sample Info[](#sample-info "Link to this heading")

A *samples info* file maps samples in a reference to their population listed in a [model file](models.html). This file is used by the [simgenotype](../commands/simgenotype.html) command.

## 1000 Genomes sample\_info file format[](#genomes-sample-info-file-format "Link to this heading")

You can download a *samples info* file compatible with the 1000G reference by executing the following.

```
wget https://raw.githubusercontent.com/CAST-genomics/haptools/main/example-files/1000genomes_sampleinfo.tsv
```

If you’d like to compute this mapping file yourself, execute the following:

```
cut -f 1,4 "igsr-1000 genomes on grch38.tsv" | \
sed '1d' | \
sed -e 's/ /\t/g' > 1000genomes_sampleinfo.tsv
```

## Examples[](#examples "Link to this heading")

```
HG00372 FIN
HG00132 GBR
HG00237 GBR
HG00404 CHS
```

See [example-files/1000genomes\_sampleinfo.tsv](https://github.com/cast-genomics/haptools/blob/main/example-files/1000genomes_sampleinfo.tsv) for an example of the 1000genomes
GRCh38 samples mapped to their subpopulations.

```
HG00358 FIN
HG00360 FIN
HG00365 FIN
HG00372 FIN
HG00132 GBR
HG00137 GBR
HG00149 GBR
HG00151 GBR
HG00182 FIN
HG00187 FIN
HG00136 GBR
HG00233 GBR
```

[Previous](breakpoints.html "Breakpoints")
[Next](models.html "Models")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).