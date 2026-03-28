[changeo
![Logo](_static/changeo.png)](index.html)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* [Overview](overview.html)
* [Download](install.html)
* [Installation](install.html#installation)
* [Contributing](contributing.html)
* Data Standards
  + [AIRR-C Format](#airr-c-format)
  + [Change-O Format](#change-o-format)
* [Release Notes](news.html)

Usage Documentation

* [Commandline Usage](usage.html)
* [API](api.html)

Examples

* [Using IgBLAST](examples/igblast.html)
* [Parsing IMGT output](examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](examples/10x.html)
* [Filtering records](examples/filtering.html)
* [Clustering sequences into clonal groups](examples/cloning.html)
* [Reconstructing germline sequences](examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](examples/genbank.html)

Methods

* [Clonal clustering methods](methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](methods/germlines.html)

About

* [Contact](info.html)
* [Citation](info.html#citation)
* [License](info.html#license)

[changeo](index.html)

* Data Standards
* [View page source](_sources/standard.rst.txt)

---

# Data Standards[](#data-standards "Link to this heading")

All Change-O tools supports both the legacy Change-O standard and the new
[Adaptive Immune Receptor Repertoire (AIRR)](https://docs.airr-community.org/en/stable/)
standard developed by the AIRR Community ([AIRR-C](https://www.antibodysociety.org/the-airr-community/)).

## AIRR-C Format[](#airr-c-format "Link to this heading")

As of v1.0.0, the default file format is the AIRR-C format as described by the
Rearrangement Schema (v1.2). The AIRR-C Rearrangement format is a tab-delimited
file format (`.tsv`) that defines the required and optional annotations for
rearranged adaptive immune receptor sequences.

To learn more about this format, the valid field names and their expected values, visit the AIRR-C
[Rearrangement Schema documentation site](https://docs.airr-community.org/en/stable/datarep/overview.html).

An API for the input and output of the AIRR-C format is provided in the
[AIRR Python package](https://docs.airr-community.org/en/stable/packages/airr-python/overview.html).
Wrappers for this package are provided in the API as [`changeo.IO.AIRRReader`](modules/IO.html#changeo.IO.AIRRReader "changeo.IO.AIRRReader")
and [`changeo.IO.AIRRWriter`](modules/IO.html#changeo.IO.AIRRWriter "changeo.IO.AIRRWriter").

## Change-O Format[](#change-o-format "Link to this heading")

The legacy Change-O standard is a tab-delimited file format (`.tab`) with a set
of predefined column names. The standardized column names used by the Change-O format
are shown in the table below. Most tools do not require every column. The columns
required by and added by each individual tool are described in the
[commandline usage](usage.html#usage) documentation. If a column contains multiple
entries, such as ambiguous V gene assignments, these nested entries are delimited
by commas. The ordering of the columns does not matter.

An API for the input and output of the Change-O format is provided in
[`changeo.IO.ChangeoReader`](modules/IO.html#changeo.IO.ChangeoReader "changeo.IO.ChangeoReader") and [`changeo.IO.ChangeoWriter`](modules/IO.html#changeo.IO.ChangeoWriter "changeo.IO.ChangeoWriter") respectively.

| Change-O Field | AIRR Field | Type | Description |
| --- | --- | --- | --- |
| **Standard Annotations** |  |  |  |
| SEQUENCE\_ID | sequence\_id | string | Unique sequence identifier |
| SEQUENCE\_INPUT | sequence | string | Input nucleotide sequence |
| SEQUENCE\_VDJ |  | string | V(D)J nucleotide sequence |
| SEQUENCE\_IMGT | sequence\_alignment | string | IMGT-numbered V(D)J nucleotide sequence |
| FUNCTIONAL | productive | logical | T: V(D)J sequence is predicted to be productive |
| IN\_FRAME | vj\_in\_frame | logical | T: junction region nucleotide sequence is in-frame |
| STOP | stop\_codon | logical | T: stop codon is present in V(D)J nucleotide sequence |
| MUTATED\_INVARIANT |  | logical | T: invariant amino acids properly encoded by V(D)J sequence |
| INDELS |  | logical | T: V(D)J nucleotide sequence contains insertions and/or deletions |
| LOCUS | locus | string | Locus of the receptor |
| V\_CALL | v\_call | string | V allele assignment(s) |
| D\_CALL | d\_call | string | D allele assignment(s) |
| J\_CALL | j\_call | string | J allele assignment(s) |
| C\_CALL | c\_call | string | C-region assignment |
| V\_SEQ\_START | v\_sequence\_start | integer | Position of first V nucleotide in SEQUENCE\_INPUT |
| V\_SEQ\_LENGTH |  | integer | Number of V nucleotides in SEQUENCE\_INPUT |
| V\_GERM\_START\_IMGT | v\_germline\_start | integer | Position of V\_SEQ\_START in IMGT-numbered germline V(D)J sequence |
| V\_GERM\_LENGTH\_IMGT |  | integer | Length of the IMGT numbered germline V alignment |
| NP1\_LENGTH | np1\_length | integer | Number of nucleotides between V and D segments |
| D\_SEQ\_START | d\_sequence\_start | integer | Position of first D nucleotide in SEQUENCE\_INPUT |
| D\_SEQ\_LENGTH |  | integer | Number of D nucleotides in SEQUENCE\_INPUT |
| D\_GERM\_START | d\_germline\_start | integer | Position of D\_SEQ\_START in germline V(D)J nucleotide sequence |
| D\_GERM\_LENGTH |  | integer | Length of the germline D alignment |
| NP2\_LENGTH | np2\_length | integer | Number of nucleotides between D and J segments |
| J\_SEQ\_START | j\_sequence\_start | integer | Position of first J nucleotide in SEQUENCE\_INPUT |
| J\_SEQ\_LENGTH | j\_sequence\_end | integer | Number of J nucleotides in SEQUENCE\_INPUT |
| J\_GERM\_START | j\_germline\_start | integer | Position of J\_SEQ\_START in germline V(D)J nucleotide sequence |
| J\_GERM\_LENGTH |  | integer | Length of the germline J alignment |
| JUNCTION\_LENGTH | junction\_length | integer | Number of junction nucleotides in SEQUENCE\_VDJ |
| JUNCTION | junction | string | Junction region nucletide sequence |
| CELL | cell\_id | string | Cell identifier |
| CLONE | clone\_id | string | Clonal grouping identifier |
| **Region Annotations** |  |  |  |
| FWR1\_IMGT | fwr1 | string | IMGT-numbered FWR1 nucleotide sequence |
| FWR2\_IMGT | fwr2 | string | IMGT-numbered FWR2 nucleotide sequence |
| FWR3\_IMGT | fwr3 | string | IMGT-numbered FWR3 nucleotide sequence |
| FWR4\_IMGT | fwr4 | string | IMGT-numbered FWR4 nucleotide sequence |
| CDR1\_IMGT | cdr1 | string | IMGT-numbered CDR1 nucleotide sequence |
| CDR2\_IMGT | cdr2 | string | IMGT-numbered CDR2 nucleotide sequence |
| CDR3\_IMGT | cdr3 | string | IMGT-numbered CDR3 nucleotide sequence |
| N1\_LENGTH | n1\_length | integer | Untemplated nucleotides 5’ of the D segment |
| N2\_LENGTH | n2\_length | integer | Untemplated Nucleotides 3’ of the D segment |
| P3V\_LENGTH | p3v\_length | integer | Palindromic nucleotides 3’ of the V segment |
| P5D\_LENGTH | p5d\_length | integer | Palindromic nucleotides 5’ of the D segment |
| P3D\_LENGTH | p3d\_length | integer | Palindromic nucleotides 3’ of the D segment |
| P5J\_LENGTH | p5j\_length | integer | Palindromic nucleotides 5’ of the J segment |
| D\_FRAME |  | integer | D segment reading frame |
| **Germline Annotations** |  |  |  |
| GERMLINE\_VDJ |  | string | Full unaligned germline V(D)J nucleotide sequence |
| GERMLINE\_VDJ\_V\_REGION |  | string | Unaligned germline V segment nucleotide sequence |
| GERMLINE\_VDJ\_D\_MASK |  | string | Unaligned germline V(D)J nucleotides sequence with Ns masking the NP1-D-NP2 regions |
| GERMLINE\_IMGT | germline\_alignment | string | Full IMGT-numbered germline V(D)J nucleotide sequence |
| GERMLINE\_IMGT\_V\_REGION |  | string | IMGT-numbered germline V segment nucleotide sequence |
| GERMLINE\_IMGT\_D\_MASK |  | string | IMGT-numbered germline V(D)J nucleotide sequence with Ns masking the NP1-D-NP2 regions |
| GERMLINE\_V\_CALL |  | string | Clonal consensus germline V assignment |
| GERMLINE\_D\_CALL |  | string | Clonal consensus germline D assignment |
| GERMLINE\_J\_CALL |  | string | Clonal consensus germline J assignment |
| GERMLINE\_REGIONS |  | string | String showing germline segments positions encoded as V, D, J, N, and P characters |
| **Alignment Annotations** |  |  |  |
| V\_SCORE | v\_score | float | Alignment score for the V |
| V\_IDENTITY | v\_identity | float | Alignment identity for the V |
| V\_EVALUE | v\_support | float | E-value for the alignment of the V |
| V\_CIGAR | v\_cigar | string | CIGAR string for the alignment of the V |
| D\_SCORE | d\_score | float | Alignment score for the D |
| D\_IDENTITY | d\_identity | float | Alignment identity for the D |
| D\_EVALUE | d\_support | float | E-value for the alignment of the D |
| D\_CIGAR | d\_cigar | string | CIGAR string for the alignment of the D |
| J\_SCORE | j\_score | float | Alignment score for the J |
| J\_IDENTITY | j\_identity | float | Alignment identity for the J |
| J\_EVALUE | j\_support | float | E-value for the alignment of the J |
| J\_CIGAR | j\_cigar | string | CIGAR string for the alignment of the J |
| VDJ\_SCORE |  | float | Alignment score for the V(D)J |
| **TIgGER Annotations** |  |  |  |
| V\_CALL\_GENOTYPED |  | string | Adjusted V allele assignment(s) following TIgGER genotype inference |
| **Preprocessing Annotations** |  |  |  |
| PRCONS |  | string | pRESTO UMI consensus primer |
| PRIMER |  | string | pRESTO primers list |
| CONSCOUNT | consensus\_count | integer | Number of reads contributing to the UMI consensus sequence |
| DUPCOUNT | duplicate\_count | integer | Copy number of the sequence |
| UMICOUNT |  | integer | UMI count for the sequence |

[Previous](contributing.html "Contributing")
[Next](news.html "Release Notes")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).