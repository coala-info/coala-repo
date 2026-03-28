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
* Models
  + [Structure of a model.dat file](#structure-of-a-model-dat-file)
  + [Example model.dat file](#example-model-dat-file)
  + [Example pulse event model.dat file](#example-pulse-event-model-dat-file)
  + [More Example files](#more-example-files)
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

* Models
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/models.rst)

---

# Models[](#models "Link to this heading")

This model file format is based on [admix simu’s](https://github.com/williamslab/admix-simu).

## Structure of a model.dat file[](#structure-of-a-model-dat-file "Link to this heading")

* `num_samples` - Total number of samples to be output by the simulator (`num_samples*2` haplotypes)
* `num_generations` - Number of generations to simulate admixture, must be > 0
* `*_freq` - Frequency of populations to be present in the simulated samples

```
{num_samples} Admixed Pop_label1 Pop_label2 ... Pop_labeln
{num_generations} {admixed_freq} {pop_label1_freq} {pop_label2_freq} ... {pop_labeln_freq}
```

## Example model.dat file[](#example-model-dat-file "Link to this heading")

```
40   Admixed   CEU    YRI
6    0         0.2    0.8
```

Simulating 40 samples for 6 generations in this case implies the first generation has population freqs `Admixed=0, CEU=0.2, YRI=0.8` and the remaining 2-6 generations have population frequency `Admixed=1, CEU=0, YRI=0`

## Example pulse event model.dat file[](#example-pulse-event-model-dat-file "Link to this heading")

```
40   Admixed   CEU    YRI
1    0         0.2    0.8
2    1         0      0
3    0.5       0.5    0
4    1         0      0
```

Simulating 40 samples for 4 generations in this case implies the first generation has population freqs `Admixed=0, CEU=0.2, YRI=0.8` the second generation is purely admixed, the third has an event where a pure CEU population is introduced again at freqs `Admixed=0.5, CEU=0.5, YRI=0` and finally we end with pure admixture.

## More Example files[](#more-example-files "Link to this heading")

We have generated example model files that simulate current population structures within different populations in America as well as the Caribbean that can be found in the haptools repository here: [haptools/example-files/models/](https://github.com/CAST-genomics/haptools/tree/main/example-files/models)
There are additional example model files that can be found in the haptools repository under [haptools/tests/data/](https://github.com/CAST-genomics/haptools/tree/main/tests/data)

[Previous](sample_info.html "Sample Info")
[Next](maps.html "Maps")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).