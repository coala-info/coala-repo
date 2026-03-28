[ ]
[ ]

[Skip to content](#explanation-instanovo-performance)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Performance

Initializing search

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [Tutorials](../../tutorials/getting_started/)
* [How-to guides](../../how-to/predicting/)
* [Reference](../../reference/cli/)
* [Explanation](./)
* [Blog](../../blog/introducing-the-next-generation-of-instanovo-models/)
* [For developers](../../development/setup/)
* [How to cite](../../citation/)
* [License](../../license/)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")
InstaNovo

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [ ]

  Tutorials

  Tutorials
  + [Quick overview](../../tutorials/getting_started/)
  + [Getting started with InstaNovo](../../notebooks/getting_started_with_instanovo/)
  + [Introducing the next generation of InstaNovo models](../../notebooks/introducing_the_next_generation_of_InstaNovo_models/)
  + [Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics](../../notebooks/InstaNovo-P/)
* [ ]

  How-to guides

  How-to guides
  + [Predicting](../../how-to/predicting/)
  + [Using Custom Datasets](../../how-to/using_custom_datasets/)
  + [Training](../../how-to/training/)
* [ ]

  Reference

  Reference
  + [CLI](../../reference/cli/)
  + [Models](../../reference/models/)
  + [Supported Modifications](../../reference/modifications/)
  + [Prediction Output](../../reference/prediction_output/)
  + [API](../../API/summary/)
* [x]

  Explanation

  Explanation
  + [ ]

    Performance

    [Performance](./)

    Table of contents
    - [Performance Metrics](#performance-metrics)
    - [Benchmarks](#benchmarks)

      * [Nine-species dataset](#nine-species-dataset)
      * [Biological validation datasets](#biological-validation-datasets)
  + [SpectrumDataFrame](../spectrum_data_frame/)
* [ ]

  Blog

  Blog
  + [Introducing the next generation of InstaNovo models](../../blog/introducing-the-next-generation-of-instanovo-models/)
  + [Introducing InstaNovo-P](../../blog/introducing-instanovo-p-a-de-novo-sequencing-model-for-phosphoproteomics/)
  + [Winnow: calibrated confidence and FDR control for de novo sequencing](../../blog/calibrated-confidence-and-fdr-control-for-de-novo-sequencing/)
* [ ]

  For developers

  For developers
  + [Set up a development environment](../../development/setup/)
  + [Test Coverage](../../development/coverage/)
  + [Test Report](../../development/allure/)
* [How to cite](../../citation/)
* [License](../../license/)

# Explanation: InstaNovo Performance

This document provides an overview of InstaNovo's performance on various benchmark datasets.

## Performance Metrics

We evaluate the performance of InstaNovo using **peptide accuracy**. This metric measures the percentage of correctly predicted peptide sequences at full coverage (i.e., without any confidence filtering).

## Benchmarks

We have benchmarked InstaNovo v1.1 and InstaNovo+ v1.1 against our previous models. For all results, InstaNovo decoding was performed with knapsack beam search decoding, and InstaNovo+ was used for refinement.

### Nine-species dataset

This dataset contains spectra from nine different species. The models were evaluated in a zero-shot setting (i.e., without any fine-tuning on the test species).

| Dataset | InstaNovo v0.1 | InstaNovo+ v0.1 | InstaNovo v1.1 | InstaNovo+ v1.1 |
| --- | --- | --- | --- | --- |
| Bacillus | 0.624 | 0.674 | 0.652 | **0.684** |
| Mouse | 0.466 | 0.490 | 0.524 | **0.542** |
| Yeast | 0.559 | 0.624 | 0.618 | **0.645** |

### Biological validation datasets

We also evaluated the models on a variety of challenging biological datasets.

| Dataset | InstaNovo v0.1 | InstaNovo+ v0.1 | InstaNovo v1.1 | InstaNovo+ v1.1 |
| --- | --- | --- | --- | --- |
| HeLa degradome | 0.695 | 0.719 | 0.813 | **0.821** |
| HeLa single-shot | 0.503 | 0.517 | 0.642 | **0.647** |
| Herceptin | 0.494 | 0.562 | 0.710 | **0.720** |
| Immunopeptidomics | 0.581 | 0.697 | 0.707 | **0.748** |
| *Candidatus* "Scalindua brodae" | 0.724 | 0.736 | 0.748 | **0.762** |
| Snake venoms | 0.196 | 0.198 | 0.221 | **0.238** |
| Nanobodies | 0.447 | 0.464 | 0.492 | **0.508** |
| Wound fluids | 0.225 | 0.229 | 0.354 | **0.364** |

As the results show, InstaNovo+ v1.1 consistently outperforms the previous models across all datasets.

Back to top

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)