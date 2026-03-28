[ ]
[ ]

[Skip to content](#reverting-datasets)

[![](../../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Datasets —
Reverting Data

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
  + [ ]

    Reverting Data
    [Reverting Data](./ "Reverting Data")

    Table of contents
    - [Overview](#overview "Overview")
    - [Rollbacks](#rollbacks "Rollbacks")

      * [Checking Ability to Rollback](#checking-ability-to-rollback "Checking Ability to Rollback")
      * [Example](#example "Example")
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
* [Rollbacks](#rollbacks "Rollbacks")

  + [Checking Ability to Rollback](#checking-ability-to-rollback "Checking Ability to Rollback")
  + [Example](#example "Example")

# Reverting Datasets[¶](#reverting-datasets "Permanent link")

## Overview[¶](#overview "Permanent link")

Dataset commits are the backbone of SolveBio's datastore and represent a change log of modifications to a dataset. A dataset commit represents all changes made to the target dataset by the import/migration/delete process.

All of these changes can be reverted by creating a rollback commit. All commits can be reverted. A rollback commit will restore the dataset to the state it was in before the commit was made.

The parent commit of a rollback commit is the commit to be reverted.

## Rollbacks[¶](#rollbacks "Permanent link")

A rollback commit represents a revert of a commit. The rollback commit will do different things depending on the mode of the parent commit. It may delete records, index a rollback file or both.

A rollback file is generated for overwrite, upsert and delete modes. This file is generated right before records are committed, by querying the current state of the dataset and storing those records in a file. This file is stored with the commit object and used when a rollback commit is created.

| Commit mode | Description |
| --- | --- |
| append | Reverts by deleting all records containing parent \_commit ID |
| delete | Reverts by indexing the records deleted (stored in rollback file) |
| overwrite | Reverts by deleting all records containing parent \_commit ID. Then indexing the rollback file |
| upsert | Same as overwrite commit mode |

### Checking Ability to Rollback[¶](#checking-ability-to-rollback "Permanent link")

In order for a commit to be reverted, there must be a clear "commit" stack on the dataset. Commits with mode `overwrite` or `upsert` will block reverts and must be reverted first. When creating a rollback, if there are blocking commits, the endpoint will fail and return these blocking commit values.

### Example[¶](#example "Permanent link")

Imagine a simple dataset containing employee names and employee addresses. This is maintained by an annual import of employees with address changes (including new employees.) Over the course of a few years, several employees move addresses. Several employees join the company, and some leave as well.

* Commit A (Import 2015 address file in overwrite mode)
* Commit B (Import 2016 address file in overwrite mode)
* Commit C (Import 2017 address file in overwrite mode)
* Commit D (Import 2018 address file in overwrite mode)

Let's do a simple case first, where nobody actually moves addresses and therefore only new employees are added.

If we revert Commit C, then we only remove new 2017 employees from the dataset. The 2015, 2016 and 2018 employees all remain.

Now let's assume people do move and so each year we have all sorts of address changes.

If you were to revert Commit C, then the dataset would be restored to the known state that it was in Commit B. It would only reset the 2017 addresses to 2016 addresses for people that did not also change in 2018. It would also leave any new employees added in 2018. This is an inconsistent state and not a valid snapshot of the dataset at the time Commit C was indexed. Therefore this is not allowed and attempts to rollback will fail. Commit D must be reverted first.

Last updated 2022-12-07.

Have questions or comments about this article? Get in touch with SolveBio Support by [submitting a ticket](https://support.solvebio.com/hc/en-us/requests/new) or by sending us an email.

[Previous

Datasets /
Exporting Data](../exporting/ "Exporting Data")

[Next
Beacons](../beacons/ "Beacons")

Copyright © 2021 Solve, Inc.

[Back to solvebio.com](https://www.solvebio.com "SolveBio")