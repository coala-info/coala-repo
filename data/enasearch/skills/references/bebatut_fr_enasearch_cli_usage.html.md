[ENASearch](index.html)

0.2.0

ENASearch documentation

* [Installation](installation.html)
* [Some example of usage](use_case.html)
* [Interacting with ENA Database](ena.html)
* Usage with command-line
  + [Commands](#commands)
    - [enasearch](#enasearch)
      * [get\_analysis\_fields](#enasearch-get-analysis-fields)
      * [get\_display\_options](#enasearch-get-display-options)
      * [get\_download\_options](#enasearch-get-download-options)
      * [get\_filter\_fields](#enasearch-get-filter-fields)
      * [get\_filter\_types](#enasearch-get-filter-types)
      * [get\_results](#enasearch-get-results)
      * [get\_returnable\_fields](#enasearch-get-returnable-fields)
      * [get\_run\_fields](#enasearch-get-run-fields)
      * [get\_sortable\_fields](#enasearch-get-sortable-fields)
      * [get\_taxonomy\_results](#enasearch-get-taxonomy-results)
      * [retrieve\_analysis\_report](#enasearch-retrieve-analysis-report)
      * [retrieve\_data](#enasearch-retrieve-data)
      * [retrieve\_run\_report](#enasearch-retrieve-run-report)
      * [retrieve\_taxons](#enasearch-retrieve-taxons)
      * [search\_data](#enasearch-search-data)
* [Usage within Python](api_usage.html)
* [Contributing](contributing.html)
* [Source code on GitHub](https://github.com/bebatut/enasearch)

[ENASearch](index.html)

* [Docs](index.html) »
* Usage with command-line

---

# Usage with command-line[¶](#usage-with-command-line "Permalink to this headline")

ENASearch can be used via command-line with:

```
$ enasearch --help
Usage: enasearch [OPTIONS] COMMAND [ARGS]...

Options:
  --version   Show the version and exit.
  -h, --help  Show this message and exit.

Commands:
  get_analysis_fields       Get the fields extractable for an analysis.
  get_display_options       Get the list of possible formats to display...
  get_download_options      Get the options for download of data from...
  get_filter_fields         Get the filter fields of a result to build a...
  get_filter_types          Return the filters usable for the different...
  get_results               Get the possible results (type of data).
  get_returnable_fields     Get the fields extractable for a result.
  get_run_fields            Get the fields extractable for a run.
  get_sortable_fields       Get the fields of a result that can sorted.
  get_taxonomy_results      Get list of taxonomy results.
  retrieve_analysis_report  Retrieve analysis report from ENA.
  retrieve_data             Retrieve ENA data (other than taxon).
  retrieve_run_report       Retrieve run report from ENA.
  retrieve_taxons           Retrieve data from the ENA Taxon Portal.
  search_data               Search data given a query.
```

## Commands[¶](#commands "Permalink to this headline")

### enasearch[¶](#enasearch "Permalink to this headline")

The Python library for interacting with ENA’s API

```
enasearch [OPTIONS] COMMAND [ARGS]...
```

Options

`--version`[¶](#cmdoption-enasearch-version "Permalink to this definition")
:   Show the version and exit.

#### get\_analysis\_fields[¶](#enasearch-get-analysis-fields "Permalink to this headline")

Get the fields extractable for an analysis.

This function returns the fields as a list.

```
enasearch get_analysis_fields [OPTIONS]
```

#### get\_display\_options[¶](#enasearch-get-display-options "Permalink to this headline")

Get the list of possible formats to display the result.

This function returns the possible formats to display the result of a query on ENA. Each format is described.

```
enasearch get_display_options [OPTIONS]
```

#### get\_download\_options[¶](#enasearch-get-download-options "Permalink to this headline")

Get the options for download of data from ENA.

Each option is described.

```
enasearch get_download_options [OPTIONS]
```

#### get\_filter\_fields[¶](#enasearch-get-filter-fields "Permalink to this headline")

Get the filter fields of a result to build a query.

This function returns the fields that can be used to build a query on
a result on ENA. Each field is described on a line with field id, its
description, its type and to which results it is related

```
enasearch get_filter_fields [OPTIONS]
```

Options

`--result` `<result>`[¶](#cmdoption-enasearch-get-filter-fields-result "Permalink to this definition")
:   Id of a result (accessible with get\_results) [required]

#### get\_filter\_types[¶](#enasearch-get-filter-types "Permalink to this headline")

Return the filters usable for the different type of data.

This function returns the filters that can be used for the different type of
data (information available with the information on the filter fileds). Each
filter is described with its name, the possible operators or paramters, a
description of the expected values

```
enasearch get_filter_types [OPTIONS]
```

#### get\_results[¶](#enasearch-get-results "Permalink to this headline")

Get the possible results (type of data).

This function return the possible results (or type of data) accessible with
ENA with their ids and a short description

```
enasearch get_results [OPTIONS]
```

#### get\_returnable\_fields[¶](#enasearch-get-returnable-fields "Permalink to this headline")

Get the fields extractable for a result.

This function returns the fields as a list.

```
enasearch get_returnable_fields [OPTIONS]
```

Options

`--result` `<result>`[¶](#cmdoption-enasearch-get-returnable-fields-result "Permalink to this definition")
:   Id of a result (accessible with get\_results) [required]

#### get\_run\_fields[¶](#enasearch-get-run-fields "Permalink to this headline")

Get the fields extractable for a run.

This function returns the fields as a list.

```
enasearch get_run_fields [OPTIONS]
```

#### get\_sortable\_fields[¶](#enasearch-get-sortable-fields "Permalink to this headline")

Get the fields of a result that can sorted.

This function returns the fields that can be used to sort the output of a
query for a result on ENA. Each field is described on a line with field id,
its description, its type and to which results it is related

```
enasearch get_sortable_fields [OPTIONS]
```

Options

`--result` `<result>`[¶](#cmdoption-enasearch-get-sortable-fields-result "Permalink to this definition")
:   Id of a result (accessible with get\_results) [required]

#### get\_taxonomy\_results[¶](#enasearch-get-taxonomy-results "Permalink to this headline")

Get list of taxonomy results.

This function returns the description about the possible results
accessible via the taxon portal. Each taxonomy result is described with a
short description

```
enasearch get_taxonomy_results [OPTIONS]
```

#### retrieve\_analysis\_report[¶](#enasearch-retrieve-analysis-report "Permalink to this headline")

Retrieve analysis report from ENA.

The output can be redirected to a file and directly display to the standard
output given the display chosen.

```
enasearch retrieve_analysis_report [OPTIONS]
```

Options

`--accession` `<accession>`[¶](#cmdoption-enasearch-retrieve-analysis-report-accession "Permalink to this definition")
:   Accession id (study accessions (ERP, SRP, DRP, PRJ prefixes), experiment accessions (ERX, SRX, DRX prefixes), sample accessions (ERS, SRS, DRS, SAM prefixes) and run accessions)) [required]

`--fields` `<fields>`[¶](#cmdoption-enasearch-retrieve-analysis-report-fields "Permalink to this definition")
:   Fields to return (accessible with get\_analysis\_fields) [multiple or comma-separated]

`--file` `<file>`[¶](#cmdoption-enasearch-retrieve-analysis-report-file "Permalink to this definition")
:   File to save the report

#### retrieve\_data[¶](#enasearch-retrieve-data "Permalink to this headline")

Retrieve ENA data (other than taxon).

This function retrieves data (other than taxon) from ENA by:

* Building the URL based on the ids to retrieve and some parameters to format the results
* Requesting the URL to extract the data

The output can be redirected to a file and directly display to the standard
output given the display chosen.

```
enasearch retrieve_data [OPTIONS]
```

Options

`--ids` `<ids>`[¶](#cmdoption-enasearch-retrieve-data-ids "Permalink to this definition")
:   Ids for records to return (other than Taxon and Project) [multiple] [required]

`--display` `<display>`[¶](#cmdoption-enasearch-retrieve-data-display "Permalink to this definition")
:   Display option to specify the display format (accessible with get\_display\_options) [required]

`--download` `<download>`[¶](#cmdoption-enasearch-retrieve-data-download "Permalink to this definition")
:   Download option to specify that records are to be saved in a file (used with file option, list accessible with get\_download\_options)

`--file` `<file>`[¶](#cmdoption-enasearch-retrieve-data-file "Permalink to this definition")
:   File to save the content of the search (used with download option)

`--offset` `<offset>`[¶](#cmdoption-enasearch-retrieve-data-offset "Permalink to this definition")
:   First record to get (used only for display different of fasta and fastq

`--length` `<length>`[¶](#cmdoption-enasearch-retrieve-data-length "Permalink to this definition")
:   Number of records to retrieve (used only for display different of fasta and fastq

`--subseq_range` `<subseq_range>`[¶](#cmdoption-enasearch-retrieve-data-subseq-range "Permalink to this definition")
:   Range for subsequences (integer start and stop separated by a -)

`--expanded`[¶](#cmdoption-enasearch-retrieve-data-expanded "Permalink to this definition")
:   Determine if a CON record is expanded

`--header`[¶](#cmdoption-enasearch-retrieve-data-header "Permalink to this definition")
:   To obtain only the header of a record

#### retrieve\_run\_report[¶](#enasearch-retrieve-run-report "Permalink to this headline")

Retrieve run report from ENA.

The output can be redirected to a file and directly display to the standard
output given the display chosen.

```
enasearch retrieve_run_report [OPTIONS]
```

Options

`--accession` `<accession>`[¶](#cmdoption-enasearch-retrieve-run-report-accession "Permalink to this definition")
:   Accession id (study accessions (ERP, SRP, DRP, PRJ prefixes), experiment accessions (ERX, SRX, DRX prefixes), sample accessions (ERS, SRS, DRS, SAM prefixes) and run accessions)) [required]

`--fields` `<fields>`[¶](#cmdoption-enasearch-retrieve-run-report-fields "Permalink to this definition")
:   Fields to return (accessible with get\_run\_fields) [multiple or comma-separated]

`--file` `<file>`[¶](#cmdoption-enasearch-retrieve-run-report-file "Permalink to this definition")
:   File to save the report

#### retrieve\_taxons[¶](#enasearch-retrieve-taxons "Permalink to this headline")

Retrieve data from the ENA Taxon Portal.

This function retrieves data (other than taxon) from ENA by:

* Formatting the ids to query then on the Taxon Portal
* Building the URL based on the ids to retrieve and some parameters to format the results
* Requesting the URL to extract the data

The output can be redirected to a file and directly display to the standard
output given the display chosen.

```
enasearch retrieve_taxons [OPTIONS]
```

Options

`--ids` `<ids>`[¶](#cmdoption-enasearch-retrieve-taxons-ids "Permalink to this definition")
:   Ids for taxon to return [multiple] [required]

`--display` `<display>`[¶](#cmdoption-enasearch-retrieve-taxons-display "Permalink to this definition")
:   Display option to specify the display format (accessible with get\_display\_options) [required]

`--result` `<result>`[¶](#cmdoption-enasearch-retrieve-taxons-result "Permalink to this definition")
:   Id of a taxonomy result (accessible with get\_taxonomy\_results)

`--download` `<download>`[¶](#cmdoption-enasearch-retrieve-taxons-download "Permalink to this definition")
:   Download option to specify that records are to be saved in a file (used with file option, list accessible with get\_download\_options)

`--file` `<file>`[¶](#cmdoption-enasearch-retrieve-taxons-file "Permalink to this definition")
:   File to save the content of the search (used with download option)

`--offset` `<offset>`[¶](#cmdoption-enasearch-retrieve-taxons-offset "Permalink to this definition")
:   First record to get (used only for display different of fasta and fastq

`--length` `<length>`[¶](#cmdoption-enasearch-retrieve-taxons-length "Permalink to this definition")
:   Number of records to retrieve (used only for display different of fasta and fastq

`--subseq_range` `<subseq_range>`[¶](#cmdoption-enasearch-retrieve-taxons-subseq-range "Permalink to this definition")
:   Range for subsequences (integer start and stop separated by a -)

`--expanded`[¶](#cmdoption-enasearch-retrieve-taxons-expanded "Permalink to this definition")
:   Determine if a CON record is expanded

`--header`[¶](#cmdoption-enasearch-retrieve-taxons-header "Permalink to this definition")
:   To obtain only the header of a record

#### search\_data[¶](#enasearch-search-data "Permalink to this headline")

Search data given a query.

This function

* Extracts the number of possible results for the query
* Extracts the all the results of the query (by potentially running several times the search function)

The output can be redirected to a file and directly display to the standard
output given the display chosen.

```
enasearch search_data [OPTIONS]
```

Options

`--free_text_search`[¶](#cmdoption-enasearch-search-data-free-text-search "Permalink to this definition")
:   Use free text search, otherwise the data warehouse is used

`--query` `<query>`[¶](#cmdoption-enasearch-search-data-query "Permalink to this definition")
:   Query string, made up of filtering conditions, joined by logical ANDs, ORs and NOTs and bound by double quotes; the filter fields for a query are accessible with get\_filter\_fields and the type of filters with get\_filter\_types [required]

`--result` `<result>`[¶](#cmdoption-enasearch-search-data-result "Permalink to this definition")
:   Id of a result (accessible with get\_results) [required]

`--display` `<display>`[¶](#cmdoption-enasearch-search-data-display "Permalink to this definition")
:   Display option to specify the display format (accessible with get\_display\_options) [required]

`--download` `<download>`[¶](#cmdoption-enasearch-search-data-download "Permalink to this definition")
:   Download option to specify that records are to be saved in a file (used with file option, list accessible with get\_download\_options)

`--file` `<file>`[¶](#cmdoption-enasearch-search-data-file "Permalink to this definition")
:   File to save the content of the search (used with download option)

`--fields` `<fields>`[¶](#cmdoption-enasearch-search-data-fields "Permalink to this definition")
:   Fields to return (accessible with get\_returnable\_fields, used only for report as display value) [multiple or comma-separated]

`--sortfields` `<sortfields>`[¶](#cmdoption-enasearch-search-data-sortfields "Permalink to this definition")
:   Fields to sort the results (accessible with get\_sortable\_fields, used o