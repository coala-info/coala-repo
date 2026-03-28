Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[pysradb 3.0.0.dev0 documentation](index.html)

[![Logo](_static/pysradb_v3.png)

pysradb 3.0.0.dev0 documentation](index.html)

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [CLI](cmdline.html)
* [Python API](python-api-usage.html)
* [Case Studies](case_studies.html)
* [Tutorials & Notebooks](notebooks.html)
* [API Documentation](commands.html)
* [Contributing](contributing.html)
* [Credits](authors.html)
* [History](history.html)
* [pysradb](modules.html)[x]

Back to top

[View this page](_sources/pysradb.rst.txt "View this page")

# pysradb package[¶](#pysradb-package "Link to this heading")

## Submodules[¶](#submodules "Link to this heading")

## pysradb.cli module[¶](#module-pysradb.cli "Link to this heading")

Command line interface for pysradb

*class* pysradb.cli.ArgParser(*prog=None*, *usage=None*, *description=None*, *epilog=None*, *parents=[]*, *formatter\_class=<class 'argparse.HelpFormatter'>*, *prefix\_chars='-'*, *fromfile\_prefix\_chars=None*, *argument\_default=None*, *conflict\_handler='error'*, *add\_help=True*, *allow\_abbrev=True*, *exit\_on\_error=True*)[[source]](_modules/pysradb/cli.html#ArgParser)[¶](#pysradb.cli.ArgParser "Link to this definition")
:   Bases: `ArgumentParser`

    error(*message: string*)[[source]](_modules/pysradb/cli.html#ArgParser.error)[¶](#pysradb.cli.ArgParser.error "Link to this definition")
    :   Prints a usage message incorporating the message to stderr and
        exits.

        If you override this in a subclass, it should not return – it
        should either exit or raise an exception.

*class* pysradb.cli.CustomFormatterArgP(*prog*, *indent\_increment=2*, *max\_help\_position=24*, *width=None*)[[source]](_modules/pysradb/cli.html#CustomFormatterArgP)[¶](#pysradb.cli.CustomFormatterArgP "Link to this definition")
:   Bases: `ArgumentDefaultsHelpFormatter`, `RawDescriptionHelpFormatter`

pysradb.cli.doi\_to\_gse(*doi\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#doi_to_gse)[¶](#pysradb.cli.doi_to_gse "Link to this definition")

pysradb.cli.doi\_to\_identifiers(*doi\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#doi_to_identifiers)[¶](#pysradb.cli.doi_to_identifiers "Link to this definition")

pysradb.cli.doi\_to\_srp(*doi\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#doi_to_srp)[¶](#pysradb.cli.doi_to_srp "Link to this definition")

pysradb.cli.download(*out\_dir*, *srx*, *srp*, *geo*, *skip\_confirmation*, *col='public\_url'*, *use\_ascp=False*, *threads=1*)[[source]](_modules/pysradb/cli.html#download)[¶](#pysradb.cli.download "Link to this definition")

pysradb.cli.geo\_matrix(*accession*, *to\_tsv*, *output\_dir*)[[source]](_modules/pysradb/cli.html#geo_matrix)[¶](#pysradb.cli.geo_matrix "Link to this definition")

pysradb.cli.get\_geo\_search\_info()[[source]](_modules/pysradb/cli.html#get_geo_search_info)[¶](#pysradb.cli.get_geo_search_info "Link to this definition")

pysradb.cli.gse\_to\_gsm(*gse\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#gse_to_gsm)[¶](#pysradb.cli.gse_to_gsm "Link to this definition")

pysradb.cli.gse\_to\_pmid(*gse\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#gse_to_pmid)[¶](#pysradb.cli.gse_to_pmid "Link to this definition")

pysradb.cli.gse\_to\_srp(*gse\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#gse_to_srp)[¶](#pysradb.cli.gse_to_srp "Link to this definition")

pysradb.cli.gsm\_to\_gse(*gsm\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#gsm_to_gse)[¶](#pysradb.cli.gsm_to_gse "Link to this definition")

pysradb.cli.gsm\_to\_srp(*gsm\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#gsm_to_srp)[¶](#pysradb.cli.gsm_to_srp "Link to this definition")

pysradb.cli.gsm\_to\_srr(*gsm\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#gsm_to_srr)[¶](#pysradb.cli.gsm_to_srr "Link to this definition")

pysradb.cli.gsm\_to\_srs(*gsm\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#gsm_to_srs)[¶](#pysradb.cli.gsm_to_srs "Link to this definition")

pysradb.cli.gsm\_to\_srx(*gsm\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#gsm_to_srx)[¶](#pysradb.cli.gsm_to_srx "Link to this definition")

pysradb.cli.metadata(*srp\_id*, *assay*, *desc*, *detailed*, *expand*, *saveto*, *enrich=False*, *enrich\_backend=None*)[[source]](_modules/pysradb/cli.html#metadata)[¶](#pysradb.cli.metadata "Link to this definition")

pysradb.cli.parse\_args(*args=None*)[[source]](_modules/pysradb/cli.html#parse_args)[¶](#pysradb.cli.parse_args "Link to this definition")
:   Argument parser

pysradb.cli.pmc\_to\_identifiers(*pmc\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#pmc_to_identifiers)[¶](#pysradb.cli.pmc_to_identifiers "Link to this definition")

pysradb.cli.pmid\_to\_gse(*pmid\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#pmid_to_gse)[¶](#pysradb.cli.pmid_to_gse "Link to this definition")

pysradb.cli.pmid\_to\_identifiers(*pmid\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#pmid_to_identifiers)[¶](#pysradb.cli.pmid_to_identifiers "Link to this definition")

pysradb.cli.pmid\_to\_srp(*pmid\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#pmid_to_srp)[¶](#pysradb.cli.pmid_to_srp "Link to this definition")

pysradb.cli.pretty\_print\_df(*df*, *include\_header=True*)[[source]](_modules/pysradb/cli.html#pretty_print_df)[¶](#pysradb.cli.pretty_print_df "Link to this definition")
:   Pretty print dataframe using rich formatting

pysradb.cli.search(*saveto*, *db*, *verbosity*, *return\_max*, *fields*)[[source]](_modules/pysradb/cli.html#search)[¶](#pysradb.cli.search "Link to this definition")

pysradb.cli.sra\_to\_pmid(*sra\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#sra_to_pmid)[¶](#pysradb.cli.sra_to_pmid "Link to this definition")
:   Backward compatibility wrapper for sra\_to\_pmid

pysradb.cli.srp\_to\_gse(*srp\_id*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srp_to_gse)[¶](#pysradb.cli.srp_to_gse "Link to this definition")

pysradb.cli.srp\_to\_pmid(*srp\_ids*, *saveto*)[[source]](_modules/pysradb/cli.html#srp_to_pmid)[¶](#pysradb.cli.srp_to_pmid "Link to this definition")

pysradb.cli.srp\_to\_srr(*srp\_id*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srp_to_srr)[¶](#pysradb.cli.srp_to_srr "Link to this definition")

pysradb.cli.srp\_to\_srs(*srp\_id*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srp_to_srs)[¶](#pysradb.cli.srp_to_srs "Link to this definition")

pysradb.cli.srp\_to\_srx(*srp\_id*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srp_to_srx)[¶](#pysradb.cli.srp_to_srx "Link to this definition")

pysradb.cli.srr\_to\_gsm(*srr\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srr_to_gsm)[¶](#pysradb.cli.srr_to_gsm "Link to this definition")

pysradb.cli.srr\_to\_srp(*srr\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srr_to_srp)[¶](#pysradb.cli.srr_to_srp "Link to this definition")

pysradb.cli.srr\_to\_srs(*srr\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srr_to_srs)[¶](#pysradb.cli.srr_to_srs "Link to this definition")

pysradb.cli.srr\_to\_srx(*srr\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srr_to_srx)[¶](#pysradb.cli.srr_to_srx "Link to this definition")

pysradb.cli.srs\_to\_gsm(*srs\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srs_to_gsm)[¶](#pysradb.cli.srs_to_gsm "Link to this definition")

pysradb.cli.srs\_to\_srx(*srs\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srs_to_srx)[¶](#pysradb.cli.srs_to_srx "Link to this definition")

pysradb.cli.srx\_to\_srp(*srx\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srx_to_srp)[¶](#pysradb.cli.srx_to_srp "Link to this definition")

pysradb.cli.srx\_to\_srr(*srx\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srx_to_srr)[¶](#pysradb.cli.srx_to_srr "Link to this definition")

pysradb.cli.srx\_to\_srs(*srx\_ids*, *saveto*, *detailed*, *desc*, *expand*)[[source]](_modules/pysradb/cli.html#srx_to_srs)[¶](#pysradb.cli.srx_to_srs "Link to this definition")

## pysradb.download module[¶](#module-pysradb.download "Link to this heading")

Utility function to download data

pysradb.download.download\_file(*url*, *file\_path*, *md5\_hash=None*, *timeout=10*, *block\_size=1048576*, *show\_progress=False*)[[source]](_modules/pysradb/download.html#download_file)[¶](#pysradb.download.download_file "Link to this definition")
:   Resumable download.
    Expect the server to support byte ranges.

    Parameters:
    :   **url: string**
        :   URL

        **file\_path: string**
        :   Local file path to store the downloaded file

        **md5\_hash: string**
        :   Expected MD5 string of downloaded file

        **timeout: int**
        :   Seconds to wait before terminating request

        **block\_size: int**
        :   Chunkx of bytes to read (default: 1024 \* 1024 = 1MB)

        **show\_progress: bool**
        :   Show progress bar

pysradb.download.get\_file\_size(*row*, *url\_col*)[[source]](_modules/pysradb/download.html#get_file_size)[¶](#pysradb.download.get_file_size "Link to this definition")
:   Get size of file to be downloaded.

    Parameters:
    :   **row: pd.DataFrame row**

        **url\_col: str**
        :   url\_column

    Returns:
    :   content\_length: int

pysradb.download.md5\_validate\_file(*file\_path*, *md5\_hash*)[[source]](_modules/pysradb/download.html#md5_validate_file)[¶](#pysradb.download.md5_validate_file "Link to this definition")
:   Check file containt against an MD5.

    Parameters:
    :   **file\_path: string**
        :   Path to file

        **md5\_hash: string**
        :   Expected md5 hash

    Returns:
    :   valid: bool
        :   True if expected and observed md5 match

pysradb.download.millify(*n*)[[source]](_modules/pysradb/download.html#millify)[¶](#pysradb.download.millify "Link to this definition")
:   Convert integer to human readable format.

    Parameters:
    :   **n**int

    Returns:
    :   **millidx**str
        :   Formatted integer

## pysradb.exceptions module[¶](#module-pysradb.exceptions "Link to this heading")

This file contains custom Exceptions for pysradb

*exception* pysradb.exceptions.IncorrectFieldException[[source]](_modules/pysradb/exceptions.html#IncorrectFieldException)[¶](#pysradb.exceptions.IncorrectFieldException "Link to this definition")
:   Bases: `Exception`

    Exception raised when the user enters incorrect inputs for a flag.

*exception* pysradb.exceptions.MissingQueryException[[source]](_modules/pysradb/exceptions.html#MissingQueryException)[¶](#pysradb.exceptions.MissingQueryException "Link to this definition")
:   Bases: `Exception`

    Exception raised when the user did not supply any query fields.

    Attributes:
    :   message: string
        :   Error message for this Exception

## pysradb.filter\_attrs module[¶](#module-pysradb.filter_attrs "Link to this heading")

pysradb.filter\_attrs.expand\_sample\_attribute\_columns(*metadata\_df*)[[source]](_modules/pysradb/filter_attrs.html#expand_sample_attribute_columns)[¶](#pysradb.filter_attrs.expand_sample_attribute_columns "Link to this definition")
:   Expand sample attribute columns to individual columns.

    Since the sample\_attribute column content can be different
    for differnt rows even if coming from the same project (SRP),
    we explicitly iterate through the rows to first determine
    what additional columns need to be created.

    Parameters:
    :   **metadata\_df: DataFrame**
        :   Dataframe as obtained from sra\_metadata
            or equivalent

    Returns:
    :   expanded\_df: DataFrame
        :   Dataframe with additionals columns pertaining
            to sample\_attribute appended

pysradb.filter\_attrs.guess\_cell\_type(*sample\_attribute*)[[source]](_modules/pysradb/filter_attrs.html#guess_cell_type)[¶](#pysradb.filter_attrs.guess_cell_type "Link to this definition")
:   Guess possible cell line from sample\_attribute data.

    Parameters:
    :   **sample\_attribute: string**
        :   sample\_attribute string as in the metadata column

    Returns:
    :   cell\_type: string
        :   Possible cell type of sample.
            Returns None if no match found.

pysradb.filter\_attrs.guess\_strain\_type(*sample\_attribute*)[[source]](_modules/pysradb/filter_attrs.html#guess_strain_type)[¶](#pysradb.filter_attrs.guess_strain_type "Link to this definition")
:   Guess strain type from sample\_attribute data.

    Parameters:
    :   **sample\_attribute: string**
        :   sample\_attribute string as in the metadata column

    Returns:
    :   strain\_type: string
        :   Possible cell type of sample.
            Returns None if no match found.

pysradb.filter\_attrs.guess\_tissue\_type(*sample\_attribute*)[[source]](_modules/pysradb/filter_attrs.html#guess_tissue_type)[¶](#pysradb.filter_attrs.guess_tissue_type "Link to this definition")
:   Guess tissue type from sample\_attribute data.

    Parameters:
    :   **sample\_attribute: string**
        :   sample\_attribute string as in the metadata column

    Returns:
    :   tissue\_type: string
        :   Possible cell type of sample.
            Returns None if no match found.

## pysradb.geoweb module[¶](#module-pysradb.geoweb "Link to this heading")

Utilities to interact with GEO online

*class* pysradb.geoweb.GEOweb[[source]](_modules/pysradb/geoweb.html#GEOweb)[¶](#pysradb.geoweb.GEOweb "Link to this definition")
:   Bases: `object`

    download(*links*, *root\_url*, *gse*, *verbose=False*, *out\_dir=None*)[[source]](_modules/pysradb/geoweb.html#GEOweb.download)[¶](#pysradb.geoweb.GEOweb.download "Link to this definition")
    :   Download GEO files.

        Parameters:
        :   **links: list**
            :   List of all links valid downloadable present for a GEO ID

            **root\_url: string**
            :   url for root directory for a GEO ID

            **gse: string**
            :   GEO ID

            **verbose: bool**
            :   Print file list

            **out\_dir: string**
            :   Directory location for download

    get\_download\_links(*gse*)[[source]](_modules/pysradb/geoweb.html#GEOweb.get_download_links)[¶](#pysradb.geoweb.GEOweb.get_download_links "Link to this definition")
    :   Obtain all links from the GEO FTP page.

        Parameters:
        :   **gse: string**
            :   GSE ID

       