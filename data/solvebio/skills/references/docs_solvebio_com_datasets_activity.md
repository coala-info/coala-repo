[ ]
[ ]

[Skip to content](#dataset-activity)

[![](../../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Datasets —
Dataset Activity

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
  + [Saving Queries](../saved_queries/ "Saving Queries")
  + [ ]

    Dataset Activity
    [Dataset Activity](./ "Dataset Activity")

    Table of contents
    - [Example: Check for any activity](#example-check-for-any-activity "Example: Check for any activity")
    - [Example: Wait for idle dataset](#example-wait-for-idle-dataset "Example: Wait for idle dataset")
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

* [Example: Check for any activity](#example-check-for-any-activity "Example: Check for any activity")
* [Example: Wait for idle dataset](#example-wait-for-idle-dataset "Example: Wait for idle dataset")

# Dataset Activity[¶](#dataset-activity "Permanent link")

Dataset activity includes any operation that imports, transforms, exports or copies dataset data.

You can view a datasets activity via the API or in the SolveBio UI by visiting the Activity tab of a dataset.

## Example: Check for any activity[¶](#example-check-for-any-activity "Permanent link")

This example is a fast way to check for any activity on a dataset.

[Python](#tab-0-python)
[R](#tab-0-r)

|  |  |
| --- | --- |
| ``` 1 2 3 4 5 6 7 ``` | ``` from solvebio import Dataset activity = Dataset.retrieve(<DATASET ID>).activity() if activity:     print("Dataset has active tasks") else:     # run some analysis     print("Dataset is idle") ``` |

|  |  |
| --- | --- |
| ``` 1 2 3 4 5 6 7 8 ``` | ``` status <- paste('running', 'queued', 'pending', sep=',') tasks <- Task.all(target_object_id=<DATASET ID>, status=status, limit=1)$total if (tasks) {     # Active tasks } else {     # Dataset is idle } ``` |

## Example: Wait for idle dataset[¶](#example-wait-for-idle-dataset "Permanent link")

Some use cases may require waiting until a dataset is idle. A dataset is idle when there are no longer any task operations that are queued, pending or running.

This can be done synchronously using the `follow` parameter. This parameter continually loops through all dataset activity until the dataset is idle.

The function sleeps in between each check for activity. The default is 3 seconds and can be modified using the `sleep_seconds` parameter.

The function also limits the activity check to 1 tasks. This can be modified using the `limit` parameter.

[Python](#tab-4-python)
[R](#tab-4-r)

|  |  |
| --- | --- |
| ``` 1 2 3 4 5 6 7 8 ``` | ``` from solvebio import Dataset Dataset.retrieve(<DATASET ID>).activity(follow=True)  # Sleep for 20 seconds in between Dataset.retrieve(<DATASET ID>).activity(follow=True, sleep_seconds=20.0)  # Retrieve information for at most 30 active tasks Dataset.retrieve(<DATASET ID>).activity(follow=True, limit=30) ``` |

|  |  |
| --- | --- |
| ``` 1 2 3 4 ``` | ``` Dataset.activity(<DATASET ID>, follow=TRUE)  # Retrieve information for at most 30 active tasks Dataset.activity(<DATASET ID>, follow=TRUE, limit=30) ``` |

Last updated 2022-12-07.

Have questions or comments about this article? Get in touch with SolveBio Support by [submitting a ticket](https://support.solvebio.com/hc/en-us/requests/new) or by sending us an email.

[Previous

Datasets /
Saving Queries](../saved_queries/ "Saving Queries")

[Next
Dataset Archiving](../archiving/ "Dataset Archiving")

Copyright © 2021 Solve, Inc.

[Back to solvebio.com](https://www.solvebio.com "SolveBio")