[ ]
[ ]

[Skip to content](#reference-command-line-interface)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

CLI

Initializing search

[instadeepai/InstaNovo](https://github.com/instadeepai/InstaNovo "Go to repository")

* [Home](../..)
* [Tutorials](../../tutorials/getting_started/)
* [How-to guides](../../how-to/predicting/)
* [Reference](./)
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
  + [ ]

    CLI

    [CLI](./)

    Table of contents
    - [Top-level commands](#top-level-commands)
    - [Version info](#version-info)
    - [Prediction commands](#prediction-commands)

      * [instanovo predict](#instanovo-predict)
      * [instanovo transformer predict](#instanovo-transformer-predict)
      * [instanovo diffusion predict](#instanovo-diffusion-predict)
    - [Training commands](#training-commands)

      * [instanovo transformer train](#instanovo-transformer-train)
      * [instanovo diffusion train](#instanovo-diffusion-train)
    - [Data conversion](#data-conversion)

      * [instanovo convert](#instanovo-convert)
  + [Models](../models/)
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

# Reference: Command-Line Interface

InstaNovo provides a command-line interface (CLI) for accessing its main functionalities.

## Top-level commands

To see the main commands, run:

```
instanovo --help
```

![instanovo --help](../../assets/screenshots/instanovo_help.svg)

This will show the following top-level commands:

* `predict`: The main command for making predictions.
* `transformer`: Commands related to the InstaNovo transformer model (train, predict, etc.).
* `diffusion`: Commands related to the InstaNovo+ diffusion model (train, predict, etc.).
* `convert`: A command for converting data to InstaNovo's native format.
* `version`: Shows the version of InstaNovo and its dependencies.

## Version info

To see the version of InstaNovo, InstaNovo+ and some of the dependencies, run:

```
instanovo version
```

![instanovo version](../../assets/screenshots/instanovo_version.svg)

## Prediction commands

### `instanovo predict`

This is the default prediction command that first makes a prediction with the transformer-based InstaNovo model and then iteratively refines the result with the diffusion-based InstaNovo+ model.

```
instanovo predict --help
```

![instanovo predict --help](../../assets/screenshots/instanovo_predict_help.svg)

### `instanovo transformer predict`

This command runs prediction with only the transformer model.

```
instanovo transformer predict --help
```

![instanovo transformer predict --help](../../assets/screenshots/instanovo_transformer_predict_help.svg)

### `instanovo diffusion predict`

This command runs prediction with only the diffusion model.

```
instanovo diffusion predict --help
```

![instanovo diffusion predict --help](../../assets/screenshots/instanovo_diffusion_predict_help.svg)

## Training commands

### `instanovo transformer train`

This command trains the transformer model.

```
instanovo transformer train --help
```

![instanovo transformer train --help](../../assets/screenshots/instanovo_transformer_train_help.svg)

### `instanovo diffusion train`

This command trains the diffusion model.

```
instanovo diffusion train --help
```

![instanovo diffusion train --help](../../assets/screenshots/instanovo_diffusion_train_help.svg)

## Data conversion

### `instanovo convert`

This command converts data to InstaNovo's native [`SpectrumDataFrame`](../../explanation/spectrum_data_frame/) format.

```
instanovo convert --help
```

![instanovo convert --help](../../assets/screenshots/instanovo_convert_help.svg)

Back to top

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)