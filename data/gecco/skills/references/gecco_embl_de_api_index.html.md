[![](../_static/gecco.png)
GECCO](../index.html)
**v0.9.10**

* [Repository](https://github.com/zellerlab/GECCO)
* [Documentation](../index.html)

  - [Installation](../install.html)
  - [Integrations](../integrations.html)
  - [Training](../training.html)
  - [Contributing](../contributing.html)
  - API reference
  - [Changelog](../changes.html)
* [« Contributing](../contributing.html "Previous Chapter: Contributing")
* [Data Model »](model.html "Next Chapter: Data Model")

* API Reference
  + [Data Model](#data-model)
  + [ORF Extraction](#orf-extraction)
  + [Domain Annotation](#domain-annotation)
  + [BGC Detection](#bgc-detection)
  + [BGC Extraction](#bgc-extraction)
  + [Type Prediction](#type-prediction)
  + [InterPro Metadata](#interpro-metadata)

# API Reference[¶](#api-reference "Permalink to this heading")

## Data Model[¶](#data-model "Permalink to this heading")

|  |  |
| --- | --- |
| [`ClusterType`](model.html#gecco.model.ClusterType "gecco.model.ClusterType") | An immutable storage for the type of a gene cluster. |
| [`Strand`](model.html#gecco.model.Strand "gecco.model.Strand") | A flag to declare on which DNA strand a gene is located. |
| [`Domain`](model.html#gecco.model.Domain "gecco.model.Domain") | A conserved region within a protein. |
| [`Protein`](model.html#gecco.model.Protein "gecco.model.Protein") | A sequence of amino-acids translated from a gene. |
| [`Gene`](model.html#gecco.model.Gene "gecco.model.Gene") | A nucleotide sequence coding a protein. |
| [`Cluster`](model.html#gecco.model.Cluster "gecco.model.Cluster") | A sequence of contiguous genes. |
| [`ClusterTable`](model.html#gecco.model.ClusterTable "gecco.model.ClusterTable") | A table storing condensed information from several clusters. |
| [`FeatureTable`](model.html#gecco.model.FeatureTable "gecco.model.FeatureTable") | A table storing condensed domain annotations from different genes. |

## ORF Extraction[¶](#orf-extraction "Permalink to this heading")

|  |  |
| --- | --- |
| [`ORFFinder`](orf.html#gecco.orf.ORFFinder "gecco.orf.ORFFinder") | An abstract base class to provide a generic ORF finder. |
| [`PyrodigalFinder`](orf.html#gecco.orf.PyrodigalFinder "gecco.orf.PyrodigalFinder") | An [`ORFFinder`](orf.html#gecco.orf.ORFFinder "gecco.orf.ORFFinder") that uses the Pyrodigal bindings to Prodigal. |

## Domain Annotation[¶](#domain-annotation "Permalink to this heading")

|  |  |
| --- | --- |
| [`PyHMMER`](hmmer.html#gecco.hmmer.PyHMMER "gecco.hmmer.PyHMMER") | A domain annotator that uses [`pyhmmer`](https://pyhmmer.readthedocs.io/en/latest/api/index.html#module-pyhmmer "(in pyhmmer v0.10.6)"). |

## BGC Detection[¶](#bgc-detection "Permalink to this heading")

|  |  |
| --- | --- |
| [`ClusterCRF`](crf.html#gecco.crf.ClusterCRF "gecco.crf.ClusterCRF") | A wrapper for [`sklearn_crfsuite.CRF`](https://sklearn-crfsuite.readthedocs.io/en/latest/api.html#sklearn_crfsuite.CRF "(in sklearn-crfsuite v0.3)") to work with the GECCO data model. |

## BGC Extraction[¶](#bgc-extraction "Permalink to this heading")

|  |  |
| --- | --- |
| [`ClusterRefiner`](refine.html#gecco.refine.ClusterRefiner "gecco.refine.ClusterRefiner") | A post-processor to extract contiguous clusters from CRF predictions. |

## Type Prediction[¶](#type-prediction "Permalink to this heading")

|  |  |
| --- | --- |
| [`TypeBinarizer`](types.html#gecco.types.TypeBinarizer "gecco.types.TypeBinarizer") | A `MultiLabelBinarizer` working with `ClusterType` instances. |
| [`TypeClassifier`](types.html#gecco.types.TypeClassifier "gecco.types.TypeClassifier") | A wrapper to predict the type of a [`Cluster`](model.html#gecco.model.Cluster "gecco.model.Cluster"). |

## InterPro Metadata[¶](#interpro-metadata "Permalink to this heading")

|  |  |
| --- | --- |
| [`InterPro`](interpro.html#gecco.interpro.InterPro "gecco.interpro.InterPro") | A subset of the InterPro database exposing domain metadata. |
| [`InterProEntry`](interpro.html#gecco.interpro.InterProEntry "gecco.interpro.InterProEntry") | A single entry in the InterPro database. |

Back to top

© Copyright 2020-2024, Zeller group, EMBL.
Created using [Sphinx](http://sphinx-doc.org/) 5.3.0.