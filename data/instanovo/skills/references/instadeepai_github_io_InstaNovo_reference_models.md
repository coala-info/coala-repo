[ ]
[ ]

[Skip to content](#models)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Models

Initializing search

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [Tutorials](../../tutorials/getting_started/)
* [How-to guides](../../how-to/predicting/)
* [Reference](../cli/)
* [Explanation](../../explanation/performance/)
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
* [x]

  Reference

  Reference
  + [CLI](../cli/)
  + [ ]

    Models

    [Models](./)

    Table of contents
    - [Training Datasets](#training-datasets)
    - [Acknowledgements](#acknowledgements)
  + [Supported Modifications](../modifications/)
  + [Prediction Output](../prediction_output/)
  + [API](../../API/summary/)
* [ ]

  Explanation

  Explanation
  + [Performance](../../explanation/performance/)
  + [SpectrumDataFrame](../../explanation/spectrum_data_frame/)
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

# Models

InstaNovo 1.1.0 includes two new models: [`instanovo-v1.1.0.ckpt`](https://github.com/instadeepai/InstaNovo/releases/download/1.1.0/instanovo-v1.1.0.ckpt), and [`instanovoplus-v1.1.0.ckpt`](https://github.com/instadeepai/InstaNovo/releases/download/1.1.2/instanovo-phospho-v1.0.0.ckpt) trained
on a larger dataset with more PTMs.

> Note: The InstaNovo Extended 1.0.0 training data mis-represented Cysteine as unmodified for the
> majority of the training data. Please update to the latest version of the model.

## Training Datasets

* [ProteomeTools](https://www.proteometools.org/) Part
  [I (PXD004732)](https://www.ebi.ac.uk/pride/archive/projects/PXD004732),
  [II (PXD010595)](https://www.ebi.ac.uk/pride/archive/projects/PXD010595), and
  [III (PXD021013)](https://www.ebi.ac.uk/pride/archive/projects/PXD021013) (referred to as the all-confidence ProteomeTools `AC-PT` dataset in our paper)
* Additional PRIDE dataset with more modifications:
  ([PXD000666](https://www.ebi.ac.uk/pride/archive/projects/PXD000666), [PXD000867](https://www.ebi.ac.uk/pride/archive/projects/PXD000867),
  [PXD001839](https://www.ebi.ac.uk/pride/archive/projects/PXD001839), [PXD003155](https://www.ebi.ac.uk/pride/archive/projects/PXD003155),
  [PXD004364](https://www.ebi.ac.uk/pride/archive/projects/PXD004364), [PXD004612](https://www.ebi.ac.uk/pride/archive/projects/PXD004612),
  [PXD005230](https://www.ebi.ac.uk/pride/archive/projects/PXD005230), [PXD006692](https://www.ebi.ac.uk/pride/archive/projects/PXD006692),
  [PXD011360](https://www.ebi.ac.uk/pride/archive/projects/PXD011360), [PXD011536](https://www.ebi.ac.uk/pride/archive/projects/PXD011536),
  [PXD013543](https://www.ebi.ac.uk/pride/archive/projects/PXD013543), [PXD015928](https://www.ebi.ac.uk/pride/archive/projects/PXD015928),
  [PXD016793](https://www.ebi.ac.uk/pride/archive/projects/PXD016793), [PXD017671](https://www.ebi.ac.uk/pride/archive/projects/PXD017671),
  [PXD019431](https://www.ebi.ac.uk/pride/archive/projects/PXD019431), [PXD019852](https://www.ebi.ac.uk/pride/archive/projects/PXD019852),
  [PXD026910](https://www.ebi.ac.uk/pride/archive/projects/PXD026910), [PXD027772](https://www.ebi.ac.uk/pride/archive/projects/PXD027772))
* [Massive-KB v1](https://massive.ucsd.edu/ProteoSAFe/static/massive.jsp)
* Additional phosphorylation dataset
  (not yet publicly released)

## Acknowledgements

Big thanks to Pathmanaban Ramasamy, Tine Claeys, and Lennart Martens of the
[CompOmics](https://www.compomics.com/) research group for providing us with additional
phosphorylation training data.

Back to top

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)