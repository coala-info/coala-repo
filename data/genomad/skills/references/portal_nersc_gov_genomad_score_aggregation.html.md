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
* [Frequently asked questions](faq.html)

Theory

* Hybrid classification framework and score aggregation
* [Marker-based classification features](marker_features.html)
* [Neural network-based classification](nn_classification.html)
* [Provirus identification](provirus_identification.html)
* [Taxonomic assignment of virus genomes](taxonomic_assignment.html)
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Hybrid classification framework and score aggregation[#](#hybrid-classification-framework-and-score-aggregation "Permalink to this heading")

geNomad employs a hybrid approach to plasmid and virus identification that combines a neural [network-based classifier](nn_classification.html), that dispenses alignments to reference databases, and a marker-based classifier, that classifies sequences based on the presence of [protein markers](marker_features.html) that are informative for classification.

![_images/score_aggregation_1.svg](_images/score_aggregation_1.svg)

To improve classification performance, geNomad capitalizes on the strengths of both models by aggregating their outputs into a single classification.

## Attention-based score aggregation[#](#attention-based-score-aggregation "Permalink to this heading")

The neural network-based and the marker-based classifiers use distinct and often complementary approaches to classify input sequences. By aggregating their outputs, geNomad can take advantage of both approaches and provide a better classification performance. This is achieved through an attention mechanism that consists of a linear model that weighs the branches based on the frequency of chromosome, plasmid, and virus markers in the input sequence.

![_images/score_aggregation_2.svg](_images/score_aggregation_2.svg)

The attention mechanism works in such a way that the contribution of the marker branch goes higher as the fraction of genes that are assigned to markers increases. Essentially, the branch aggregation gives more weight to the marker branch when it is more informative (i.e., when most of the genes encoded by the input sequence are assigned to markers) and relies more on the sequence branch when marker information is scarce.

![_images/score_aggregation_3.svg](_images/score_aggregation_3.svg)

[Next

Marker-based classification features](marker_features.html)
[Previous

Frequently asked questions](faq.html)

Copyright © 2023, Antonio Camargo

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Hybrid classification framework and score aggregation
  + [Attention-based score aggregation](#attention-based-score-aggregation)