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
* Databases
* [Legacy Database Information](Legacy.html)
* [FAQs](FAQs.html)

* [.rst](_sources/Databases.rst "Download source file")
* .pdf

# Databases

## Contents

* [What is a locus?](#what-is-a-locus)
* [Format](#format)
  + [Genbank file](#genbank-file)
    - [Nomenclature](#nomenclature)
  + [Phenotype logic](#phenotype-logic)
* [Databases distributed with Kaptive](#databases-distributed-with-kaptive)
  + [*Klebsiella* K locus databases](#klebsiella-k-locus-databases)
  + [*Klebsiella* O locus database](#klebsiella-o-locus-database)
  + [*Acinetobacter baunannii* K and OC locus databases](#acinetobacter-baunannii-k-and-oc-locus-databases)
  + [Database keywords](#database-keywords)
* [Extract](#extract)
  + [Usage](#usage)

# Databases[#](#databases "Link to this heading")

## What is a locus?[#](#what-is-a-locus "Link to this heading")

A locus in the Kaptive sense refers to a biosynthetic gene cluster that is responsible for the synthesis of a bacterial surface
polysaccharide, e.g. the *Klebsiella pneumoniae* K locus is responsible for the synthesis of the capsular polysaccharide, also known as the K antigen.
Each locus in the Kaptive databases has been defined based on a unique set of genes, with the assumption that this
encodes a unique polysaccharide structure. In many cases, these unique structures will result in unique immunological serotypes.

The gene translations (protein sequences) from each locus are compared by pairwise alignment, and must fall under a
defined percent identity threshold to be considered ‘unique’. Some genes (such as the core assembly machinery) will
be highly similar, however the genes responsible for the polysaccharide structural diversity are expected to be more variable. The specific identity thresholds vary across species. The thresholds corresponding to the databases distributed with Kaptive are as follows:

| Species | Pairwise protein identity threshold |
| --- | --- |
| *Klebsiella pneumoniae* | 82.5% |
| *Acinetobacter baumannii* | 85% |

## Format[#](#format "Link to this heading")

### Genbank file[#](#genbank-file "Link to this heading")

Kaptive stores databases in Genbank format consisting of **unique** loci each with a single record with the following
requirements:

* The `source` feature must contain a `note` qualifier which begins with a label such as `K locus:`.
  Whatever follows is used as the locus name reported in the Kaptive output. The label is automatically determined,
  and any consistent label ending in a colon will work. However, the user can specify exactly which label to use with
  `--locus_label`, if desired.
* The `source` feature may optionally contain a `note` qualifier which begins with a label such as
  `K type:` that specifies the serotype (phenotype) associated with the locus (is known). In cases where only some loci
  are associated with known serotypes we recommend adding a `note` such as `K type: unknown`. If no `type` notes
  are specified for any loci, the Kaptive will list them as `unknown` in the output. (Kaptive v2.0+)
* Any locus gene should be annotated as `CDS` features. All `CDS` features will be used and any other type of
  feature will be ignored.
* If the gene has a name, it should be specified in a `gene` qualifier. This is not required for Kaptive to run, but if absent the gene
  will only be named using its numbered position in the locus and it will not be checked for any specific sequence
  variations relevant to [phenotype prediction](#phenotype-logic).

Example piece of input Genbank file:

```
source          1..23877
                /organism="Klebsiella pneumoniae"
                /mol_type="genomic DNA"
                /note="K locus: KL1"
                /note="K type: K1"
CDS             1..897
                /gene="galF"
```

#### Nomenclature[#](#nomenclature "Link to this heading")

In constructing the databases included with Kaptive, we have used the following nomenclature rules:

* Loci are named after their respective antigen (**K**, **O**, or **OC**) followed by the letter **L** (which
  stands for **Locus**), which separates the label for the genotype from the phenotype (e.g. KL1 -> K1). These
  letters should be in upper case.
* Loci are numbered, first, by their corresponding antigen, and second, in the order in which they were discovered.
  For example, *Klebsiella* K-loci 1-79 correspond to K-types 1-79. K-loci 101 and greater correspond to K-loci with
  unknown antigens in the order in which they were discovered. We intentionally started at 101 to leave room to assign
  phenotype-genotype pairs.
* Locus genes are named in three parts delimited by an **underscore** (**\_**):

  1. The locus the gene belongs to, e.g. `KL1_` for a gene in the `KL1` locus.
  2. The position of the gene in the locus, e.g. `KL1_01` for the first gene in the `KL1` locus.
  3. The name of the gene as a three-letter italicized symbol written in lower case letters and usually suffixed with
     an italicized capital letter, e.g. `KL1_01_galF` for the *galF* gene in the `KL1` locus.
     If the gene name is unknown, this part will be blank and the gene instead would be called `KL1_01`.

Note

Databases **must** follow this nomenclature system for distribution within Kaptive.

### Phenotype logic[#](#phenotype-logic "Link to this heading")

Phenotype logic (previously called “special logic”) is a set of rules that Kaptive uses to predict the polysaccharide phenotype
based on the genes it finds. This was initially implemented for the *Klebsiella pneumoniae* O locus, whereby additional
genes outside of the locus are used to predict the O antigen (sub)type. This logic was extended to the *A. baumannii*
K locus in Kaptive v2.0.2.

In Kaptive 3, we thought about how we could extend this given what we know about truncations or other sequence variations
of specific genes in the locus and the impact on the phenotype. For example, in the *Klebsiella pneumoniae* K locus,
we know that a truncation of the core initiating glycosyltransferase (*wcaJ*) results in a capsule-null phenotype.

The relevant sequence variations are detailed in the database logic files, each lablled with the same file prefix as its
resppective locus database, and marked with the extension `.logic`. Each line consists of three tab-separated columns
and represents a phenotype rule:

1. **loci** - the loci the rule applies to (or *ALL* if the rule applies to all loci in the database)
2. **genes** - the genes (and optional state) the rule applies to (or *ALL* if the rule applies to all genes in the locus)
3. **phenotype** - the resulting phenotype that appears in the Type column of the Kaptive tabular output, replacing
   the default phenotype i.e. the one specified in the locus genbank source identifier in the matching locus database.

Let’s look at an example of a logic file for the *K. pneumoniae* K locus:

| loci | genes | phenotype |
| --- | --- | --- |
| ALL | wcaJ,truncated | Capsule null |
| KL22 | KL22\_17,truncated | K37 |

In the first line, you can see that if *wcaJ* is truncated in any locus (selected with *ALL*), the phenotype will be
predicted as ‘Capsule null’. Here, any gene with the name *wcaJ* will be considered, and the state of the gene is
specified as *truncated*. In the last line, you can see that if *KL22\_17* (acetyl-transferase) is truncated in locus
KL22, the phenotype is predicted as ‘K37’, the non-acetylated version of the K22 capsule.

Note

The gene name and state are delimited by a comma.

Note

The default phenotype is the “type” label in the Genbank record (e.g. K1).

Let’s look at an example that uses extra genes outside of the locus (from the *K. pneumoniae* O locus database):

| loci | genes | phenotype |
| --- | --- | --- |
| OL2α.1;OL2α.2;OL2α.3 | orf8 | O2αγ |

Here, the first line states that if *orf8* is present in a genome carrying any of the OL2α.1, OL2α.2 or OL2α.3 loci,
the phenotype will be predicted as ‘O2αγ’.

Note

Each specific locus and gene is delimited by a semicolon.

Note

Default state is ‘presence’.

This logic is applied during the [phenotype prediction](Method.html#phenotype-prediction) step of typing and is reported in
the Type column of the Kaptive tabular output.

## Databases distributed with Kaptive[#](#databases-distributed-with-kaptive "Link to this heading")

Kaptive is distributed with databases for detection of *Klebsiella pneumoniae* species complex and *Acinetobacter baumanii* surface antigen synthesis loci in the [reference\_database](https://github.com/katholt/Kaptive/tree/master/reference_database) directory, (see details below). You can also generate your own databases for use with Kaptive by following these guidelines.

The existing databases were developed and curated by [Kelly Wyres](https://holtlab.net/kelly-wyres/) (*Klebsiella*)
and [Johanna Kenyon](https://research.qut.edu.au/infectionandimmunity/projects/bacterial-polysaccharide-research/)
(*A. baumannii*).

A third-party Kaptive database is available for *Vibrio parahaemolyticus* [K and O loci](https://github.com/aldertzomer/vibrio_parahaemolyticus_genomoserotyping),
created by Aldert Zomer and team (see [preprint](https://doi.org/10.1101/2021.07.06.451262)).
The database can be [downloaded](https://github.com/aldertzomer/vibrio_parahaemolyticus_genomoserotyping) and
used as input to command-line Kaptive, it is also available in the online tool [Kaptive-Web](https://kaptive-web.erc.monash.edu/)
along with our *Klebsiella* and *A. baumannii* databases.

We are always keen to expand the utility of Kaptive for the research community, so if you have created a database that you feel will be useful for others and you are willing to share this resource, please get in touch via the
[issues page](https://github.com/katholt/Kaptive/issues) or email.

Similarly, if you have identified new locus variants not currently in the existing databases, please let us know!

### *Klebsiella* K locus databases[#](#klebsiella-k-locus-databases "Link to this heading")

The *Klebsiella* K locus primary reference database (`Klebsiella_k_locus_primary_reference.gbk`) comprises full-length
(*galF* to *ugd*) annotated sequences for each distinct *Klebsiella* K locus, where available:

* KL1 - KL77 correspond to the loci associated with each of the 77 serologically defined K-type references, for which
  the corresponding predicted serotypes are K1-K77, respectively.
* KL101 and above are defined from DNA sequence data on the basis of gene content, and are not currently associated with
  any defined serotypes.

Note

Insertion sequences (IS) are excluded from this database since we assume that the ancestral sequence was
likely IS-free and IS transposase genes are not specific to the K locus.

Synthetic IS-free K locus sequences were generated for K loci for which no naturally occurring IS-free variants have
been identified to date.

Note

KL156-D1 is included in the primary reference database since no full-length version of this locus has been
identified to date.

We recommend screening your data with the primary reference database first to find the best-matching K locus. If you
have poor matches or are particularly interested in detecting variant loci you should try the variant database.

Warning

The variants database (`Klebsiella_k_locus_variant_reference.gbk`) has been retired as of `v3.0.0b6` as it’s no
longer actively maintained and results can be misleading without additional in depth analysis.

Database versions:

* Kaptive releases v0.5.1 and below include the original *Klebsiella* K locus databases, as described in
  [Wyres, K. et al. Microbial Genomics 2016.](http://mgen.microbiologyresearch.org/content/journal/mgen/10.1099/mgen.0.000102)
* Kaptive v0.6.0 and above include four novel primary *Klebsiella* K locus references defined on the basis of gene
  content (KL162-KL165) in [Wyres et al. Genome Medicine 2020](https://pubmed.ncbi.nlm.nih.gov/31948471/).
* Kaptive v0.7.1 and above contain updated versions of the KL53 and KL126 loci (see table below for details).
  The updated KL126 locus sequence is described in [McDougall, F. et al. Research in Microbiology 2021](https://pubmed.ncbi.nlm.nih.gov/34506927/).
* Kaptive v0.7.2 and above include a novel primary *Klebsiella* K locus reference defined on the basis of gene content
  (KL166), described in [Le, MN. et al. Microbial Genomics 2022](https://www.microbiologyresearch.org/content/journal/mgen/10.1099/mgen.0.000827).
* Kaptive v0.7.3 and above include four novel primary *Klebsiella* K locus references defined on the basis of gene
  content (KL167-KL170), described in [Gorrie, C. et al. Nature Communications 2022.](https://www.nature.com/articles/s41467-022-30717-6)
* Kaptive v2.0 and above include 16 novel primary *Klebsiella* K locus references defined on the basis of gene content
  (KL171-KL186) and described in [Lam, M.M.C et al. Microbial Genomics 2022.](https://doi.org/10.1099/mgen.0.000800)

Changes to the *Klebsiella* K locus primary reference database:

| Locus | Change | Reason | Date of change | Kaptive version no. |
| --- | --- | --- | --- | --- |
| KL53 | Annotation update: *wcaJ* changed to *wbaP* | Error in original annotation | 21 July 2020 | v 0.7.1 |
| KL126 | Sequence update: new sequence from isolate FF923 includes *rmlBADC* genes between *gnd* and *ugd* | Assembly scaffolding error in original sequence from isolate A-003-I-a-1 | 21 July 2020 | v 0.7.1 |
| KL37 | Removed from the database | Locus is a deletion (atr) variant of KL22 | 22 March 2024 | v 3.0.0 |

### *Klebsiella* O locus database[#](#klebsiella-o-locus-database "Link to this heading")

In Kaptive 3.1.0, we introduced new O-antigen nomenclature in the *Klebsiella* O locus database
(`Klebsiella_o_locus_primary_reference.gbk`) along wth the publication of this review:
[O-antigen polysaccharides in Klebsiella pneumoniae: structures and molecular basis for antigenic diversity](https://journals.asm.org/doi/full/10.1128/mmbr.00090-23#T1).

We have also summarised the O-antigen nomenclature update on the
[Wyres Lab website](http://wyreslab.com/klebsiella-pneumoniae-o-antigen-genetics-structural-diversity-and-nomenclature/).

The *Klebsiella* O locus database (`Klebsiella_o_locus_primary_reference.gbk`) contains annotated sequences for 13
distinct *Klebsiella* O loci.

O locus classification requires some special logic, as the O1 and O2 serotypes are associated with the same loci and
the distinction between O1 and each of the defined O2 subtypes (2α, 2β, 2γ) is determined by the
presence/absence of ‘extra genes’ (gml