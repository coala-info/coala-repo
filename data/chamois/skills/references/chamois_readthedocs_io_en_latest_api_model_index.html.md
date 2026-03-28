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

* Object model (`chamois.model`)
  + [Cluster Sequence](cluster_sequence.html)
  + [Protein](protein.html)
  + [Domain](domain.html)
* [ORF detection (`chamois.orf`)](../orf/index.html)
  + [ORF Finder](../orf/orf_finder.html)
  + [Warnings](../orf/warnings.html)
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
* Object model (`chamois.model`)

# Object model ([`chamois.model`](#module-chamois.model "chamois.model"))[#](#module-chamois.model "Link to this heading")

Object model for representing genomic regions in CHAMOIS.

## Cluster Sequence[#](#cluster-sequence "Link to this heading")

|  |  |
| --- | --- |
| [`ClusterSequence`](cluster_sequence.html#chamois.model.ClusterSequence "chamois.model.ClusterSequence") | The sequence of a biosynthetic gene cluster. |

## Protein[#](#protein "Link to this heading")

|  |  |
| --- | --- |
| [`Protein`](protein.html#chamois.model.Protein "chamois.model.Protein") | A protein from a biosynthetic gene cluster. |

## Domain[#](#domain "Link to this heading")

|  |  |
| --- | --- |
| [`Domain`](domain.html#chamois.model.Domain "chamois.model.Domain") | A domain from a protein. |
| [`PfamDomain`](domain.html#chamois.model.PfamDomain "chamois.model.PfamDomain") | A protein domain that was found with a Pfam HMM. |

[previous

API Reference](../index.html "previous page")
[next

Cluster Sequence](cluster_sequence.html "next page")

On this page

* [Cluster Sequence](#cluster-sequence)
* [Protein](#protein)
* [Domain](#domain)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/api/model/index.rst)

### This Page

* [Show Source](../../_sources/api/model/index.rst.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.