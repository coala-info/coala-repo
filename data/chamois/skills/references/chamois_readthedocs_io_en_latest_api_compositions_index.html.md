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
* Compositions (`chamois.compositions`)
  + [Compositions](compositions.html)
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
* Compositions (`chamois.compositions`)

# Compositions ([`chamois.compositions`](#module-chamois.compositions "chamois.compositions"))[#](#module-chamois.compositions "Link to this heading")

Transformation of [`chamois.model`](../model/index.html#module-chamois.model "chamois.model") objects into compositional data.

This module contains helper functions to transform objects from the
object model in [`chamois.model`](../model/index.html#module-chamois.model "chamois.model") into compositional data suitable to
pass to the [`fit`](../predictor/predictor.html#chamois.predictor.ChemicalOntologyPredictor.fit "chamois.predictor.ChemicalOntologyPredictor.fit") and
[`predict`](../predictor/predictor.html#chamois.predictor.ChemicalOntologyPredictor.predict "chamois.predictor.ChemicalOntologyPredictor.predict") methods of
[`ChemicalOntologyPredictor`](../predictor/predictor.html#chamois.predictor.ChemicalOntologyPredictor "chamois.predictor.ChemicalOntologyPredictor") objects.

The compositional matrices are stored in [`AnnData`](https://anndata.readthedocs.io/en/stable/generated/anndata.AnnData.html#anndata.AnnData "(in anndata v0.12.10)") objects
to ensure that metadata related to the observations and features are
retained along the actual binary indicator matrices.

## Compositions[#](#compositions "Link to this heading")

|  |  |
| --- | --- |
| [`build_observations`](compositions.html#chamois.compositions.build_observations "chamois.compositions.build_observations") | Build an observation table from a list of cluster sequences. |
| [`build_variables`](compositions.html#chamois.compositions.build_variables "chamois.compositions.build_variables") | Build a variable table from an iterable of domains. |
| [`build_compositions`](compositions.html#chamois.compositions.build_compositions "chamois.compositions.build_compositions") | Build a compositional matrix from the given domain. |

[previous

Domain Annotator](../domains/domain_annotator.html "previous page")
[next

Compositions](compositions.html "next page")

On this page

* [Compositions](#compositions)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/api/compositions/index.rst)

### This Page

* [Show Source](../../_sources/api/compositions/index.rst.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.