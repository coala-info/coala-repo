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
* Predictor (`chamois.predictor`)
  + [Chemical Ontology Predictor](predictor.html)
  + [Information-theoric Metrics](information.html)
* [ClassyFire (`chamois.classyfire`)](../classyfire/index.html)
  + [Term](../classyfire/term.html)
  + [Classification](../classyfire/classification.html)
  + [Query](../classyfire/query.html)
  + [Cache](../classyfire/cache.html)
  + [Client](../classyfire/client.html)
  + [Utils](../classyfire/utils.html)

* [API Reference](../index.html)
* Predictor (`chamois.predictor`)

# Predictor ([`chamois.predictor`](#module-chamois.predictor "chamois.predictor"))[#](#module-chamois.predictor "Link to this heading")

Predictor of chemical classes from genomic features.

## Predictor[#](#predictor "Link to this heading")

|  |  |
| --- | --- |
| [`ChemicalOntologyPredictor`](predictor.html#chamois.predictor.ChemicalOntologyPredictor "chamois.predictor.ChemicalOntologyPredictor") | A model for predicting chemical hierarchy from BGC compositions. |

## Information-theoric metrics[#](#information-theoric-metrics "Link to this heading")

|  |  |
| --- | --- |
| [`information_accretion`](information.html#chamois.predictor.information.information_accretion "chamois.predictor.information.information_accretion") | Compute the information accretion using frequencies from the given labels. |
| [`remaining_uncertainty_score`](information.html#chamois.predictor.information.remaining_uncertainty_score "chamois.predictor.information.remaining_uncertainty_score") | Compute the remaining uncertainty score for a prediction. |
| [`misinformation_score`](information.html#chamois.predictor.information.misinformation_score "chamois.predictor.information.misinformation_score") | Compute the misinformation score for a prediction. |
| [`semantic_distance_score`](information.html#chamois.predictor.information.semantic_distance_score "chamois.predictor.information.semantic_distance_score") |  |
| [`information_theoric_curve`](information.html#chamois.predictor.information.information_theoric_curve "chamois.predictor.information.information_theoric_curve") | Return the information theoric curve for the predictions. |
| [`weighted_information_theoric_curve`](information.html#chamois.predictor.information.weighted_information_theoric_curve "chamois.predictor.information.weighted_information_theoric_curve") | Return the weighted information theoric curve for the predictions. |
| [`weighted_precision_recall_curve`](information.html#chamois.predictor.information.weighted_precision_recall_curve "chamois.predictor.information.weighted_precision_recall_curve") |  |

[previous

Adjacency Matrix](../ontology/adjacency.html "previous page")
[next

ChemicalOntologyPredictor](predictor.html "next page")

On this page

* [Predictor](#predictor)
* [Information-theoric metrics](#information-theoric-metrics)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/api/predictor/index.rst)

### This Page

* [Show Source](../../_sources/api/predictor/index.rst.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.