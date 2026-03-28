[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[![](../../_static/logo.png)
![](../../_static/logo.png)

CHAMOIS](../../index.html)

* [User Guide](../../guide/index.html)
* [Examples](../../examples/index.html)
* [Figures](../../figures/index.html)
* [CLI Reference](../../cli/index.html)
* [API Reference](../index.html)
* More
  + [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Search
`Ctrl`+`K`

* [User Guide](../../guide/index.html)
* [Examples](../../examples/index.html)
* [Figures](../../figures/index.html)
* [CLI Reference](../../cli/index.html)
* [API Reference](../index.html)
* [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Section Navigation

* [Object model (`chamois.model`)](../model/index.html)
  + [Cluster Sequence](../model/cluster_sequence.html)
  + [Protein](../model/protein.html)
  + [Domain](../model/domain.html)
* ORF detection (`chamois.orf`)
  + [ORF Finder](orf_finder.html)
  + [Warnings](warnings.html)
* [Domain annotation (`chamois.domains`)](../domains/index.html)
  + [Domain Annotator](../domains/domain_annotator.html)
* [Compositions (`chamois.compositions`)](../compositions/index.html)
  + [Compositions](../compositions/compositions.html)
* [Ontology (`chamois.ontology`)](../ontology/index.html)
  + [Ontology](../ontology/ontology.html)
  + [Adjacency Matrix](../ontology/adjacency.html)
* [Predictor (`chamois.predictor`)](../predictor/index.html)
  + [Chemical Ontology Predictor](../predictor/predictor.html)
  + [Information-theoric Metrics](../predictor/information.html)
* [ClassyFire (`chamois.classyfire`)](../classyfire/index.html)
  + [Term](../classyfire/term.html)
  + [Classification](../classyfire/classification.html)
  + [Query](../classyfire/query.html)
  + [Cache](../classyfire/cache.html)
  + [Client](../classyfire/client.html)
  + [Utils](../classyfire/utils.html)

* [API Reference](../index.html)
* ORF detection (`chamois.orf`)

# ORF detection ([`chamois.orf`](#module-chamois.orf "chamois.orf"))[#](#module-chamois.orf "Link to this heading")

Generic protocol for ORF detection in DNA sequences.

## ORF Finder[#](#orf-finder "Link to this heading")

|  |  |
| --- | --- |
| [`ORFFinder`](orf_finder.html#chamois.orf.ORFFinder "chamois.orf.ORFFinder") | An abstract base class to provide a generic ORF finder. |
| [`PyrodigalFinder`](orf_finder.html#chamois.orf.PyrodigalFinder "chamois.orf.PyrodigalFinder") | An [`ORFFinder`](orf_finder.html#chamois.orf.ORFFinder "chamois.orf.ORFFinder") that uses the `pyrodigal` bindings to Prodigal. |
| [`CDSFinder`](orf_finder.html#chamois.orf.CDSFinder "chamois.orf.CDSFinder") | An [`ORFFinder`](orf_finder.html#chamois.orf.ORFFinder "chamois.orf.ORFFinder") that simply extracts CDS annotations from records. |

## Warnings[#](#warnings "Link to this heading")

|  |  |
| --- | --- |
| [`NoGeneFoundWarning`](warnings.html#chamois.orf.NoGeneFoundWarning "chamois.orf.NoGeneFoundWarning") | A warning for when no genes were found in a record. |
| [`IncompleteGeneWarning`](warnings.html#chamois.orf.IncompleteGeneWarning "chamois.orf.IncompleteGeneWarning") | A warning for when a gene was found with incomplete sequence. |

[previous

Domain](../model/domain.html "previous page")
[next

ORF Finder](orf_finder.html "next page")

On this page

* [ORF Finder](#orf-finder)
* [Warnings](#warnings)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/api/orf/index.rst)

### This Page

* [Show Source](../../_sources/api/orf/index.rst.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.