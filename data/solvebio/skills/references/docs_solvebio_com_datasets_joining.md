[ ]
[ ]

[Skip to content](#joining-datasets)

[![](../../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Datasets —
Joining Datasets



Type to start searching

* [Home](../.. "Home")
* [Global Search](../../search/ "Global Search")
* [Vaults](../../vaults/ "Vaults")
* [Datasets](../ "Datasets")
* [Expressions](../../expressions/ "Expressions")
* [Applications](../../applications/ "Applications")
* [Examples](../../examples/ "Examples")
* [Reference](../../reference/ "Reference")
* [Libraries](../../libraries/ "Libraries")
* [Support](../../support/ "Support")

![](../../img/logo.png)
SolveBio Docs

* [ ]

  Home

  Home
  + [Overview](../.. "Overview")
  + [Global Search](../../search/ "Global Search")
  + [Vaults](../../vaults/ "Vaults")
  + [Datasets](../ "Datasets")
  + [Expressions](../../expressions/ "Expressions")
  + [Applications](../../applications/ "Applications")
  + [Examples](../../examples/ "Examples")
  + [Reference](../../reference/ "Reference")
  + [Libraries](../../libraries/ "Libraries")
  + [Support](../../support/ "Support")
* [ ]

  Global Search

  Global Search
  + [Global Search Overview](../../search/ "Global Search Overview")
  + [Global Search API](../../search/search_api/ "Global Search API")
  + [Global Beacons](../../search/beacons/ "Global Beacons")
* [ ]

  Vaults

  Vaults
  + [Overview](../../vaults/ "Overview")
  + [Vault Basics](../../vaults/basics/ "Vault Basics")
  + [Vault Providers](../../vaults/providers/ "Vault Providers")
  + [Sharing Vaults](../../vaults/sharing/ "Sharing Vaults")
  + [Querying Files](../../vaults/querying_files/ "Querying Files")
* [x]

  Datasets

  Datasets
  + [Overview](../ "Overview")
  + [Quickstart](../quickstart/ "Quickstart")
  + [Creating Datasets](../creating/ "Creating Datasets")
  + [Importing Data](../importing/ "Importing Data")
  + [Transforming Data](../transforming/ "Transforming Data")
  + [Querying Datasets](../querying/ "Querying Datasets")
  + [ ]

    Joining Datasets
    [Joining Datasets](./ "Joining Datasets")

    Table of contents
    - [Overview](#overview "Overview")
    - [Advanced examples](#advanced-examples "Advanced examples")
    - [Join parameters](#join-parameters "Join parameters")
  + [Aggregating Datasets](../aggregating/ "Aggregating Datasets")
  + [Exporting Data](../exporting/ "Exporting Data")
  + [Reverting Data](../rollbacks/ "Reverting Data")
  + [Beacons](../beacons/ "Beacons")
  + [Entities](../entities/ "Entities")
  + [Saving Queries](../saved_queries/ "Saving Queries")
  + [Dataset Activity](../activity/ "Dataset Activity")
  + [Dataset Archiving](../archiving/ "Dataset Archiving")
  + [Dataset Templates](../templates/ "Dataset Templates")
  + [Dataset Charts](../charts/ "Dataset Charts")
* [ ]

  Expressions

  Expressions
  + [Overview](../../expressions/ "Overview")
  + [Expression Context](../../expressions/context/ "Expression Context")
  + [Expression Functions](../../expressions/functions/ "Expression Functions")
  + [Expression Recipes](../../expressions/recipes/ "Expression Recipes")
  + [Annotation Examples](../../expressions/annotation/ "Annotation Examples")
* [ ]

  Applications

  Applications
  + [Overview](../../applications/ "Overview")
  + [Managing Applications](../../applications/managing/ "Managing Applications")
  + [Developing Applications](../../applications/developing/ "Developing Applications")
  + [Deploying Applications](../../applications/deploying/ "Deploying Applications")
* [ ]

  Examples

  Examples
  + [Overview](../../examples/ "Overview")
  + [Variant Comparison Workflow](../../examples/vca/ "Variant Comparison Workflow")
  + [Python: Importing reference data](../../examples/Python_import/ "Python: Importing reference data")
  + [Python: TCGA visualizations](../../examples/Python_Template/ "Python: TCGA visualizations")
  + [Python: Global Search](../../examples/Python_Global_Search/ "Python: Global Search")
  + [Python: Global Beacon Indexing](../../examples/Python_Global_Beacon_Indexing/ "Python: Global Beacon Indexing")
  + [R: Global Beacon and Global Search](../../examples/R_Global_Beacon_And_Search/ "R: Global Beacon and Global Search")
  + [R: Top genes in ClinVar](../../examples/R_Template/ "R: Top genes in ClinVar")
* [ ]

  Reference

  Reference
  + [Overview](../../reference/ "Overview")
  + [ ]

    Beacons

    Beacons
    - [Endpoints](../../reference/beacons/endpoints/ "Endpoints")
    - [Beacon Sets](../../reference/beacons/beacon_sets/ "Beacon Sets")
    - [Beacons](../../reference/beacons/beacons/ "Beacons")
  + [ ]

    Datasets

    Datasets
    - [Endpoints](../../reference/datasets/endpoints/ "Endpoints")
    - [Datasets](../../reference/datasets/datasets/ "Datasets")
    - [Dataset Commits](../../reference/datasets/dataset_commits/ "Dataset Commits")
    - [Dataset Exports](../../reference/datasets/dataset_exports/ "Dataset Exports")
    - [Dataset Fields](../../reference/datasets/dataset_fields/ "Dataset Fields")
    - [Dataset Imports](../../reference/datasets/dataset_imports/ "Dataset Imports")
    - [Dataset Migrations](../../reference/datasets/dataset_migrations/ "Dataset Migrations")
    - [Dataset Templates](../../reference/datasets/dataset_templates/ "Dataset Templates")
    - [Dataset Snapshot Tasks](../../reference/datasets/dataset_snapshot_tasks/ "Dataset Snapshot Tasks")
    - [Dataset Restore Tasks](../../reference/datasets/dataset_restore_tasks/ "Dataset Restore Tasks")
    - [Manifests](../../reference/datasets/manifests/ "Manifests")
    - [Saved Queries](../../reference/datasets/saved_query/ "Saved Queries")
  + [ ]

    Expressions

    Expressions
    - [Endpoints](../../reference/expressions/endpoints/ "Endpoints")
    - [Annotate](../../reference/expressions/annotate/ "Annotate")
    - [Evaluate](../../reference/expressions/evaluate/ "Evaluate")
  + [ ]

    Vaults

    Vaults
    - [Endpoints](../../reference/vaults/endpoints/ "Endpoints")
    - [Vaults](../../reference/vaults/vaults/ "Vaults")
    - [Objects](../../reference/vaults/objects/ "Objects")
  + [ ]

    Applications

    Applications
    - [Endpoints](../../reference/applications/endpoints/ "Endpoints")
    - [Applications](../../reference/applications/applications/ "Applications")
* Libraries
* Support

Table of contents

* [Overview](#overview "Overview")
* [Advanced examples](#advanced-examples "Advanced examples")
* [Join parameters](#join-parameters "Join parameters")

# Joining Datasets[¶](#joining-datasets "Permanent link")

## Overview[¶](#overview "Permanent link")

SolveBio provides possibility to join two datasets by keys that are related to each other. The provided datasets join functionality is very similar to well known left join in SQL.

Beta Feature (Python only)

This feature is currently in beta and available in the latest version of the SolveBio Python client (v2.13.0).

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 ``` | ``` filters = Filter(clinical_significance__exact="pathogenic") & Filter(gene__exact="PTEN") query_A = Dataset.get_by_full_path('solvebio:public:/ClinVar/5.1.0-20200720/Variants-GRCH37').query(filters=filters, fields=['variant', 'gene']) query_B = Dataset.get_by_full_path('solvebio:public:/COSMIC/1.1.1-COSMIC71/SomaticMutationsCoding-GRCh37').query(fields=['cosmic_id', 'count'])  # A result of datasets joining is a new Query object join_query = query_A.join(query_B, key='variant', key_b='variant')  for record in join_query:     print(record)  # Output: # {'count': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624227-89624227-G', 'cosmic_id': None} # {'count': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624241-89624241-CA', 'cosmic_id': None} # {'count': 3, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624241-89624243-C', 'cosmic_id': 'COSM4937'} # {'count': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624243-89624245-A', 'cosmic_id': None} # {'count': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624245-89624262-G', 'cosmic_id': None} # {'count': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624261-89624261-C', 'cosmic_id': None} # {'count': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624262-89624262-CA', 'cosmic_id': None} # {'count': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624262-89624264-C', 'cosmic_id': None} # {'count': 1, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624263-89624263-T', 'cosmic_id': 'COSM86063'} # ... ``` |

You can add more datasets to the join query. There is no limit to the number of additional joins but it may progressively slow down the query.

For example, add GnomAD allele frequencies to the list of PTEN variants:

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 ``` | ``` query_C = Dataset.get_by_full_path('solvebio:public:/gnomAD/2.1.1/Exomes-GRCh37').query(fields=["variant", "af"]) join_query = join_query.join(query_C, key='variant')  for record in join_query:     print(record)  # Output: # {'count': None, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624227-89624227-G', 'cosmic_id': None} # {'count': None, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624241-89624241-CA', 'cosmic_id': None} # {'count': 3, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624241-89624243-C', 'cosmic_id': 'COSM4937'} # {'count': None, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624243-89624245-A', 'cosmic_id': None} # {'count': None, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624245-89624262-G', 'cosmic_id': None} # {'count': None, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624261-89624261-C', 'cosmic_id': None} # {'count': None, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624262-89624262-CA', 'cosmic_id': None} # {'count': None, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624262-89624264-C', 'cosmic_id': None} # {'count': 1, 'af': None, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624263-89624263-T', 'cosmic_id': 'COSM86063'} # ... ``` |

Join queries cannot be filtered

Once a join query is created (i.e. the output of `query.join()`), you can no longer apply filters on the query. Use Python code to filter the results after receiving them, as shown in the example below.

Filtering the output of join queries must be done client-side (i.e. within your Python code). For example, to find all the COSMIC IDs for the known pathogenic PTEN variants with GnomAD allele frequencies:

|  |  |
| --- | --- |
| ``` 1 2 3 4 5 6 ``` | ``` for record in join_query:     if record['af'] is not None:         print(record)  # Output: # {'count': None, 'af': 3.97624e-06, 'gene': 'PTEN', 'variant': 'GRCH37-10-89624275-89624277-C', 'cosmic_id': None} ``` |

## Advanced examples[¶](#advanced-examples "Permanent link")

There is a possibility to join two datasets whose keys are lists. But first, you should apply the [`explode` function](../../expressions/functions/#explode) before joining.

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 ``` | ``` import solvebio as sb  ds1 = sb.Dataset.retrieve("dataset_id") ds2 = sb.Dataset.retrieve("dataset_id")  # before joining the records, split each record by the values of ensembl_id query_A = ds1.query(fields=["variant", "ensembl_id"], annotator_params={"pre_annotation_expression": 'explode(record, fields=["ensembl_id"])'}) query_B = ds2.query(fields=["gene", "ensembl_id"])  join_query = query_A.join(query_B, key="ensembl_id")  for record in join_query:     print(record)  # To then put this into a new dataset target = sb.Dataset.get_or_create_by_full_path('~/join_output') join_query.migrate(target) ``` |

## Join parameters[¶](#join-parameters "Permanent link")

The `join` method has the following attributes:

| Parameter | Value | Description |
| --- | --- | --- |
| query\_b | object | `Query` object `query_B` that will be joined with the initial query `query_A`. |
| key | string | a key from `query_A` containing a value that makes a relationship with `query_B`. |
| key\_b | string | (Optional, default=`None`) a key from `query_B` containing a value from `key` from `query_A`. If it is `None` a `key` argument from `query_A` will be used. |
| prefix | string | (Optional, default=`b_`) a prefix that will be added to all filtered fields from `query_B`. If it is set to `None`, a random prefix will be used. |
| always\_prefix | boolean | (Optional, default=`False`) an option to add a prefix either always or only when it is necessary e.g. when both joining keys have the same name. |

Last updated 2022-12-07.

Have questions or comments about this article? Get in touch with SolveBio Support by [submitting a ticket](https://support.solvebio.com/hc/en-us/requests/new) or by sending us an email.

[Previous

Datasets /
Querying Datasets](../querying/ "Querying Datasets")

[Next
Aggregating Datasets](../aggregating/ "Aggregating Datasets")

Copyright © 2021 Solve, Inc.

[Back to solvebio.com](https://www.solvebio.com "SolveBio")