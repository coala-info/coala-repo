[PyBEL
![Logo](../../_static/PyBEL-square-100.png)](../../index.html)

latest

Getting Started

* [Overview](../../introduction/overview.html)
* [Installation](../../introduction/installation.html)

Data Structure

* [Data Model](datamodel.html)
* Example Networks
* [Filters](filters.html)
* [Grouping](grouping.html)
* [Operations](operators.html)
* [Pipeline](pipeline.html)
* [Query](query.html)
* [Summary](summary.html)

Mutations

* [Mutations](../mutations/mutations.html)
* [Collapse](../mutations/collapse.html)
* [Deletion](../mutations/deletion.html)
* [Expansion](../mutations/expansion.html)
* [Induction](../mutations/induction.html)
* [Induction and Expansion](../mutations/induction_expansion.html)
* [Inference](../mutations/inference.html)
* [Metadata](../mutations/metadata.html)

Conversion

* [Input and Output](../io.html)

Database

* [Manager](../database/manager.html)
* [Models](../database/models.html)

Topic Guide

* [Cookbook](../../topics/cookbook.html)
* [Command Line Interface](../../topics/cli.html)

Reference

* [Constants](../constants.html)
* [Parsers](../parser.html)
* [Internal Domain Specific Language](../dsl.html)
* [Logging Messages](../logging.html)

Project

* [References](../../meta/references.html)
* [Current Issues](../../meta/postmortem.html)
* [Technology](../../meta/technology.html)

[PyBEL](../../index.html)

* »
* Example Networks
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/struct/examples.rst)

---

# Example Networks[](#module-pybel.examples "Permalink to this headline")

This directory contains example networks, precompiled as BEL graphs that are appropriate to use in examples.

An example describing EGF’s effect on cellular processes.

```
SET Citation = {"PubMed","Clin Cancer Res 2003 Jul 9(7) 2416-25","12855613"}
SET Evidence = "This induction was not seen either when LNCaP cells were treated with flutamide or conditioned medium were pretreated with antibody to the epidermal growth factor (EGF)"
SET Species = 9606

tscript(p(HGNC:AR)) increases p(HGNC:EGF)

UNSET ALL

SET Citation = {"PubMed","Int J Cancer 1998 Jul 3 77(1) 138-45","9639405"}
SET Evidence = "DU-145 cells treated with 5000 U/ml of IFNgamma and IFN alpha, both reduced EGF production with IFN gamma reduction more significant."
SET Species = 9606

p(HGNC:IFNA1) decreases p(HGNC:EGF)
p(HGNC:IFNG) decreases p(HGNC:EGF)

UNSET ALL

SET Citation = {"PubMed","DNA Cell Biol 2000 May 19(5) 253-63","10855792"}
SET Evidence = "Although found predominantly in the cytoplasm and, less abundantly, in the nucleus, VCP can be translocated from the nucleus after stimulation with epidermal growth factor."
SET Species = 9606

p(HGNC:EGF) increases tloc(p(HGNC:VCP), GO:nucleus, GO:cytoplasm)

UNSET ALL

SET Citation = {"PubMed","J Clin Oncol 2003 Feb 1 21(3) 447-52","12560433"}
SET Evidence = "Valosin-containing protein (VCP; also known as p97) has been shown to be associated with antiapoptotic function and metastasis via activation of the nuclear factor-kappaB signaling pathway."
SET Species = 9606

cat(p(HGNC:VCP)) increases tscript(complex(p(HGNC:NFKB1), p(HGNC:NFKB2), p(HGNC:REL), p(HGNC:RELA), p(HGNC:RELB)))
tscript(complex(p(HGNC:NFKB1), p(HGNC:NFKB2), p(HGNC:REL), p(HGNC:RELA), p(HGNC:RELB))) decreases bp(MESHPP:Apoptosis)

UNSET ALL
```

pybel.examples.egf\_graph[](#pybel.examples.egf_example.pybel.examples.egf_graph "Permalink to this definition")

Curation of the article “Genetics ignite focus on microglial inflammation in Alzheimer’s disease”.

```
SET Citation = {"PubMed", "26438529"}
SET Evidence = "Sialic acid binding activates CD33, resulting in phosphorylation of the CD33
immunoreceptor tyrosine-based inhibitory motif (ITIM) domains and activation of the SHP-1 and
SHP-2 tyrosine phosphatases [66, 67]."

complex(p(HGNC:CD33),a(CHEBI:"sialic acid")) -> p(HGNC:CD33, pmod(P))
act(p(HGNC:CD33, pmod(P))) => act(p(HGNC:PTPN6), ma(phos))
act(p(HGNC:CD33, pmod(P))) => act(p(HGNC:PTPN11), ma(phos))

UNSET {Evidence, Species}

SET Evidence = "These phosphatases act on multiple substrates, including Syk, to inhibit immune
activation [68, 69].  Hence, CD33 activation leads to increased SHP-1 and SHP-2 activity that antagonizes Syk,
inhibiting ITAM-signaling proteins, possibly including TREM2/DAP12 (Fig. 1, [70, 71])."

SET Species = 9606

act(p(HGNC:PTPN6)) =| act(p(HGNC:SYK))
act(p(HGNC:PTPN11)) =| act(p(HGNC:SYK))
act(p(HGNC:SYK)) -> act(p(HGNC:TREM2))
act(p(HGNC:SYK)) -> act(p(HGNC:TYROBP))

UNSET ALL
```

pybel.examples.sialic\_acid\_graph[](#pybel.examples.sialic_acid_example.pybel.examples.sialic_acid_graph "Permalink to this definition")

An example describing a single evidence about BRAF.

```
SET Citation = {"PubMed", "11283246"}
SET Evidence = "Expression of both dominant negative forms, RasN17 and Rap1N17, in UT7-Mpl cells decreased
thrombopoietin-mediated Elk1-dependent transcription. This suggests that both Ras and Rap1 contribute to
thrombopoietin-induced ELK1 transcription."

SET Species = 9606

p(HGNC:THPO) increases kin(p(HGNC:BRAF))
p(HGNC:THPO) increases kin(p(HGNC:RAF1))
kin(p(HGNC:BRAF)) increases tscript(p(HGNC:ELK1))

UNSET ALL
```

pybel.examples.braf\_example\_graph[](#pybel.examples.braf_example.pybel.examples.braf_example_graph "Permalink to this definition")

An example describing statins.

pybel.examples.statin\_graph[](#pybel.examples.statin_example.pybel.examples.statin_graph "Permalink to this definition")

An example describing a translocation.

```
SET Citation = {"PubMed", "16170185"}
SET Evidence = "These modifications render Ras functional and capable of localizing to the lipid-rich inner surface of the cell membrane. The first and most critical modification, farnesylation, which is principally catalyzed by protein FTase, adds a 15-carbon hydrobobic farnesyl isoprenyl tail to the carboxyl terminus of Ras."
SET TextLocation = Review

cat(complex(p(HGNC:FNTA),p(HGNC:FNTB))) directlyIncreases p(SFAM:"RAS Family",pmod(F))
p(SFAM:"RAS Family",pmod(F)) directlyIncreases tloc(p(SFAM:"RAS Family"),MESHCS:"Intracellular Space",MESHCS:"Cell Membrane")
```

pybel.examples.ras\_tloc\_graph[](#pybel.examples.tloc_example.pybel.examples.ras_tloc_graph "Permalink to this definition")

[Previous](datamodel.html "Data Model")
[Next](filters.html "Filters")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).