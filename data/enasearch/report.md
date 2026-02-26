# enasearch CWL Generation Report

## enasearch_get_analysis_fields

### Tool Description
Get analysis fields from ENA.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Total Downloads**: 30.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
[u'analysis_accession',
 u'study_accession',
 u'secondary_study_accession',
 u'sample_accession',
 u'secondary_sample_accession',
 u'analysis_title',
 u'analysis_type',
 u'center_name',
 u'first_public',
 u'last_updated',
 u'study_title',
 u'tax_id',
 u'scientific_name',
 u'analysis_alias',
 u'study_alias',
 u'submitted_bytes',
 u'submitted_md5',
 u'submitted_ftp',
 u'submitted_aspera',
 u'submitted_galaxy',
 u'sample_alias',
 u'broker_name']
analysis_accession
study_accession
secondary_study_accession
sample_accession
secondary_sample_accession
analysis_title
analysis_type
center_name
first_public
last_updated
study_title
tax_id
scientific_name
analysis_alias
study_alias
submitted_bytes
submitted_md5
submitted_ftp
submitted_aspera
submitted_galaxy
sample_alias
broker_name
```


## enasearch_get_display_options

### Tool Description
Get display options for ENA search results.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
xml	Results are displayed in XML format. Supported by all ENA data classes.
text	Results are displayed in text format. Supported only by assembled and annotated sequence data classes.
fastq	Results are displayed in fastq format. Supported only by Trace data class.
html	Results are displayed in HTML format. Supported by all ENA data classes. HTML is the default display format if no other display option has been specified.
report	Results are displayed as a tab separated report
fasta	Results are displayed in fasta format. Supported by assembled and annotated sequence and Trace data classes.
```


## enasearch_get_download_options

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: enasearch get_download_options [OPTIONS]

  Get the options for download of data from ENA.

  Each option is described.

Options:
  -h, --help  Show this message and exit.
```


## enasearch_get_filter_fields

### Tool Description
Get the filter fields of a result to build a query.

  This function returns the fields that can be used to build a query on a
  result on ENA. Each field is described on a line with field id, its
  description, its type and to which results it is related

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch get_filter_fields [OPTIONS]

  Get the filter fields of a result to build a query.

  This function returns the fields that can be used to build a query on a
  result on ENA. Each field is described on a line with field id, its
  description, its type and to which results it is related

Options:
  --result TEXT  Id of a result (accessible with get_results)  [required]
  -h, --help     Show this message and exit.
```


## enasearch_get_filter_types

### Tool Description
Get available filter types and their associated operators and value descriptions.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
type	operators/parameters	values/description
geo_box2	latitude,  longitude,  radius (km)	All locations within a box defined by a centre point and a radius in km.
geo_box1	south-west latitude,  south-west longitude,  north-east latitude,  north-east longitude	All locations within a box defined by the lower left (SW) and upper right (NE) points.
geo_circ	latitude,  longitude,  radius (km)	All locations within a circle defined by a centre point and a radius in km.
geo_lat	latitude,  radius (km)	All locations within a latitude range given by a latitude and a radius in km.
geo_south	latitude	All locations south of a given latitude (inclusive).
geo_point	latitude,  longitude	An exact lat/lon position
geo_north	latitude	All locations north of a given latitude (inclusive).
Text	=, !=	A, n, y,  , t, e, x, t,  , v, a, l, u, e,  , e, n, c, l, o, s, e, d,  , i, n,  , d, o, u, b, l, e,  , q, u, o, t, e, s, .,  , W, i, l, d, c, a, r, d,  , (, *, ),  , c, a, n,  ,  ,  ,  ,  ,  ,  ,  ,  , b, e,  , u, s, e, d,  , a, t,  , t, h, e,  , s, t, a, r, t,  , a, n, d, /, o, r,  , e, n, d,  , o, f,  , t, h, e,  , t, e, x, t,  , v, a, l, u, e, .
Number	=, !=, <, <=, >, >=	A, n, y,  , i, n, t, e, g, e, r
Boolean	=	yes, true, no, false
col_tax_tree	CoL taxonomy identifier	All records that match the given CoL taxonomy identifier or are descendants of it
col_tax_eq	CoL taxonomy identifier	All records that match the given CoL taxonomy identifier
tax_eq	NCBI taxonomy identifier	All records that match the given NCBI taxonomy identifier
tax_tree	NCBI taxonomy identifier	All records that match the given NCBI taxonomy identifier or are descendants of it
tax_name	NCBI scientific name	All records that match the given NCBI scientific name
Date	=, !=, <, <=, >, >=	A,  , d, a, t, e,  , i, n,  , t, h, e,  , f, o, r, m, a, t,  , Y, Y, Y, Y, -, M, M, -, D, D
Controlled vocabulary	=, !=	A,  , t, e, x, t,  , v, a, l, u, e,  , f, r, o, m,  , t, h, e,  , c, o, n, t, r, o, l, l, e, d,  , v, o, c, a, b, u, l, a, r, y,  , e, n, c, l, o, s, e, d,  , i, n,  ,  ,  ,  ,  ,  ,  ,  ,  , d, o, u, b, l, e,  , q, u, o, t, e, s
```


## enasearch_get_results

### Tool Description
Get results from ENA.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
noncoding_release	Non-coding sequences (Release)
assembly	Genome assemblies
sequence_release	Nucleotide sequences (Release)
wgs_set	Genome assembly contig set
study	Studies
taxon	Taxonomic classification
coding_release	Protein-coding sequences (Release)
sample	Samples
environmental	Environmental samples
read_run	Raw reads
read_study	Raw reads (grouped by study)
read_experiment	Raw reads (grouped by experiment)
analysis	Nucleotide sequence analyses from reads
sequence_update	Nucleotide sequences (Update)
coding_update	Protein-coding sequences (Update)
tsa_set	Transcriptome assembly contig set
analysis_study	Nucleotide sequence analyses from reads (grouped by study)
noncoding_update	Non-coding sequences (Update)
```


