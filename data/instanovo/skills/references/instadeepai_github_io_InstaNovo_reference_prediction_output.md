[ ]
[ ]

[Skip to content](#reference-prediction-output)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Prediction Output

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
  + [Models](../models/)
  + [Supported Modifications](../modifications/)
  + [ ]

    Prediction Output

    [Prediction Output](./)

    Table of contents
    - [Standard Columns](#standard-columns)
    - [InstaNovo (Transformer) Model Columns](#instanovo-transformer-model-columns)
    - [InstaNovo+ (Diffusion) Model Columns](#instanovo-diffusion-model-columns)
    - [Usage Notes](#usage-notes)
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

# Reference: Prediction Output

When you run predictions with InstaNovo and specify an output path, a CSV file is generated. This document describes the columns in that file.

## Standard Columns

| Column | Description | Data Type | Notes |
| --- | --- | --- | --- |
| experiment\_name | Experiment name derived from input filename | String | Based on the input file name (mgf, mzml, or mzxml) |
| scan\_number | Scan number of the MS/MS spectrum | Integer | Unique identifier from the input file |
| spectrum\_id | Unique spectrum identifier | String | Combination of experiment name and scan number (e.g., `yeast:17738`) |
| precursor\_mz | Precursor m/z (mass-to-charge ratio) | Float | The observed m/z of the precursor ion |
| precursor\_charge | Precursor charge state | Integer | Charge state of the precursor ion |
| prediction\_id | Unique prediction identifier | String | Internal identifier for the prediction |
| group | Data group identifier | String | Used when running predictions on grouped data |
| targets | Target peptide sequence | String | Ground truth peptide sequence (only present if running in evaluation mode) |
| predictions | Best predicted peptide sequence | String | The final predicted peptide sequence (from InstaNovo+ when using refinement) |
| predictions\_tokenised | Best predicted peptide sequence (tokenised) | String | The predicted sequence as comma-separated tokens |
| log\_probs | Log probability of the best predicted sequence | Float | Natural logarithm of the sequence confidence. Higher is better. |
| token\_log\_probs | Log probability of each token in the best prediction | List[Float] | Natural logarithm of the confidence for each amino acid in the sequence |
| delta\_mass\_ppm | Mass difference between precursor and predicted peptide in ppm | Float | The mass deviation in parts per million. Lower is better. |

## InstaNovo (Transformer) Model Columns

These columns are present when using InstaNovo+ (combined transformer + diffusion model).

| Column | Description | Data Type | Notes |
| --- | --- | --- | --- |
| instanovo\_predictions | Predicted peptide sequence from InstaNovo | String | The initial peptide sequence from the transformer |
| instanovo\_log\_probabilities | Log probability from InstaNovo | Float | Natural logarithm of the sequence confidence |
| instanovo\_token\_log\_probabilities | Token log probabilities from InstaNovo | List[Float] | Natural logarithm of the confidence for each token |
| instanovo\_predictions\_beam\_0-4 | Predicted sequences from each beam | String | Beam search results when num\_beams > 1 |
| instanovo\_log\_probabilities\_beam\_0-4 | Log probabilities from each beam | Float | Confidence scores for each beam |
| instanovo\_token\_log\_probabilities\_beam\_0-4 | Token log probabilities from each beam | List[Float] | Per-token confidence for each beam |

## InstaNovo+ (Diffusion) Model Columns

These columns are present when using InstaNovo+ (combined transformer + diffusion model).

| Column | Description | Data Type | Notes |
| --- | --- | --- | --- |
| diffusion\_predictions | Predicted peptide sequence from InstaNovo+ | String | The refined peptide sequence from the diffusion |
| diffusion\_log\_probabilities | Log probability from InstaNovo+ | Float | Natural logarithm of the sequence confidence |
| diffusion\_token\_log\_probabilities | Token log probabilities from InstaNovo+ | List[Float] | Natural logarithm of the confidence for each token |
| diffusion\_unrefined\_predictions | Unrefined predictions from InstaNovo+ | String | Predictions before refinement |
| diffusion\_predictions\_beam\_0-4 | Predicted sequences from each beam | String | Beam search results when num\_beams > 1 |
| diffusion\_log\_probabilities\_beam\_0-4 | Log probabilities from each beam | Float | Confidence scores for each beam |

## Usage Notes

* When using InstaNovo+ with refinement, the `predictions` column contains the best prediction from the diffusion model.
* We recommend filtering the output based on the `diffusion_log_probabilities` and `delta_mass_ppm` columns to obtain a set of high-confidence predictions.
* Beam search columns (beam\_0 through beam\_4) are only present when running with `num_beams > 1`.
* The transformer model columns are prefixed with `instanovo_` and diffusion model columns are prefixed with `diffusion_`.

Back to top

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)