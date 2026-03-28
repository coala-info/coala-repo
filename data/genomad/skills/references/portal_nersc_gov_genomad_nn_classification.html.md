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

* [Hybrid classification framework and score aggregation](score_aggregation.html)
* [Marker-based classification features](marker_features.html)
* Neural network-based classification
* [Provirus identification](provirus_identification.html)
* [Taxonomic assignment of virus genomes](taxonomic_assignment.html)
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Neural network-based classification[#](#neural-network-based-classification "Permalink to this heading")

Neural networks can be used to perform classification directly from nucleotide sequences, dispensing explicit alignments to reference genomes or proteins. This is possible because some neural network architectures are capable of learning discriminative sequence motifs that are informative for classification. In geNomad, a neural network-based classifier is used in conjunction with a marker-based classifier to improve classification of sequences with few or no genes assigned to markers.

## geNomad’s neural network classifier[#](#genomad-s-neural-network-classifier "Permalink to this heading")

To identify sequences of plasmids and viruses without explicit alignment to a reference database, geNomad processes inputs using a neural network model that is able to classify the sequences from their nucleotide makeup alone. To accomplish this, the input sequences are first converted to a numerical format by tokenizing them into arrays of 4-mer words, which are then one-hot-encoded, creating binary 256-dimensional matrices that reflect the presence of specific 4-mers (rows) across different positions within the sequence (columns).

![_images/nn_classification_1.svg](_images/nn_classification_1.svg)

These matrices are then passed to an encoder, which generates vector representations of the sequences in a high-dimensional embedding space. In this space, sequence representations from the same class (chromosome, plasmid, or virus) will be more similar compared to sequence representations from different classes. The resulting representations are subsequently fed to a dense neural network that produces the classification scores.

![_images/nn_classification_2.svg](_images/nn_classification_2.svg)

## The IGLOO architecture[#](#the-igloo-architecture "Permalink to this heading")

To generate vector representations of the inputs, geNomad employs an encoder based on the [IGLOO](https://arxiv.org/abs/1807.03402) architecture, which is able to extract patterns that are useful for classification from the sequence data and encode them into an embedding space. The IGLOO encoder begins processing one-hot-encoded matrices by applying convolutional filters to generate sequence feature maps. To capture relationships between non-contiguous parts of the sequence, IGLOO generates patches that contain slices taken from random positions within the sequence.

![_images/nn_classification_3.svg](_images/nn_classification_3.svg)

These patches are integrated into a self-attention mechanism that weights different parts of the feature map and uses the long-range dependencies encoded in the patches to derive the final sequence representation.

![_images/nn_classification_4.svg](_images/nn_classification_4.svg)

[Next

Provirus identification](provirus_identification.html)
[Previous

Marker-based classification features](marker_features.html)

Copyright © 2023, Antonio Camargo

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Neural network-based classification
  + [geNomad’s neural network classifier](#genomad-s-neural-network-classifier)
  + [The IGLOO architecture](#the-igloo-architecture)