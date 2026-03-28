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
* Interpreting the results
* [Databases](Databases.html)
* [Legacy Database Information](Legacy.html)
* [FAQs](FAQs.html)

* [.rst](_sources/Interpreting-the-results.rst "Download source file")
* .pdf

# Interpreting the results

## Contents

* [Confidence score](#confidence-score)
  + [Typeable loci](#typeable-loci)
  + [Untypeable loci](#untypeable-loci)
* [Problems](#problems)
* [Exploring the other columns](#exploring-the-other-columns)

# Interpreting the results[#](#interpreting-the-results "Link to this heading")

The four most important columns in the Kaptive [tabular](Outputs.html#tabular) output:

* `Best match locus` indicating the locus that is best supported by the available sequence data
* `Best match type` indicating the predicted phenotype based on that associated with the `Best match locus` and taking into account any special phenotype logic e.g. where a known essential gene is truncated, Kaptive will report the `Best match type` as ‘Capsule null’.
* `Match confidence` indicates a qualitative level of confidence that the reported `Best match locus` is correct (see below).
* `Problems` indicates the features of the assembly locus that may impact `Match confidence`

Note

The `Match confidence` relates to the locus match, and is not a direct indication of confidence in the `Best match type`.

## Confidence score[#](#confidence-score "Link to this heading")

Kaptive will indicate the best matching locus and its confidence in the locus match. The critera mentioned below
can be tweaked using the [confidence options](Usage.html#confidence-options).

### Typeable loci[#](#typeable-loci "Link to this heading")

The locus was found in a single piece in the query assembly with no genes below the minimum translated identity
according to the [locus thresholds](Databases.html#locus-definition) and:

* no missing genes
* no (non-truncated) unexpected genes (genes from other loci) inside the locus region of the assembly

**OR**

The locus was found in more than one piece in the query assembly with no genes below the minimum translated identity
according to the [locus thresholds](Databases.html#locus-definition) and:

* no less than N% missing genes (default: 50%)
* no more than N unexpected gene (genes from other loci) inside the locus region of the assembly (default: 1)

These criteria were designed in consideration of the locus definition rules (i.e. that each locus represents a unique set of genes defined at a given minimum translated identity threshold) and following systematic analysis of Kaptive outputs for draft genome assemblies compared against manually confirmed loci determined from matched completed genomes.

We allow some flexibility with regards to missing genes or additional genes found within the locus when this region of the query assembly is fragmented, because it can be difficult to distinguish genuine from spurious matches for fragmented genes. Fragmentation is common among *K. pneumoniae* K loci, particularly when the genomes were sequenced using the Illumina technology with the Illumina XT library prep (see [FAQs](FAQs.html#fragmented-klebs-faq) for more details).

### Untypeable loci[#](#untypeable-loci "Link to this heading")

These are loci that do not meet the above criteria. **We recommend that users do not accept these results** unless
they are able to perform manual exploration of the data.

## Problems[#](#problems "Link to this heading")

* `?` = the match was in a multiple pieces, possibly due to a poor match or discontiguous assembly. The number of pieces is indicated by the integer directly following the `?` symbol).
* `-` = genes expected in the locus were not found.
* `+` = extra genes were found in the locus.
* `*` = one or more expected genes was found but with translated identity below the minimum threshold.
* `!` = one or more genes was found but truncated.

## Exploring the other columns[#](#exploring-the-other-columns "Link to this heading")

Many users will not want or need to look beyond the columns described above. However, the rest of the Kaptive output may be useful for those wishing to investigate loci marked with `Problems` or explore locus variation in more detail. Interesting features include:

* Missing genes may indicate a novel locus or deletion variant is present in the assembly
* Length discrepencies can indicate a novel locus or deletion variant is present in the assembly. For *Klebsiella* K loci, positive length discrepencies of >700bp often indicate insertion sequence insertions resulting in so called ‘IS variants’ of the locus.
* Other genes inside the locus may indicate a novel locus (with some exceptions, see the [FAQs](FAQs.html#extra-genes-faq))
* Truncated genes may have an impact on the resultant phenotype. Kaptive will consider truncations when reporting predicting phenotypes, but it currenetly considers only gene truncations for which there is good supporting evidence in the literature, and such evidence is very limited.

See the [tutorials](https://klebnet.org/training/) for our tips on investigating loci in more detail outside of Kaptive.

[previous

Outputs](Outputs.html "previous page")
[next

Databases](Databases.html "next page")

Contents

* [Confidence score](#confidence-score)
  + [Typeable loci](#typeable-loci)
  + [Untypeable loci](#untypeable-loci)
* [Problems](#problems)
* [Exploring the other columns](#exploring-the-other-columns)

By Tom Stanton

© Copyright 2025, Tom Stanton, Ryan Wick, Kathryn Holt, Kelly Wyres.