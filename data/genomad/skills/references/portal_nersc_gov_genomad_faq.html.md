Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

Toggle site navigation sidebar

[geNomad](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[![Light Logo](_static/figures/logo_light.svg)
![Dark Logo](_static/figures/logo_light.svg)](index.html)

* [geNomad](index.html)

Using geNomad

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [The geNomad pipeline](pipeline.html)
* Frequently asked questions

Theory

* [Hybrid classification framework and score aggregation](score_aggregation.html)
* [Marker-based classification features](marker_features.html)
* [Neural network-based classification](nn_classification.html)
* [Provirus identification](provirus_identification.html)
* [Taxonomic assignment of virus genomes](taxonomic_assignment.html)
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Frequently asked questions[#](#frequently-asked-questions "Permalink to this heading")

Here you will find answers to some common questions about geNomad. If you can’t find an answer to your problem here, please open an issue in the  [GitHub repository](https://github.com/apcamargo/genomad/).

## How can I speed up geNomad?[#](#how-can-i-speed-up-genomad "Permalink to this heading")

If you want to speed up the execution of geNomad, there are two options available:

* Disable the [neural network-based classification](nn_classification.html) using the `--disable-nn-classification` option, which will also disable [score aggregation](score_aggregation.html) and force geNomad to solely rely on the marker-based classifier.
* Decrease the sensitivity of the MMseqs2 search that assigns markers to genes with the `--sensitivity` parameter. This will make the [`annotate`](pipeline.html#annotate-module) module faster, but will also decrease the number of genes assigned to markers.

Please note that both options may negatively impact geNomad’s classification performance.

## How can I get the taxonomy of all my sequences, regardless of their classification?[#](#how-can-i-get-the-taxonomy-of-all-my-sequences-regardless-of-their-classification "Permalink to this heading")

If you are only interested in performing taxonomic assignment of viral genomes and not classification of the sequences, you can run the [`annotate`](pipeline.html#annotate-module) module alone using the following command:

```
genomad annotate input.fna genomad_output genomad_db
```

The taxonomic assignment of your sequences will be in the `genomad_output/input_annotate/input_taxonomy.tsv` file. Please note that the path may vary depending on the name of your input file, but the structure will remain consistent.

## Why is the execution is stuck at the *“Classifying sequences”* step of the `nn-classification` module?[#](#why-is-the-execution-is-stuck-at-the-classifying-sequences-step-of-the-nn-classification-module "Permalink to this heading")

During the [neural network-based classification](nn_classification.html) of sequences, the processor performs numerous computationally expensive matrix multiplications. Although modern processors can handle these computations quickly, some hardware, particularly older or laptop processors, can be quite slow during this step.

If you ran geNomad using the `end-to-end` command and your execution is stuck at the *“Classifying sequences”* step of the [`nn-classification`](pipeline.html#nn-classification-module) module, you can disable the neural network classifier by using the `--disable-nn-classification` option. By doing this, geNomad will rely solely on marker-based classification and disable [score aggregation](score_aggregation.html).

## Why execution is failing at the *“Annotating proteins with MMseqs2…”* step of the `annotate` module?[#](#why-execution-is-failing-at-the-annotating-proteins-with-mmseqs2-step-of-the-annotate-module "Permalink to this heading")

If geNomad fails during the *“Annotating proteins with MMseqs2 and geNomad database”* step, it is likely that your computer is running out of memory. This can be resolved by using the[`--splits`](quickstart.html#notes-about-parameters) parameter, which splits the marker database into smaller chuncks and searches each of them independently.

[Next

Hybrid classification framework and score aggregation](score_aggregation.html)
[Previous

The geNomad pipeline](pipeline.html)

Copyright © 2023, Antonio Camargo

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Frequently asked questions
  + [How can I speed up geNomad?](#how-can-i-speed-up-genomad)
  + [How can I get the taxonomy of all my sequences, regardless of their classification?](#how-can-i-get-the-taxonomy-of-all-my-sequences-regardless-of-their-classification)
  + [Why is the execution is stuck at the *“Classifying sequences”* step of the `nn-classification` module?](#why-is-the-execution-is-stuck-at-the-classifying-sequences-step-of-the-nn-classification-module)
  + [Why execution is failing at the *“Annotating proteins with MMseqs2…”* step of the `annotate` module?](#why-execution-is-failing-at-the-annotating-proteins-with-mmseqs2-step-of-the-annotate-module)