[ ]
[ ]

[Skip to content](#saved-queries)

[![](../../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Datasets —
Saving Queries

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
  + [Joining Datasets](../joining/ "Joining Datasets")
  + [Aggregating Datasets](../aggregating/ "Aggregating Datasets")
  + [Exporting Data](../exporting/ "Exporting Data")
  + [Reverting Data](../rollbacks/ "Reverting Data")
  + [Beacons](../beacons/ "Beacons")
  + [Entities](../entities/ "Entities")
  + [ ]

    Saving Queries
    [Saving Queries](./ "Saving Queries")

    Table of contents
    - [Overview](#overview "Overview")
    - [Using Saved Queries](#using-saved-queries "Using Saved Queries")
    - [The Saved Queries API](#the-saved-queries-api "The Saved Queries API")
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
* [Using Saved Queries](#using-saved-queries "Using Saved Queries")
* [The Saved Queries API](#the-saved-queries-api "The Saved Queries API")

# Saved Queries[¶](#saved-queries "Permanent link")

## Overview[¶](#overview "Permanent link")

Dataset queries can be saved and then used to make queries on datasets with a similar structure. Saved queries can be created for any dataset and can be shared with members of your organization.

For example, you may save a query for a set of interesting genes. You can then make this query available for all datasets that contain genes. If shared with other users in the organization, they will also be able to apply this query.

These queries can be as complex or simple as you wish.

## Using Saved Queries[¶](#using-saved-queries "Permanent link")

Saved queries can be used via the SolveBio API or the web UI. The UI will only display queries compatible with the current dataset. This compatibility check is handled automatically by SolveBio.

When viewing a dataset in the web UI, previously saved queries can be retrieved by selecting "Load Filters" and then selecting one. You can save a new query by applying filters to the dataset and then by clicking "Save Filters."

![Saved Filter toolbar options](../../img/saved_query_toolbar.png)

## The Saved Queries API[¶](#the-saved-queries-api "Permanent link")

To retrieve Saved Queries that apply to a dataset, or all those available to you:

[Python](#tab-0-python)
[R](#tab-0-r)

|  |  |
| --- | --- |
| ``` 1 2 3 ``` | ``` dataset_queries = SavedQuery.all(dataset="<DATASET_ID>")  all_saved_queries = SavedQuery.all() ``` |

|  |  |
| --- | --- |
| ``` 1 2 3 ``` | ``` dataset_queries = SavedQuery.all(dataset="<DATASET_ID>")  all_saved_queries = SavedQuery.all() ``` |

To use a saved query, retrieve the SavedQuery object and then apply the parameters.

[Python](#tab-1-python)
[R](#tab-1-r)

|  |  |
| --- | --- |
| ``` 1 2 3 4 5 6 7 ``` | ``` saved_query = SavedQuery.retrieve("SAVED_QUERY_ID")  # Option 1: from the SavedQuery instance (Python only) results = saved_query.query("<DATASET_ID>")  # Option 2: from the Dataset.query() function results = Dataset.retrieve("<DATASET_ID").query(**saved_query.params) ``` |

|  |  |
| --- | --- |
| ``` 1 2 3 ``` | ``` saved_query = SavedQuery.retrieve("SAVED_QUERY_ID")  results = Dataset.query("<DATASET_ID>", filters=saved_query$params$filters) ``` |

To create a SavedQuery, define the query parameters and a valid dataset. Give it a name and description.

[Python](#tab-2-python)
[R](#tab-2-r)

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 ``` | ``` params = {     "entities": [["gene", "MTOR"], ["gene", "BRCA2"], ["gene", "CFTR"]] }  saved_query = SavedQuery.create(     name="Interesting Genes",     description="Interesting genes as defined in Pubmed article 512312"     dataset="<DATASET_ID>",     params=params ) ``` |

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 ``` | ``` params = list(     entities=list(list("gene", "MTOR"), list("gene", "BRCA2"), list("gene", "CFTR")) )  saved_query <- SavedQuery.create(     name="Interesting Genes",     description="Interesting genes as defined in Pubmed article 512312",     dataset="<DATASET_ID>",     params=params ) ``` |

Read more about [SavedQuery endpoints here.](../../reference/datasets/saved_query/)

Last updated 2022-12-07.

Have questions or comments about this article? Get in touch with SolveBio Support by [submitting a ticket](https://support.solvebio.com/hc/en-us/requests/new) or by sending us an email.

[Previous

Datasets /
Entities](../entities/ "Entities")

[Next
Dataset Activity](../activity/ "Dataset Activity")

Copyright © 2021 Solve, Inc.

[Back to solvebio.com](https://www.solvebio.com "SolveBio")