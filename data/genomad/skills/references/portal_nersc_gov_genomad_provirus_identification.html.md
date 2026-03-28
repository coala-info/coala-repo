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
* [Neural network-based classification](nn_classification.html)
* Provirus identification
* [Taxonomic assignment of virus genomes](taxonomic_assignment.html)
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Provirus identification[#](#provirus-identification "Permalink to this heading")

Temperate phages can integrate into host genomes and form proviruses, which can greatly affect the host metabolism and ecology. geNomad is able to estimate the coordinates of integrated proviruses within host sequences, providing valuable information to the user.

## Provirus demarcation algorithm[#](#provirus-demarcation-algorithm "Permalink to this heading")

geNomad’s marker dataset provides information on how specific each marker is to viruses or hosts (which you can read more about [here](marker_features.html)). To identify putative proviruses, geNomad identifies sequences that contain regions of virus-specific markers that surrounded by host-specific genes.

Therefore, the first step in the process is assigning the genes encoded by a given sequence to geNomad markers,

![_images/provirus_1.svg](_images/provirus_1.svg)

To demarcate regions that possibly correspond to proviruses, geNomad employs a conditional random field (CRF) model. This model takes into account the chromosome and virus SPM values of genes annotated with geNomad markers as input and uses contextual information to calculate the conditional probability of a sequence of states (either chromosome or provirus) in the sequence.

![_images/provirus_2.svg](_images/provirus_2.svg)

As a result, the CRF model provides, for each gene, a a probability of it belonging to a provirus.

![_images/provirus_3.svg](_images/provirus_3.svg)

Genes are then assigned to their most likely states, forming provirus islands that represent regions that are enriched in virus markers.

![_images/provirus_4.svg](_images/provirus_4.svg)

To prevent having proviruses split into multiple islands due to incomplete marker coverage, provirus islands that are separated by short gene arrays (less than 6 genes or 2 chromosome markers) are merged. Next, the total viral enrichment of each island is computed as follows:

\[\textrm{Total viral enrichment} = \sum \_{i=1}^ne^{\textrm{V SPM}\_i}-e^{\textrm{C SPM}\_i}\:\]

These values represent the total viral enrichment of the islands, taking into account all of the genes within them. Islands with several virus-specific markers will have higher marker enrichment, while islands with few virus-specific genes will have low marker enrichment.

![_images/provirus_5.svg](_images/provirus_5.svg)

After identifying viral islands, geNomad refines their boundaries using tRNA and integrase annotation. This is because tRNAs and integrases are often located next to integrated elements due to site-specific recombination dynamics. Therefore, geNomad extends the provirus boundaries to the neighboring tRNAs (identified using [`ARAGORN`](http://www.ansikte.se/ARAGORN/)) and/or integrases (identified with [`MMseqs2`](https://github.com/soedinglab/MMseqs2/), using a set of 16 profiles of site-specific tyrosine integrases). Finally, islands with low marker enrichment are filtered out as they are usually not *bona fide* proviruses.

![_images/provirus_6.svg](_images/provirus_6.svg)

[Next

Taxonomic assignment of virus genomes](taxonomic_assignment.html)
[Previous

Neural network-based classification](nn_classification.html)

Copyright © 2023, Antonio Camargo

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Provirus identification
  + [Provirus demarcation algorithm](#provirus-demarcation-algorithm)