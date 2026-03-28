[ ]
[ ]

[Skip to content](#aggregating-datasets)

[![](../../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Datasets —
Aggregating Datasets

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
  + [ ]

    Aggregating Datasets
    [Aggregating Datasets](./ "Aggregating Datasets")

    Table of contents
    - [Overview](#overview "Overview")
    - [String and Date Aggregations](#string-and-date-aggregations "String and Date Aggregations")
    - [Numeric Aggregations](#numeric-aggregations "Numeric Aggregations")
    - [Nested Aggregations](#nested-aggregations "Nested Aggregations")
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
* [String and Date Aggregations](#string-and-date-aggregations "String and Date Aggregations")
* [Numeric Aggregations](#numeric-aggregations "Numeric Aggregations")
* [Nested Aggregations](#nested-aggregations "Nested Aggregations")

# Aggregating Datasets[¶](#aggregating-datasets "Permanent link")

## Overview[¶](#overview "Permanent link")

Aggregations are a powerful tool for building complex summaries of data.
Aggregation queries can be run on SolveBio datasets with the help of facets. Facets can be used to generate aggregated summaries of string (and date) fields as well as numeric fields, and they automatically work on top of [queries and filters](../querying/). Facets can also be nested, which provide an incredibly efficient mechanism to summarize binned or rolled-up data (i.e. data summarized by term or by date).

## String and Date Aggregations[¶](#string-and-date-aggregations "Permanent link")

For `string` fields (i.e. categorical fields) and `date` fields, you can use facets to find the total number of unique values as well as a list of the most common values that occur in the dataset. When used with a filtered dataset, the results will represent the filtered subset of data.

The following facet types are supported:

* `terms` (default): Returns a list of the top terms and the number of times they occur (in order of this value). The default number of terms returned at once is 10. You can set a limit up to 1 million (1,000,000) terms returned.
* `count`: Returns the number of unique values in the field. **For very large datasets, this is an approximate number.**

[Python](#tab-0-python)
[R](#tab-0-r)

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 ``` | ``` from solvebio import Dataset  query = Dataset.get_by_full_path('solvebio:public:/ClinVar/3.7.4-2017-01-30/Combined-GRCh37').query()  # Find the most common genes in ClinVar query.facets('gene_symbol')  # Retrieve the number of unique genes in ClinVar query.facets(gene_symbol={'facet_type': 'count'})  # Filter ClinVar for only variants that relate to drug response. # Which are the most common genes now? filters = solvebio.Filter(clinical_significance='Drug response') query.filter(f).facets('gene_symbol')  # How many genes are in this filtered query? query.filter(f).facets(gene_symbol={'facet_type': 'count'})  # Now, get the top 100 most common values query.filter(f).facets(gene_symbol={'limit': 100} ``` |

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 ``` | ``` library(solvebio)  # Load ClinVar clinvar <- Dataset.get_by_full_path("solvebio:public:/ClinVar/3.7.4-2017-01-30/Combined-GRCh37")  # Find the most common genes in ClinVar facets <- Dataset.facets(clinvar$id, list("gene_symbol")) # Convert the facet results to a matrix topGenes <- do.call(rbind, facets$gene_symbol)  # Retrieve the number of unique genes in ClinVar count <- Dataset.facets(clinvar$id, '{"gene_symbol": {"facet_type": "count"}}') # Convert the facet result to a number count <- as.numeric(count)  # Filter ClinVar for only variants that relate to drug response. # Which are the most common genes now? filters <- '[["clinical_significance", "Drug response"]]' facets <- Dataset.facets(clinvar$id, list("gene_symbol"), filters=filters) # Convert the facet results to a matrix topDrugResponseGenes <- do.call(rbind, facets$gene_symbol)  # How many genes are in this filtered query? count <- Dataset.facets(clinvar$id, '{"gene_symbol": {"facet_type": "count"}}', filters=filters) # Convert the facet result to a number countDrugResponseGenes <- as.numeric(count)  # Now, get the top 100 most common values facets <- Dataset.facets(clinvar$id, list("gene_symbol"=list("limit" = 1000))) # Convert the facet results to a matrix top1000DrugResponseGenes <- do.call(rbind, facets$gene_symbol) ``` |

Term facets do not work with text fields

Please keep in mind that facets will not work for `text` fields which are indexed (and tokenized) for full-text search. Terms facets are also disabled for `_id` fields.

## Numeric Aggregations[¶](#numeric-aggregations "Permanent link")

A few options are available for numerical fields (such as `float`/`double`, `integer`/`long`, and `date`). Instead of returning "common terms", numerical facets can calculate summary statistics, histograms, and percentiles. The following facet types are supported:

* `stats`: Default stats return average, count, maximum, minimum, and sum. Extended stats also include standard deviation, standard deviation lower and upper bounds, sum of squares, and variance.
* `histogram`: values are binned according to a provided interval. For numerical fields, the default interval is 100. For dates, the default interval is 'month'. **Histogram intervals must be integers**, and will therefore not work for fields with values between 0 and 1 (such as allele frequencies).
* `percentiles`: calculates estimated percentiles for a field. By default, returns the following percentiles: 1, 5, 25, 50, 75, 95, 99. **Percentiles are approximated and have an 1-5% error for very large datasets**.

[Python](#tab-1-python)
[R](#tab-1-r)

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 ``` | ``` from solvebio import Dataset  query = Dataset.get_by_full_path('solvebio:public:/ClinVar/3.7.4-2017-01-30/Combined-GRCh37').query()  # Get summary statistics for a date field query.facets('date_last_evaluated')  # Get extended statistics for a numerical field. query.facets(     **{'review_status_star': {         'facet_type': 'stats', 'extended': True}})  # Calculate a histogram for genomic position in chromosome 12 # NOTE: We use **-style notation since "chromosome" and "start" are nested fields query.filter(**{'genomic_coordinates.chromosome': 12}).facets(     **{'genomic_coordinates.start': {         'facet_type': 'histogram',         'interval': 1000000}}) ``` |

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 ``` | ``` library(solvebio)  # Get summary statistics for a date field clinvar <- Dataset.get_by_full_path("solvebio:public:/ClinVar/3.7.4-2017-01-30/Combined-GRCh37") Dataset.facets(id = clinvar$id, list("date_last_evaluated"))  # Get extended statistics for a numerical field. stats <- Dataset.facets(     clinvar$id,     '{"review_status_star": {         "facet_type": "stats", "extended": true}}') # Get the min and max values stats$review_status_star$min stats$review_status_star$max  # Calculate a histogram for genomic position in chromosome 12 facets <- Dataset.facets(     clinvar$id,     '{"genomic_coordinates.start": {"facet_type": "histogram"}}',     filters='[["genomic_coordinates.chromosome", 12]]') # Convert the result to a matrix genomicCoordinates <- do.call(rbind, facets$genomic_coordinates.start) ``` |

## Nested Aggregations[¶](#nested-aggregations "Permanent link")

Nested aggregations can be used to apply an aggregation query to the result of another aggregation query. For example, if you have a dataset with patients and want to determine the most common diagnosis age for each cancer type. You could iterate through each cancer type and run a facets query on the age field, but that would require a number of expensive API calls. Using nested aggregations, you can simply construct a facets query within an existing facets query, as in the example below.

At this time, you may only nest term and histogram facets under terms facets. **Nesting within histogram facets is not currently supported**.

[Python](#tab-6-python)
[R](#tab-6-r)

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 ``` | ``` from solvebio import Dataset  # Retrieve the TCGA Patient Information dataset tcga = Dataset.get_by_full_path('solvebio:public:/TCGA/1.2.0-2015-02-11/PatientInformation')  # Retrieve each cancer type (terms facets) # and the diagnosis ages for each (nested terms facet) facets = {     'cancer_abbreviation': {         'limit': 100,         'facets': {             'age_at_initial_pathologic_diagnosis': {                 'limit': 10             }         }     } }  results = tcga.query().facets(**facets)  # Process the nested results for cancer_type, patient_count, subfacets in results['cancer_abbreviation']:     print cancer_type, patient_count, subfacets['age_at_initial_pathologic_diagnosis'] ``` |

|  |  |
| --- | --- |
| ```  1  2  3  4  5  6  7  8  9 10 11 12 13 14 