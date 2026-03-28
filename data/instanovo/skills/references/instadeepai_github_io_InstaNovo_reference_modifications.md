[ ]
[ ]

[Skip to content](#reference-natively-supported-modifications)

[![logo](../../assets/instanovo_logo_square.svg)](../.. "InstaNovo")

InstaNovo

Supported Modifications

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
  + [ ]
    [Supported Modifications](./)
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

# Reference: Natively Supported Modifications

InstaNovo has been trained to recognize a set of common post-translational modifications (PTMs). This document lists the modifications that are natively supported by the pre-trained models.

| Amino Acid | Single Letter | Modification | Mass Delta (Da) | Unimod ID |
| --- | --- | --- | --- | --- |
| Methionine | M | Oxidation | +15.9949 | [UNIMOD:35](https://www.unimod.org/modifications_view.php?editid1=35) |
| Cysteine | C | Carboxyamidomethylation | +57.0215 | [UNIMOD:4](https://www.unimod.org/modifications_view.php?editid1=4) |
| Asparagine, Glutamine | N, Q | Deamidation | +0.9840 | [UNIMOD:7](https://www.unimod.org/modifications_view.php?editid1=7) |
| Serine, Threonine, Tyrosine | S, T, Y | Phosphorylation | +79.9663 | [UNIMOD:21](https://www.unimod.org/modifications_view.php?editid1=21) |
| N-terminal | - | Ammonia Loss | -17.0265 | [UNIMOD:385](https://www.unimod.org/modifications_view.php?editid1=385) |
| N-terminal | - | Carbamylation | +43.0058 | [UNIMOD:5](https://www.unimod.org/modifications_view.php?editid1=5) |
| N-terminal | - | Acetylation | +42.0106 | [UNIMOD:1](https://www.unimod.org/modifications_view.php?editid1=1) |

The residue configuration can be found in the [`instanovo/configs/residues/extended.yaml`](https://github.com/instadeepai/InstaNovo/blob/main/instanovo/configs/residues/extended.yaml) file.

Back to top

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)