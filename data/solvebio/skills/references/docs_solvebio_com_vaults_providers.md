[ ]
[ ]

[Skip to content](#vault-providers)

[![](../../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Vaults —
Vault Providers



Type to start searching

* [Home](../.. "Home")
* [Global Search](../../search/ "Global Search")
* [Vaults](../ "Vaults")
* [Datasets](../../datasets/ "Datasets")
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
  + [Vaults](../ "Vaults")
  + [Datasets](../../datasets/ "Datasets")
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
* [x]

  Vaults

  Vaults
  + [Overview](../ "Overview")
  + [Vault Basics](../basics/ "Vault Basics")
  + [ ]

    Vault Providers
    [Vault Providers](./ "Vault Providers")

    Table of contents
    - [DNAnexus Provider](#dnanexus-provider "DNAnexus Provider")
    - [Other Providers](#other-providers "Other Providers")
  + [Sharing Vaults](../sharing/ "Sharing Vaults")
  + [Querying Files](../querying_files/ "Querying Files")
* [ ]

  Datasets

  Datasets
  + [Overview](../../datasets/ "Overview")
  + [Quickstart](../../datasets/quickstart/ "Quickstart")
  + [Creating Datasets](../../datasets/creating/ "Creating Datasets")
  + [Importing Data](../../datasets/importing/ "Importing Data")
  + [Transforming Data](../../datasets/transforming/ "Transforming Data")
  + [Querying Datasets](../../datasets/querying/ "Querying Datasets")
  + [Joining Datasets](../../datasets/joining/ "Joining Datasets")
  + [Aggregating Datasets](../../datasets/aggregating/ "Aggregating Datasets")
  + [Exporting Data](../../datasets/exporting/ "Exporting Data")
  + [Reverting Data](../../datasets/rollbacks/ "Reverting Data")
  + [Beacons](../../datasets/beacons/ "Beacons")
  + [Entities](../../datasets/entities/ "Entities")
  + [Saving Queries](../../datasets/saved_queries/ "Saving Queries")
  + [Dataset Activity](../../datasets/activity/ "Dataset Activity")
  + [Dataset Archiving](../../datasets/archiving/ "Dataset Archiving")
  + [Dataset Templates](../../datasets/templates/ "Dataset Templates")
  + [Dataset Charts](../../datasets/charts/ "Dataset Charts")
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

* [DNAnexus Provider](#dnanexus-provider "DNAnexus Provider")
* [Other Providers](#other-providers "Other Providers")

# Vault Providers[¶](#vault-providers "Permanent link")

Vault Providers are in Beta

Please [contact SolveBio](../../support/) for assistance using custom vault providers.

Vault Providers determine where and how the contents of a vault are stored. By default, vaults use SolveBio's built-in provider which stores files and datasets in SolveBio's Virtual Private Cloud (VPC) on Amazon Web Services. Files are encrypted and replicated on S3 and datasets are encrypted and replicated across EC2 instances in the same geographical region. Vaults can be created with different vault providers to access data from other services such as DNAnexus, S3, GCS, or any other data platform.

## DNAnexus Provider[¶](#dnanexus-provider "Permanent link")

To create a vault using the DNAnexus Provider, you'll need the following information:

* A valid DNAnexus authentication token
* The ID of a DNAnexus project you have access to

**NOTE: You can only link a single DNAnexus project with a DNAnexus-backed vault.**

The following example creates a new vault and links it with your DNAnexus project:

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 ``` | ``` import solvebio from solvebio import Vault from solvebio import VaultSyncTask from solvebio.client import client  solvebio.login()  dx_token = '<your token here>' dx_project_id = '<your project ID>' vault_name = 'My DNAnexus Vault'  vault = Vault.create(name=vault_name, provider='DNAnexus')  client.post('/v2/vault_properties', data={     'vault_id': vault.id,     'name': 'api_token',     'value': dx_token }) client.post('/v2/vault_properties', data={     'vault_id': vault.id,     'name': 'project_id',     'value': dx_project_id })  # Synchronize the contents of the vault with the project VaultSyncTask.create(vault_id=vault.id) ``` |

## Other Providers[¶](#other-providers "Permanent link")

If you would like support for other vault providers, [contact SolveBio](../../support/) for more information.

Last updated 2022-12-07.

Have questions or comments about this article? Get in touch with SolveBio Support by [submitting a ticket](https://support.solvebio.com/hc/en-us/requests/new) or by sending us an email.

[Previous

Vaults /
Vault Basics](../basics/ "Vault Basics")

[Next
Sharing Vaults](../sharing/ "Sharing Vaults")

Copyright © 2021 Solve, Inc.

[Back to solvebio.com](https://www.solvebio.com "SolveBio")