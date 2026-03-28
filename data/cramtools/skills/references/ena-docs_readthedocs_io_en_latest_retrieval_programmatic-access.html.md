[ENA Documentation
![Logo](../_static/ENA_Logo_tagline_white.png)](../index.html)

1

ENA Data Submission

* [General Guide On ENA Data Submission](../submit/general-guide.html)
* [How to Register a Study](../submit/study.html)
* [How to Register Samples](../submit/samples.html)
* [Preparing Files for Submission](../submit/fileprep.html)
* [How to Submit Raw Reads](../submit/reads.html)
* [How to Submit Assemblies](../submit/assembly.html)
* [How to Submit Targeted Sequences](../submit/sequence.html)
* [How to Submit Other Analyses](../submit/analyses.html)

ENA Data Discovery & Retrieval

* [General Guide on ENA Data Retrieval](general-guide.html)
  + [Viewing and Exploring ENA Records](general-guide.html#viewing-and-exploring-ena-records)
  + [Search and Retrieval](general-guide.html#search-and-retrieval)
  + [Programmatic Access](general-guide.html#programmatic-access)
    - How to Access ENA Programmatically
      * [Perform Searches](#perform-searches)
      * [Retrieve and Download Records](#retrieve-and-download-records)
      * [Explore Taxonomy and Related Records](#explore-taxonomy-and-related-records)
      * [Simplify Queries by Using the Tags on Samples, Taxonomy and Other Records](#simplify-queries-by-using-the-tags-on-samples-taxonomy-and-other-records)
      * [Sequence similarity search](#sequence-similarity-search)
      * [Access the CRAM Reference Registry](#access-the-cram-reference-registry)
      * [Rate Limits](#rate-limits)
* [How to Explore an ENA Project](ena-project.html)
* [How to Download Data Files](file-download.html)
* [How To Perform An Advanced Search](advanced-search.html)
* How to Access ENA Programmatically
  + [Perform Searches](#perform-searches)
    - [How to Perform Advanced Searches Across ENA Programmatically](programmatic-access/advanced-search.html)
    - [How to Search for Cross References in ENA Programmatically](programmatic-access/cross-reference.html)
  + [Retrieve and Download Records](#retrieve-and-download-records)
    - [How to Download Records using the ENA Browser API](programmatic-access/browser-api.html)
    - [Retrieving ENA File reports](programmatic-access/file-reports.html)
    - [How to Download Data files from ENA using enaBrowserTools](programmatic-access/browser-tools.html)
  + [Explore Taxonomy and Related Records](#explore-taxonomy-and-related-records)
    - [Programmatically Accessing Taxonomic Information](programmatic-access/taxon-api.html)
    - [How to Programmatically Perform a Search Across ENA Based on Taxonomy](programmatic-access/taxon-based-search.html)
  + [Simplify Queries by Using the Tags on Samples, Taxonomy and Other Records](#simplify-queries-by-using-the-tags-on-samples-taxonomy-and-other-records)
    - [Text Tags On ENA Objects](programmatic-access/tag_querying.html)
  + [Sequence similarity search](#sequence-similarity-search)
  + [Access the CRAM Reference Registry](#access-the-cram-reference-registry)
    - [CRAM Format](#cram-format)
    - [CRAM Reference Registry reverse proxy](#cram-reference-registry-reverse-proxy)
      * [How to Cache CRAM Reference Sequences using Squid](programmatic-access/cram-reference-cache.html)
  + [Rate Limits](#rate-limits)

ENA Data Updates

* [Updating Metadata Objects](../update/metadata.html)
* [Updating Assemblies](../update/assembly.html)
* [Updating Annotated Sequences](../update/sequence.html)

Tips and FAQs

* [Data Release Policies](../faq/release.html)
* [Spatiotemporal Metadata Standards](../faq/spatiotemporal-metadata.html)
* [Common Run Submission Errors](../faq/runs.html)
* [Tips for Sample Taxonomy](../faq/taxonomy.html)
* [Requesting New Taxon IDs](../faq/taxonomy_requests.html)
* [Metagenome Submission Queries](../faq/metagenomes.html)
* [Locus Tag Prefixes](../faq/locus_tags.html)
* [Archive Generated Run Files](../faq/archive-generated-files.html)
* [Archive Generated Analysis Files](../faq/archive-generated-analysis-files.html)
* [Analyses and Accessions](../faq/analysis-and-accessions.html)
* [Third Party Tools](../faq/third_party_tools.html)
* [Brokering Data to ENA](../faq/data_brokering.html)
* [Claiming ENA records via ORCID](../faq/orcid-claiming.html)

[ENA Documentation](../index.html)

* [General Guide on ENA Data Retrieval](general-guide.html)
* How to Access ENA Programmatically
* [View page source](../_sources/retrieval/programmatic-access.rst.txt)

---

# How to Access ENA Programmatically[](#how-to-access-ena-programmatically "Permalink to this heading")

There are a number of REST APIs available for programmatic access of the European Nucleotide Archive.
These enable programmatic access to the functionality of the ENA Advanced Search as well as direct download of ENA
records and associated files.

Please see the relevant guides below for examples and tutorials on ENA programmatic
data access and retrieval.

## Perform Searches[](#perform-searches "Permalink to this heading")

All functionalities of the ENA Advanced Search can be performed programmatically using a combination of the
[ENA Portal API](https://www.ebi.ac.uk/ena/portal/api/) and the
[ENA Browser API](https://www.ebi.ac.uk/ena/browser/api/). You can download the API docs for the Portal API
[here](https://www.ebi.ac.uk/ena/portal/api/doc) and the Browser API
[here](https://www.ebi.ac.uk/ena/browser/api/doc).

You can further explore related records outside of the
European Nucleotide Archive by programmatically accessing the
[ENA Cross Reference Service](https://www.ebi.ac.uk/ena/xref/rest/).

For examples and tutorials on how to use these APIs, please see the guidelines below:

* [How to Perform Advanced Searches Across ENA Programmatically](programmatic-access/advanced-search.html)
* [How to Search for Cross References in ENA Programmatically](programmatic-access/cross-reference.html)

## Retrieve and Download Records[](#retrieve-and-download-records "Permalink to this heading")

All public records within ENA are available to retrieve from the [ENA Browser API](https://www.ebi.ac.uk/ena/browser/api/)
so records can be programmatically downloaded directly from the API. Associated files can be downloaded using FTP or
Aspera protocol.

For a quick summary of metadata and file retrieval locations of records, you can use the ENA file reports.

For further simplicity, [enaBrowserTools](https://github.com/enasequence/enaBrowserTools)
can be downloaded and run locally on the command line to fetch files associated with records by accession. It can also be used
to bulk download records related to a specified Sample or Study.

For examples and tutorials on how to use the Browser API, file reports and enaBrowserTools, please see the guidelines below:

* [How to Download Records using the ENA Browser API](programmatic-access/browser-api.html)
* [Retrieving ENA File reports](programmatic-access/file-reports.html)
* [How to Download Data files from ENA using enaBrowserTools](programmatic-access/browser-tools.html)

## Explore Taxonomy and Related Records[](#explore-taxonomy-and-related-records "Permalink to this heading")

All sample records in ENA have taxonomic assignment. As a result, the majority of records stored within the archive
can be searched based on their taxonomy.

The ENA has a REST API for access to taxonomic information (e.g. lineage and
rank) so taxonomic records can be explored programmatically. You can also download taxon records in XML format using
the [ENA Browser API](https://www.ebi.ac.uk/ena/browser/api/) or explore related records with the
[ENA Portal API](https://www.ebi.ac.uk/ena/portal/api/).

For examples and tutorials on how to use the ENA taxonomy services, please see the guidelines below:

* [Programmatically Accessing Taxonomic Information](programmatic-access/taxon-api.html)
* [How to Programmatically Perform a Search Across ENA Based on Taxonomy](programmatic-access/taxon-based-search.html)

## Simplify Queries by Using the Tags on Samples, Taxonomy and Other Records[](#simplify-queries-by-using-the-tags-on-samples-taxonomy-and-other-records "Permalink to this heading")

The tags are controlled textual annotations on objects. There are already programmatically created by the ENA team making use of appropriate metadata property values.

The purpose of these is to make searching and filtering much easier.

* [Text Tags On ENA Objects](programmatic-access/tag_querying.html)

## Sequence similarity search[](#sequence-similarity-search "Permalink to this heading")

EBI’s central NCBI BLAST service can be accessed via
[REST and SOAP](https://www.ebi.ac.uk/seqdb/confluence/display/JDSAT/Job%2BDispatcher%2BSequence%2BAnalysis%2BTools%2BHome).

For usage details and parameter options, see the
[NCBI BLAST+ documentation](https://www.ebi.ac.uk/seqdb/confluence/pages/viewpage.action?pageId=94147939).

## Access the CRAM Reference Registry[](#access-the-cram-reference-registry "Permalink to this heading")

The CRAM reference registry provides access to reference sequences used in CRAM files.
Retrieval of reference sequences from the CRAM reference registry is provided by MD5 or
SHA1 checksum through the endpoints documented in the [CRAM reference registry API](https://www.ebi.ac.uk/ena/cram/).

### CRAM Format[](#cram-format "Permalink to this heading")

CRAM is a sequencing read file format that is highly space efficient by using reference-based compression of
sequence data and offers both lossless and lossy modes of compression. The format specification for CRAM is
maintained by the [Global Alliance for Genomics and Health (GA4GH)](https://www.ga4gh.org/cram/)
whose members provide multiple implementations and coordinate future specification changes.

The CRAM reference registry is used by GA4GH [Samtools](http://www.htslib.org/).

### CRAM Reference Registry reverse proxy[](#cram-reference-registry-reverse-proxy "Permalink to this heading")

To reduce network traffic originating from the use of the CRAM Reference Registry we recommend using locally
cached reference sequences. In addition to local caches supported by Samtools, it is possible to cache sequences
using an HTTP proxy.

In the tutorial below, the Squid is used as a reverse proxy to cache reference sequences retrieved from the
CRAM Reference Registry:

* [How to Cache CRAM Reference Sequences using Squid](programmatic-access/cram-reference-cache.html)

## Rate Limits[](#rate-limits "Permalink to this heading")

In order to ensure a smooth and fair user experience, we have implemented rate limits on our data discovery and retrieval RESTful APIs.

It helps us in maintaining optimal performance and preventing overload on our servers. By regulating the number of requests from individual users, we can ensure that everyone gets a consistent and responsive experience. It also acts as a protective measure against malicious activities such as DDoS attacks and brute-force attempts.

At present we have set the upper limit at **50 requests per second** which we think should be sufficient for most of the use-cases. If the requests breach this limit then it will be rejected with error **“Too Many Requests” (HTTP status code 429)**.

[Previous](file-download/ena-ftp-structure.html "ENA FTP Structure")
[Next](programmatic-access/advanced-search.html "How to Perform Advanced Searches Across ENA Programmatically")

---

© Copyright 2017-2024, European Nucleotide Archive (ENA). Licensed under the Apache License 2.0..

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).