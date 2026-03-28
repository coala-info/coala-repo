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
* [Provirus identification](provirus_identification.html)
* Taxonomic assignment of virus genomes
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Taxonomic assignment of virus genomes[#](#taxonomic-assignment-of-virus-genomes "Permalink to this heading")

geNomad is able to assign viral genomes to taxonomic lineages defined in [ICTV’s VMR number 19](https://talk.ictvonline.org/taxonomy/vmr/m/vmr-file-repository/13426). This is allowed by the 85,315 markers that are associated with viral taxa that cover most of the lineages recognized by the [ICTV](https://talk.ictvonline.org/).

## Taxonomic assignment algorithm[#](#taxonomic-assignment-algorithm "Permalink to this heading")

To assign viral sequences to specific taxa, geNomad first aligns the genes encoded by the sequences to a set of 227,897 markers. The genes that produce significant matches are then assigned to a marker, which might contain taxonomic information (colored genes below).

![_images/taxonomic_assignment_1.svg](_images/taxonomic_assignment_1.svg)

Each gene is subsequently classified based on the taxonomic lineage of the assigned marker. Different genes within the sequence might be assigned to different lineages.

[![_images/taxonomic_assignment_2.svg](_images/taxonomic_assignment_2.svg)](_images/taxonomic_assignment_2.svg)

To establish a single sequence-level taxonomy, weights are computed for each taxon included among the gene-level assignments, as well as their parent taxa (up to the root of the taxonomy) by summing the bitscores obtained from the alignments with marker profiles.

[![_images/taxonomic_assignment_3.svg](_images/taxonomic_assignment_3.svg)](_images/taxonomic_assignment_3.svg)

The taxonomy of the sequence is determined as the most specific taxon that is supported by at least 50% of the total weight (sum of the bitscores of all genes with taxonomy). In the example above, both families (*Autographiviridae* and *Zobellviridae*) failed to reach 50% consensus, so the genome is assigned to the class *Caudoviricetes*.

**Final classification:** *Duplodnaviria;Heunggongvirae;Uroviricota;Caudoviricetes*.

[Next

Score calibration](score_calibration.html)
[Previous

Provirus identification](provirus_identification.html)

Copyright © 2023, Antonio Camargo

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Taxonomic assignment of virus genomes
  + [Taxonomic assignment algorithm](#taxonomic-assignment-algorithm)