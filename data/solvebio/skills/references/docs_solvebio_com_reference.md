[ ]
[ ]

[Skip to content](#reference-overview)

[![](../img/logo.png)](https://docs.solvebio.com "SolveBio Docs")

SolveBio Docs

Reference —
Overview



Type to start searching

* [Home](.. "Home")
* [Global Search](../search/ "Global Search")
* [Vaults](../vaults/ "Vaults")
* [Datasets](../datasets/ "Datasets")
* [Expressions](../expressions/ "Expressions")
* [Applications](../applications/ "Applications")
* [Examples](../examples/ "Examples")
* [Reference](./ "Reference")
* [Libraries](../libraries/ "Libraries")
* [Support](../support/ "Support")

![](../img/logo.png)
SolveBio Docs

* [ ]

  Home

  Home
  + [Overview](.. "Overview")
  + [Global Search](../search/ "Global Search")
  + [Vaults](../vaults/ "Vaults")
  + [Datasets](../datasets/ "Datasets")
  + [Expressions](../expressions/ "Expressions")
  + [Applications](../applications/ "Applications")
  + [Examples](../examples/ "Examples")
  + [ ]

    Reference
    [Reference](./ "Reference")

    Table of contents
    - [Authentication](#authentication "Authentication")
    - [Error Codes](#error-codes "Error Codes")
    - [Rate Limits](#rate-limits "Rate Limits")
    - [Cross Origin Resource Sharing](#cross-origin-resource-sharing "Cross Origin Resource Sharing")
  + [Libraries](../libraries/ "Libraries")
  + [Support](../support/ "Support")
* [ ]

  Global Search

  Global Search
  + [Global Search Overview](../search/ "Global Search Overview")
  + [Global Search API](../search/search_api/ "Global Search API")
  + [Global Beacons](../search/beacons/ "Global Beacons")
* [ ]

  Vaults

  Vaults
  + [Overview](../vaults/ "Overview")
  + [Vault Basics](../vaults/basics/ "Vault Basics")
  + [Vault Providers](../vaults/providers/ "Vault Providers")
  + [Sharing Vaults](../vaults/sharing/ "Sharing Vaults")
  + [Querying Files](../vaults/querying_files/ "Querying Files")
* [ ]

  Datasets

  Datasets
  + [Overview](../datasets/ "Overview")
  + [Quickstart](../datasets/quickstart/ "Quickstart")
  + [Creating Datasets](../datasets/creating/ "Creating Datasets")
  + [Importing Data](../datasets/importing/ "Importing Data")
  + [Transforming Data](../datasets/transforming/ "Transforming Data")
  + [Querying Datasets](../datasets/querying/ "Querying Datasets")
  + [Joining Datasets](../datasets/joining/ "Joining Datasets")
  + [Aggregating Datasets](../datasets/aggregating/ "Aggregating Datasets")
  + [Exporting Data](../datasets/exporting/ "Exporting Data")
  + [Reverting Data](../datasets/rollbacks/ "Reverting Data")
  + [Beacons](../datasets/beacons/ "Beacons")
  + [Entities](../datasets/entities/ "Entities")
  + [Saving Queries](../datasets/saved_queries/ "Saving Queries")
  + [Dataset Activity](../datasets/activity/ "Dataset Activity")
  + [Dataset Archiving](../datasets/archiving/ "Dataset Archiving")
  + [Dataset Templates](../datasets/templates/ "Dataset Templates")
  + [Dataset Charts](../datasets/charts/ "Dataset Charts")
* [ ]

  Expressions

  Expressions
  + [Overview](../expressions/ "Overview")
  + [Expression Context](../expressions/context/ "Expression Context")
  + [Expression Functions](../expressions/functions/ "Expression Functions")
  + [Expression Recipes](../expressions/recipes/ "Expression Recipes")
  + [Annotation Examples](../expressions/annotation/ "Annotation Examples")
* [ ]

  Applications

  Applications
  + [Overview](../applications/ "Overview")
  + [Managing Applications](../applications/managing/ "Managing Applications")
  + [Developing Applications](../applications/developing/ "Developing Applications")
  + [Deploying Applications](../applications/deploying/ "Deploying Applications")
* [ ]

  Examples

  Examples
  + [Overview](../examples/ "Overview")
  + [Variant Comparison Workflow](../examples/vca/ "Variant Comparison Workflow")
  + [Python: Importing reference data](../examples/Python_import/ "Python: Importing reference data")
  + [Python: TCGA visualizations](../examples/Python_Template/ "Python: TCGA visualizations")
  + [Python: Global Search](../examples/Python_Global_Search/ "Python: Global Search")
  + [Python: Global Beacon Indexing](../examples/Python_Global_Beacon_Indexing/ "Python: Global Beacon Indexing")
  + [R: Global Beacon and Global Search](../examples/R_Global_Beacon_And_Search/ "R: Global Beacon and Global Search")
  + [R: Top genes in ClinVar](../examples/R_Template/ "R: Top genes in ClinVar")
* [x]

  Reference

  Reference
  + [ ]

    Overview
    [Overview](./ "Overview")

    Table of contents
    - [Authentication](#authentication "Authentication")
    - [Error Codes](#error-codes "Error Codes")
    - [Rate Limits](#rate-limits "Rate Limits")
    - [Cross Origin Resource Sharing](#cross-origin-resource-sharing "Cross Origin Resource Sharing")
  + [ ]

    Beacons

    Beacons
    - [Endpoints](beacons/endpoints/ "Endpoints")
    - [Beacon Sets](beacons/beacon_sets/ "Beacon Sets")
    - [Beacons](beacons/beacons/ "Beacons")
  + [ ]

    Datasets

    Datasets
    - [Endpoints](datasets/endpoints/ "Endpoints")
    - [Datasets](datasets/datasets/ "Datasets")
    - [Dataset Commits](datasets/dataset_commits/ "Dataset Commits")
    - [Dataset Exports](datasets/dataset_exports/ "Dataset Exports")
    - [Dataset Fields](datasets/dataset_fields/ "Dataset Fields")
    - [Dataset Imports](datasets/dataset_imports/ "Dataset Imports")
    - [Dataset Migrations](datasets/dataset_migrations/ "Dataset Migrations")
    - [Dataset Templates](datasets/dataset_templates/ "Dataset Templates")
    - [Dataset Snapshot Tasks](datasets/dataset_snapshot_tasks/ "Dataset Snapshot Tasks")
    - [Dataset Restore Tasks](datasets/dataset_restore_tasks/ "Dataset Restore Tasks")
    - [Manifests](datasets/manifests/ "Manifests")
    - [Saved Queries](datasets/saved_query/ "Saved Queries")
  + [ ]

    Expressions

    Expressions
    - [Endpoints](expressions/endpoints/ "Endpoints")
    - [Annotate](expressions/annotate/ "Annotate")
    - [Evaluate](expressions/evaluate/ "Evaluate")
  + [ ]

    Vaults

    Vaults
    - [Endpoints](vaults/endpoints/ "Endpoints")
    - [Vaults](vaults/vaults/ "Vaults")
    - [Objects](vaults/objects/ "Objects")
  + [ ]

    Applications

    Applications
    - [Endpoints](applications/endpoints/ "Endpoints")
    - [Applications](applications/applications/ "Applications")
* Libraries
* Support

Table of contents

* [Authentication](#authentication "Authentication")
* [Error Codes](#error-codes "Error Codes")
* [Rate Limits](#rate-limits "Rate Limits")
* [Cross Origin Resource Sharing](#cross-origin-resource-sharing "Cross Origin Resource Sharing")

# Reference Overview[¶](#reference-overview "Permanent link")

SolveBio offers a RESTful, JSON-oriented API. All requests should be made to `https://api.solvebio.com` unless specified otherwise. The SolveBio API only accepts connections over HTTPS.

We recommend using one of our [client libraries](../libraries/) to access the API. The libraries take care of error handling, rate limiting, and query building. They make querying and working with SolveBio data a lot easier.

This API reference is organized by resource type and endpoint. Each resource type has one or more data representations and one or more methods.

## Authentication[¶](#authentication "Permanent link")

There are two ways clients can authenticate with SolveBio: using an API key, or an OAuth2 access token. Read more about [Authentication methods.](..#authentication)

## Error Codes[¶](#error-codes "Permanent link")

SolveBio uses conventional HTTP response codes to indicate success or failure of an API request. In general, codes in the `2xx` range indicate success, codes in the `4xx` range indicate an error that resulted from the provided information (e.g. a required parameter was missing, a query failed, etc.), and codes in the `5xx` range indicate an internal error with SolveBio's servers.

SolveBio uses the following error codes:

| Error Code | Meaning | Description |
| --- | --- | --- |
| `400` | Bad Request | Your request was malformed |
| `401` | Unauthorized | Your API key or token is invalid |
| `403` | Forbidden | Your API key or token is not valid for this type of request |
| `404` | Not Found | The specified resource could not be found |
| `405` | Method Not Allowed | Your request used an invalid method |
| `429` | Too Many Requests | You have reached the rate limit |
| `500` | Internal Server Error | We had a problem with our server |
| `503` | Service Unavailable | We are temporarily offline for maintenance |

The Python client will raise an exception when unexpected error codes are received from the API.

## Rate Limits[¶](#rate-limits "Permanent link")

Authenticated requests are throttled at 2,400 requests per minute. Unauthenticated requests are throttled at 100 requests per minute.

When the rate limit is exceeded, the API will respond with `429 Too Many
Requests`, and the `Retry-After` header will indicate the number of seconds to wait before retrying the request.

The Python client handles rate limiting automatically.

## Cross Origin Resource Sharing[¶](#cross-origin-resource-sharing "Permanent link")

The API supports Cross Origin Resource Sharing (CORS) for AJAX requests from any origin, enabling client-side applications to be easily augmented with SolveBio.

Last updated 2022-12-07.

Have questions or comments about this article? Get in touch with SolveBio Support by [submitting a ticket](https://support.solvebio.com/hc/en-us/requests/new) or by sending us an email.

[Previous

Examples /
R: Top genes in ClinVar](../examples/R_Template/ "R: Top genes in ClinVar")

[Next
Endpoints](beacons/endpoints/ "Endpoints")

Copyright © 2021 Solve, Inc.

[Back to solvebio.com](https://www.solvebio.com "SolveBio")