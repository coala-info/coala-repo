[ ]
[ ]

[Skip to content](#de-novo-peptide-sequencing-with-instanovo)

[![logo](assets/instanovo_logo_square.svg)](. "InstaNovo")

InstaNovo

Home

Initializing search

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](.)
* [Tutorials](tutorials/getting_started/)
* [How-to guides](how-to/predicting/)
* [Reference](reference/cli/)
* [Explanation](explanation/performance/)
* [Blog](blog/introducing-the-next-generation-of-instanovo-models/)
* [For developers](development/setup/)
* [How to cite](citation/)
* [License](license/)

[![logo](assets/instanovo_logo_square.svg)](. "InstaNovo")
InstaNovo

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [ ]
  [Home](.)
* [ ]

  Tutorials

  Tutorials
  + [Quick overview](tutorials/getting_started/)
  + [Getting started with InstaNovo](notebooks/getting_started_with_instanovo/)
  + [Introducing the next generation of InstaNovo models](notebooks/introducing_the_next_generation_of_InstaNovo_models/)
  + [Introducing InstaNovo-P, a de novo sequencing model for phosphoproteomics](notebooks/InstaNovo-P/)
* [ ]

  How-to guides

  How-to guides
  + [Predicting](how-to/predicting/)
  + [Using Custom Datasets](how-to/using_custom_datasets/)
  + [Training](how-to/training/)
* [ ]

  Reference

  Reference
  + [CLI](reference/cli/)
  + [Models](reference/models/)
  + [Supported Modifications](reference/modifications/)
  + [Prediction Output](reference/prediction_output/)
  + [API](API/summary/)
* [ ]

  Explanation

  Explanation
  + [Performance](explanation/performance/)
  + [SpectrumDataFrame](explanation/spectrum_data_frame/)
* [ ]

  Blog

  Blog
  + [Introducing the next generation of InstaNovo models](blog/introducing-the-next-generation-of-instanovo-models/)
  + [Introducing InstaNovo-P](blog/introducing-instanovo-p-a-de-novo-sequencing-model-for-phosphoproteomics/)
  + [Winnow: calibrated confidence and FDR control for de novo sequencing](blog/calibrated-confidence-and-fdr-control-for-de-novo-sequencing/)
* [ ]

  For developers

  For developers
  + [Set up a development environment](development/setup/)
  + [Test Coverage](development/coverage/)
  + [Test Report](development/allure/)
* [How to cite](citation/)
* [License](license/)

![InstaNovo Logo](assets/instanovo_logo_square.svg)

# *De novo* peptide sequencing with InstaNovo

[![PyPI version](https://badge.fury.io/py/instanovo.svg)](https://badge.fury.io/py/instanovo) [![code coverage](assets/coverage.svg)](development/coverage/) [![DOI](https://zenodo.org/badge/681625644.svg)](https://doi.org/10.5281/zenodo.14712453) [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/instadeepai/InstaNovo/blob/main/notebooks/getting_started_with_instanovo.ipynb)

InstaNovo is a transformer neural network with the ability to translate
fragment ion peaks into the sequence of amino acids that make up the studied peptide(s). InstaNovo+,
inspired by human intuition, is a multinomial diffusion model that further improves performance by
iterative refinement of predicted sequences.

This documentation will help you get started with InstaNovo. It is divided into the following sections:

* **[Tutorials](tutorials/getting_started/)**
  + How to [install](tutorials/getting_started/#installation) InstaNovo, make your first [prediction](tutorials/getting_started/#making-your-first-prediction) and [evaluate](tutorials/getting_started/#evaluating-performance) InstaNovo's performance.
  + An end-to-end starter [notebook](notebooks/getting_started_with_instanovo/) that you can [run in Google Colab](https://colab.research.google.com/github/instadeepai/InstaNovo/blob/main/notebooks/getting_started_with_instanovo.ipynb).
* **[How-to guides](how-to/predicting/)**:
  + How to perform [predictions](how-to/predicting/#basic-prediction) with InstaNovo with iterative refinement of InstaNovo+, or how to [use each model separately](how-to/predicting/#advanced-prediction-scenarios).
  + Guide for preparing your [own data](how-to/using_custom_datasets/) for use with InstaNovo and InstaNovo+.
  + Details how to [train](how-to/training/) your own InstaNovo and InstaNovo+ models.
* **[Reference](reference/cli/)**:
  + Overview of the `instanovo` [command-line interface](reference/cli/).
  + List of the supported [post translational modifications](reference/modifications/).
  + Description of the columns in the [prediction output CSV](reference/prediction_output/)
  + Code [reference API](API/summary/)
* **[Explanation](explanation/performance/)**:
  + Explains our [performance metrics](explanation/performance/#performance-metrics) and [benchmarking results](explanation/performance/#benchmarks)
  + A detailed explanation of the [`SpectrumDataFrame`](explanation/spectrum_data_frame/) class and its features.
* **[Blog](blog/introducing-the-next-generation-of-instanovo-models/)**:
  + [Introducing the next generation of InstaNovo models](blog/introducing-the-next-generation-of-instanovo-models/)
  + [Introducing InstaNovo-P](blog/introducing-instanovo-p-a-de-novo-sequencing-model-for-phosphoproteomics/)
  + [Winnow: calibrated confidence and FDR control for *de novo* sequencing](blog/calibrated-confidence-and-fdr-control-for-de-novo-sequencing/)
* **[For Developers](development/setup/)**:
  + How to set up a [development environment](development/setup/#setting-up-with-uv).
  + How to run the [tests](development/setup/#testing) and [lint](development/setup/#linting) the code.
  + View the [test coverage](development/coverage/) and [test report](development/allure/).
* **[How to Cite](citation/)**:
  + Bibtex references for our [peer-reviewed publication](citation/#instanovo-instanovo) on InstaNovo and InstaNovo+ and our preprints on [InstaNovo-P](citation/#instanovo-p), [InstaNexus](citation/#instanexus) and [Winnow](citation/#winnow).
* **[License](license/)**:
  + Code is licensed under the [Apache License, Version 2.0](license/#apache-license)
  + The model checkpoints are licensed under Creative Commons Non-Commercial ([CC BY-NC-SA 4.0](license/#creative-commons-attribution-noncommercial-sharealike-40-international))

**Developed by:**

* [InstaDeep](https://www.instadeep.com/)
* [The Department of Biotechnology and Biomedicine](https://orbit.dtu.dk/en/organisations/department-of-biotechnology-and-biomedicine) -
  [Technical University of Denmark](https://www.dtu.dk/)

Back to top

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)