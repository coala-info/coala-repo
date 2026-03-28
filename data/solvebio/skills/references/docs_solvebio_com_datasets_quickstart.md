[ ]
[ ]

[Skip to content](#quickstart)

[![](../../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Datasets —
Quickstart

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
  + [ ]
    [Quickstart](./ "Quickstart")
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

# Quickstart[¶](#quickstart "Permanent link")

This example will upload a JSON file, convert into a dataset, annotate the dataset and then export to an Excel file.

Store your credentials first!

You will need to have your credentials stored in order to run this example.
[Create a Personal Access Token](https://my.solvebio.com/settings/tokens).

[Python](#tab-2-python)
[R](#tab-2-r)

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 ``` | ``` import solvebio from solvebio import Vault from solvebio import Dataset from solvebio import DatasetImport  solvebio.login()  # Upload a local file to the root of your personal Vault vault = Vault.get_personal_vault()  # Download a sample file of variants # https://s3.amazonaws.com/downloads.solvebio.com/demo/interesting-variants.json.gz object_ = vault.upload_file('local/path/to/interesting-variants.json.gz', '/')  # Create a dataset dataset = Dataset.get_or_create_by_full_path('~/example-dataset')  # Import the file into the dataset imp = DatasetImport.create(     dataset_id=dataset.id,     object_id=object_.id )  # Wait until activity is completed dataset.activity(follow=True)  # Query the dataset genes_of_interest = ['SPOP', 'APC', 'IDH2'] results = dataset.query().filter(gene__in=genes_of_interest)  # Annotate with column by running migration new_column = dict(     name='interesting',     data_type='boolean',     description='These genes are interesting',     expression='True' ) dataset_migration = results.migrate(dataset, target_fields=[new_column], commit_mode='upsert', follow=False)  # Wait until activity is completed dataset.activity(follow=True)  # Same number of results! new_results = dataset.query().filter(interesting=True) assert len(list(new_results)) == len(list(results))  # Export variants in the KRAS gene into Excel query = dataset.query().filter(gene='KRAS') export = query.export(format='excel', follow=True) export.download('variants_kras.xlsx') ``` |

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 ``` | ``` library(solvebio)  solvebio::login()  # Download a sample file of variants # https://s3.amazonaws.com/downloads.solvebio.com/demo/interesting-variants.json.gz  # Upload the file to the root of your personal Vault vault <- Vault.get_personal_vault() object <- Object.upload_file('./interesting-variants.json.gz', vault$id, '/')  # Create a new, empty dataset dataset_full_path <- paste(vault$full_path, "/r_examples/my_dataset", sep=":") dataset <- Dataset.get_or_create_by_full_path(dataset_full_path)  # Import the file into the dataset imp = DatasetImport.create(dataset_id = dataset$id,                            commit_mode = 'append',                            object_id = object$id)  # Wait until import is completed Dataset.activity(dataset$id)  # Query the dataset filters <- '[["gene__in", ["SPOP", "APC", "IDH2"]]]' results <- Dataset.query(id = dataset$id, limit = 1000, paginate = TRUE, filters=filters)  # Annotate with column by running migration new_column = list(         name='interesting',         data_type='boolean',         description='These genes are interesting',         expression='True' )  filters = list(list("gene__in", list("SPOP", "APC", "IDH2")))  dm <- DatasetMigration.create(     source_id=dataset$id,     target_id=dataset$id,     target_fields=list(new_column),     source_params=list(filters=filters),     commit_mode='upsert' )  # Wait until migration is completed Dataset.activity(dataset$id)  # Same number of results! new_results <- Dataset.query(     id = dataset$id,     filters='[["interesting", true]]',     limit = 1000,     paginate = TRUE )  lengths(new_results$amino_acid_change) == lengths(new_results$amino_acid_change)   # Export variants in the KRAS gene into Excel filters <- list(list("gene", "KRAS")) export <- DatasetExport.create(     dataset$id,     format = 'excel',     params=list(filters=filters) )  # Wait until export is completed Dataset.activity(dataset$id)  # Download url <- DatasetExport.get_download_url(export$id) download.file(url, 'variants_kras.xlsx') ``` |

Last updated 2022-12-07.

Have questions or comments about this article? Get in touch with SolveBio Support by [submitting a ticket](https://support.solvebio.com/hc/en-us/requests/new) or by sending us an email.

[Previous

Datasets /
Overview](../ "Overview")

[Next
Creating Datasets](../creating/ "Creating Datasets")

Copyright © 2021 Solve, Inc.

[Back to solvebio.com](https://www.solvebio.com "SolveBio")