## enasearch_get_returnable_fields

### Tool Description
Get the fields extractable for a result.

  This function returns the fields as a list.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch get_returnable_fields [OPTIONS]

  Get the fields extractable for a result.

  This function returns the fields as a list.

Options:
  --result TEXT  Id of a result (accessible with get_results)  [required]
  -h, --help     Show this message and exit.
```


## enasearch_get_run_fields

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: enasearch get_run_fields [OPTIONS]

  Get the fields extractable for a run.

  This function returns the fields as a list.

Options:
  -h, --help  Show this message and exit.
```


## enasearch_get_sortable_fields

### Tool Description
Get the fields of a result that can sorted.

  This function returns the fields that can be used to sort the output of a
  query for a result on ENA. Each field is described on a line with field
  id, its description, its type and to which results it is related

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch get_sortable_fields [OPTIONS]

  Get the fields of a result that can sorted.

  This function returns the fields that can be used to sort the output of a
  query for a result on ENA. Each field is described on a line with field
  id, its description, its type and to which results it is related

Options:
  --result TEXT  Id of a result (accessible with get_results)  [required]
  -h, --help     Show this message and exit.
```


## enasearch_get_taxonomy_results

### Tool Description
Get taxonomy results for a given accession.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
noncoding_release	Non-coding sequences (Release)
sequence_release	Nucleotide Sequences (Release)
study	Studies
read_trace	Capillary Traces in Trace Archive
coding_release	Protein-coding sequences (Release)
sample	Samples
read_run	Raw reads
read_study	Raw reads (grouped by study)
read_experiment	Raw reads (grouped by experiment)
analysis	Nucleotide sequence analyses
sequence_update	Nucleotide Sequences (Update)
coding_update	Protein-coding sequences (Update)
analysis_study	Nucleotide sequence analyses (grouped by study)
noncoding_update	Non-coding sequences (Update)
```


## enasearch_retrieve_analysis_report

### Tool Description
Retrieve analysis report from ENA.

The output can be redirected to a file and directly display to the
standard output given the display chosen.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch retrieve_analysis_report [OPTIONS]

  Retrieve analysis report from ENA.

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

Options:
  --accession TEXT  Accession id (study accessions (ERP, SRP, DRP, PRJ
                    prefixes), experiment accessions (ERX, SRX, DRX prefixes),
                    sample accessions (ERS, SRS, DRS, SAM prefixes) and run
                    accessions))  [required]
  --fields TEXT     Fields to return (accessible with get_analysis_fields)
                    [multiple or comma-separated]
  --file PATH       File to save the report
  -h, --help        Show this message and exit.
```


## enasearch_retrieve_data

### Tool Description
Retrieve ENA data (other than taxon).

  This function retrieves data (other than taxon) from ENA by:

  - Building the URL based on the ids to retrieve and some parameters to
  format the results - Requesting the URL to extract the data

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch retrieve_data [OPTIONS]

  Retrieve ENA data (other than taxon).

  This function retrieves data (other than taxon) from ENA by:

  - Building the URL based on the ids to retrieve and some parameters to
  format the results - Requesting the URL to extract the data

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

Options:
  --ids TEXT              Ids for records to return (other than Taxon and
                          Project) [multiple]  [required]
  --display TEXT          Display option to specify the display format
                          (accessible with get_display_options)  [required]
  --download TEXT         Download option to specify that records are to be
                          saved in a file (used with file option, list
                          accessible with get_download_options)
  --file PATH             File to save the content of the search (used with
                          download option)
  --offset INTEGER RANGE  First record to get (used only for display different
                          of  fasta and fastq
  --length INTEGER RANGE  Number of records to retrieve (used only for display
                          different of fasta and fastq
  --subseq_range TEXT     Range for subsequences (integer start and stop
                          separated  by a -)
  --expanded              Determine if a CON record is expanded
  --header                To obtain only the header of a record
  -h, --help              Show this message and exit.
```


