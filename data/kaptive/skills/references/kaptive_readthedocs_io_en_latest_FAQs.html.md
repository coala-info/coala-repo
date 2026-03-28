[Skip to main content](#main-content)

Back to top
[ ]

[ ]

`Ctrl`+`K`

[![Kaptive 3.1.0 documentation - Home](https://github.com/klebgenomics/Kaptive/blob/master/extras/kaptive_logo.png?raw=true)](index.html)

* [Introducing Kaptive 3](index.html)

* [Installation](Installation.html)
* [Usage](Usage.html)
* [Method](Method.html)
* [Outputs](Outputs.html)
* [Interpreting the results](Interpreting-the-results.html)
* [Databases](Databases.html)
* [Legacy Database Information](Legacy.html)
* FAQs

* [.rst](_sources/FAQs.rst "Download source file")
* .pdf

# FAQs

## Contents

* [Why do I have a large number of *Klebsiella* genomes with fragmented K loci?](#why-do-i-have-a-large-number-of-klebsiella-genomes-with-fragmented-k-loci)
* [Why does the *Klebsiella* K-locus region of my sample contain a *ugd* gene matching another locus?](#why-does-the-klebsiella-k-locus-region-of-my-sample-contain-a-ugd-gene-matching-another-locus)
* [Why are there locus genes found outside the locus?](#why-are-there-locus-genes-found-outside-the-locus)
* [Why has the best matching locus changed after I reran my analysis with Kaptive 3?](#why-has-the-best-matching-locus-changed-after-i-reran-my-analysis-with-kaptive-3)

# FAQs[#](#faqs "Link to this heading")

## Why do I have a large number of *Klebsiella* genomes with fragmented K loci?[#](#why-do-i-have-a-large-number-of-klebsiella-genomes-with-fragmented-k-loci "Link to this heading")

Unfortunately, the *Klebsiella* K-locus is a particularly difficult region of the genome to sequence due to its low GC content compared to the rest of the chromosome, which can result in assembly fragmentation. This is particularly evident for draft genomes assembled from Illumina data generated with the Nextera XT library prep kit. These read sets may have little or no read coverage of parts of the K-locus, meaning it is impossible to fully assemble it. Unlike preior versions of Kaptive, Kaptive 3 selects the `Best match locus` based on gene searches rather than full length locus matches. It requires a match to only 50% of the gene to count it for locus assignment.

## Why does the *Klebsiella* K-locus region of my sample contain a *ugd* gene matching another locus?[#](#why-does-the-klebsiella-k-locus-region-of-my-sample-contain-a-ugd-gene-matching-another-locus "Link to this heading")

A small number of the original *Klebsiella* K locus references are truncated, containing only a partial *ugd* sequence. The reference annotations for these loci do not include *ugd*, so are not identified by the ‘tblastn’ search. Instead <b>Kaptive</b> reports the closest match to the partial sequence (if it exceeds the 90% coverage threshold).

## Why are there locus genes found outside the locus?[#](#why-are-there-locus-genes-found-outside-the-locus "Link to this heading")

For *Klebsiella* K loci in particular, a number of the K-locus genes are orthologous to genes outside of the K-locus region of the genome. E.g the *Klebsiella* K-locus *man* and *rml* genes have orthologues in the LPS (lipopolysacharide) locus; so it is not unusual to find a small number of genes “outside” the locus.

However, if you have a large number of genes (>5) outside the locus it may mean that there is a problem with the locus match, or that your assembly is very fragmented or contaminated (contains more than one sample).

## Why has the best matching locus changed after I reran my analysis with Kaptive 3?[#](#why-has-the-best-matching-locus-changed-after-i-reran-my-analysis-with-kaptive-3 "Link to this heading")

Kpative 3 uses a gene wise search to select the best matching locus, whereas Kaptive 2 uses a full length locus search. While the full length locus search was highly accurate for macthing loci found in one or a small number of pieces in the query assembly, it was prone to errors when typing more fragmented loci (although these were generally marked with `Low` and `None` confidence and recommended to be excluded). The new algorithm implemented in Kaptive 3 is much more sensitive for typing fragmented loci and results in fewer incorrect assignments in our testing.

[previous

Legacy Database Information](Legacy.html "previous page")

Contents

* [Why do I have a large number of *Klebsiella* genomes with fragmented K loci?](#why-do-i-have-a-large-number-of-klebsiella-genomes-with-fragmented-k-loci)
* [Why does the *Klebsiella* K-locus region of my sample contain a *ugd* gene matching another locus?](#why-does-the-klebsiella-k-locus-region-of-my-sample-contain-a-ugd-gene-matching-another-locus)
* [Why are there locus genes found outside the locus?](#why-are-there-locus-genes-found-outside-the-locus)
* [Why has the best matching locus changed after I reran my analysis with Kaptive 3?](#why-has-the-best-matching-locus-changed-after-i-reran-my-analysis-with-kaptive-3)

By Tom Stanton

© Copyright 2025, Tom Stanton, Ryan Wick, Kathryn Holt, Kelly Wyres.