## enasearch_retrieve_run_report

### Tool Description
Retrieve run report from ENA.

The output can be redirected to a file and directly display to the
standard output given the display chosen.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch retrieve_run_report [OPTIONS]

  Retrieve run report from ENA.

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

Options:
  --accession TEXT  Accession id (study accessions (ERP, SRP, DRP, PRJ
                    prefixes), experiment accessions (ERX, SRX, DRX prefixes),
                    sample accessions (ERS, SRS, DRS, SAM prefixes) and run
                    accessions))  [required]
  --fields TEXT     Fields to return (accessible with get_run_fields)
                    [multiple or comma-separated]
  --file PATH       File to save the report
  -h, --help        Show this message and exit.
```


## enasearch_retrieve_taxons

### Tool Description
Retrieve data from the ENA Taxon Portal.

  This function retrieves data (other than taxon) from ENA by:

  - Formatting the ids to query then on the Taxon Portal - Building the URL
  based on the ids to retrieve and some parameters to format the results -
  Requesting the URL to extract the data

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch retrieve_taxons [OPTIONS]

  Retrieve data from the ENA Taxon Portal.

  This function retrieves data (other than taxon) from ENA by:

  - Formatting the ids to query then on the Taxon Portal - Building the URL
  based on the ids to retrieve and some parameters to format the results -
  Requesting the URL to extract the data

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

Options:
  --ids TEXT              Ids for taxon to return [multiple]  [required]
  --display TEXT          Display option to specify the display format
                          (accessible with get_display_options)  [required]
  --result TEXT           Id of a taxonomy result (accessible with
                          get_taxonomy_results)
  --download TEXT         Download option to specify that records are to be
                          saved in a file (used with file option, list
                          accessible with get_download_options)
  --file PATH             File to save the content of the search (used with
                          download option)
  --offset INTEGER RANGE  First record to get (used only for display different
                          of fasta and fastq
  --length INTEGER RANGE  Number of records to retrieve (used only for display
                          different of fasta and fastq
  --subseq_range TEXT     Range for subsequences (integer start and stop
                          separated by a -)
  --expanded              Determine if a CON record is expanded
  --header                To obtain only the header of a record
  -h, --help              Show this message and exit.
```


## enasearch_search_data

### Tool Description
Search data given a query.

  This function

  - Extracts the number of possible results for the query - Extracts the all
  the results of the query (by potentially running several times the search
  function)

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

### Metadata
- **Docker Image**: quay.io/biocontainers/enasearch:0.2.2--py27_0
- **Homepage**: http://bebatut.fr/enasearch/
- **Package**: https://anaconda.org/channels/bioconda/packages/enasearch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: enasearch search_data [OPTIONS]

  Search data given a query.

  This function

  - Extracts the number of possible results for the query - Extracts the all
  the results of the query (by potentially running several times the search
  function)

  The output can be redirected to a file and directly display to the
  standard output given the display chosen.

Options:
  --free_text_search      Use free text search, otherwise the data warehouse
                          is used
  --query TEXT            Query string, made up of filtering conditions,
                          joined by logical ANDs, ORs and NOTs and bound by
                          double quotes; the filter fields for a query are
                          accessible with get_filter_fields and the type of
                          filters with get_filter_types  [required]
  --result TEXT           Id of a result (accessible with get_results)
                          [required]
  --display TEXT          Display option to specify the display format
                          (accessible with get_display_options)  [required]
  --download TEXT         Download option to specify that records are to be
                          saved in a file (used with file option, list
                          accessible with get_download_options)
  --file PATH             File to save the content of the search (used with
                          download option)
  --fields TEXT           Fields to return (accessible with
                          get_returnable_fields, used only for report as
                          display value) [multiple or comma-separated]
  --sortfields TEXT       Fields to sort the results (accessible with
                          get_sortable_fields, used only for report as display
                          value) [multiple or comma-separated]
  --offset INTEGER RANGE  First record to get (used only for display different
                          of fasta and fastq
  --length INTEGER RANGE  Number of records to retrieve (used only for display
                          different of fasta and fastq
  -h, --help              Show this message and exit.
```

