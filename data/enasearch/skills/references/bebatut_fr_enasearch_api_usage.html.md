[ENASearch](index.html)

0.2.0

ENASearch documentation

* [Installation](installation.html)
* [Some example of usage](use_case.html)
* [Interacting with ENA Database](ena.html)
* [Usage with command-line](cli_usage.html)
* Usage within Python
  + [Functions](#module-enasearch)
  + [Data](#data)
* [Contributing](contributing.html)
* [Source code on GitHub](https://github.com/bebatut/enasearch)

[ENASearch](index.html)

* [Docs](index.html) »
* Usage within Python

---

# Usage within Python[¶](#usage-within-python "Permalink to this headline")

To use ENASearch within Python:

```
>>> import enasearch
```

## Functions[¶](#module-enasearch "Permalink to this headline")

`enasearch.``build_retrieve_url`(*ids*, *display*, *result=None*, *download=None*, *file=None*, *offset=None*, *length=None*, *subseq\_range=None*, *expanded=False*, *header=False*)[[source]](_modules/enasearch.html#build_retrieve_url)[¶](#enasearch.build_retrieve_url "Permalink to this definition")
:   Build the URL to retrieve data or taxon

    This function builds the URL to retrieve data or taxon on ENA. It takes
    several arguments, check their validity before combining them to build the
    URL.

    |  |  |
    | --- | --- |
    | Parameters: | * **ids** – comma-separated identifiers for records other than Taxon * **display** – display option to specify the display format (accessible with get\_display\_options) * **offset** – first record to get * **length** – number of records to retrieve * **download** – download option to specify that records are to be saved in a file (used with file option, accessible with get\_download\_options) * **file** – filepath to save the content of the search (used with download option) * **subseq\_range** – range for subsequences (limit separated by a -) * **expanded** – boolean to determine if a CON record is expanded * **header** – boolean to obtain only the header of a record |
    | Returns: | a string with the build URL |

`enasearch.``check_display_option`(*display*)[[source]](_modules/enasearch.html#check_display_option)[¶](#enasearch.check_display_option "Permalink to this definition")
:   Check if a display id is in the list of output formats for a query on ENA

    This function raises an error if the id is not in the list of possible
    displayable format

    |  |  |
    | --- | --- |
    | Parameters: | **display** – display to check |

`enasearch.``check_download_file_options`(*download*, *file*)[[source]](_modules/enasearch.html#check_download_file_options)[¶](#enasearch.check_download_file_options "Permalink to this definition")
:   Check that download and file options are correctly defined

    This function check:

    * A filepath is given
    * A download option is given
    * The download option is in the list of options for download of data from ENA

    |  |  |
    | --- | --- |
    | Parameters: | * **download** – download option to specify that records are to be saved in a file (used with file option, accessible with get\_download\_options) * **file** – filepath to save the content of the data (used with download option) |

`enasearch.``check_download_option`(*download*)[[source]](_modules/enasearch.html#check_download_option)[¶](#enasearch.check_download_option "Permalink to this definition")
:   Check if an options is in the list of options for download of data from ENA

    This function raises an error if the id is not in the list of possible
    download options

    |  |  |
    | --- | --- |
    | Parameters: | **download** – download format to check |

`enasearch.``check_length`(*length*)[[source]](_modules/enasearch.html#check_length)[¶](#enasearch.check_length "Permalink to this definition")
:   Check if length (number of results for a query) is below the maximum

    This function raises an error if the given length (or number of results for
    a query) is below the maximum value <lengthLimit>

    |  |  |
    | --- | --- |
    | Parameters: | **length** – length value to test |

`enasearch.``check_result`(*result*)[[source]](_modules/enasearch.html#check_result)[¶](#enasearch.check_result "Permalink to this definition")
:   Check if a result id is in the list of possible results accessible on ENA

    This function raises an error if the result is not in the list of possible
    results

    |  |  |
    | --- | --- |
    | Parameters: | **result** – id of result to check |

`enasearch.``check_returnable_fields`(*fields*, *result*)[[source]](_modules/enasearch.html#check_returnable_fields)[¶](#enasearch.check_returnable_fields "Permalink to this definition")
:   Check that some field id correspond to returnable fields for a resut

    This function raises an error if one of the ids is not in the list of possible
    returnable fields for the given result

    |  |  |
    | --- | --- |
    | Parameters: | * **fields** – list of fields to check * **result** – id of the result (partition of ENA db), accessible with get\_results |

`enasearch.``check_sortable_fields`(*fields*, *result*)[[source]](_modules/enasearch.html#check_sortable_fields)[¶](#enasearch.check_sortable_fields "Permalink to this definition")
:   Check that some field id correspond to sortable fields for a resut

    This function raises an error if one of the ids is not in the list of possible
    sortable fields for the given result

    |  |  |
    | --- | --- |
    | Parameters: | * **fields** – list of fields to check * **result** – id of the result (partition of ENA db), accessible with get\_results |

`enasearch.``check_subseq_range`(*subseq\_range*)[[source]](_modules/enasearch.html#check_subseq_range)[¶](#enasearch.check_subseq_range "Permalink to this definition")
:   Check that a range of sequences to extract is well defined

    This function check:

    * The range is correctly built: 2 integer values separated by a -
    * The second value is higher than the first one

    |  |  |
    | --- | --- |
    | Parameters: | **download** – range for subsequences (limit separated by a -) |

`enasearch.``check_taxonomy_result`(*result*)[[source]](_modules/enasearch.html#check_taxonomy_result)[¶](#enasearch.check_taxonomy_result "Permalink to this definition")
:   Check if a result id is in the list of possible results in ENA Taxon Portal

    This function raises an error if the result is not in the list of possible
    taxonomy results

    |  |  |
    | --- | --- |
    | Parameters: | **result** – id of result to check |

`enasearch.``format_seq_content`(*seq\_str*, *out\_format*)[[source]](_modules/enasearch.html#format_seq_content)[¶](#enasearch.format_seq_content "Permalink to this definition")
:   Format a string with sequences into a list of BioPython sequence objects (SeqRecord)

    |  |  |
    | --- | --- |
    | Parameters: | * **seq\_str** – string with sequences to format * **out\_format** – fasta or fastq |
    | Returns: | a list of SeqRecord objects with the sequences in the input string |

`enasearch.``get_display_options`(*verbose=False*)[[source]](_modules/enasearch.html#get_display_options)[¶](#enasearch.get_display_options "Permalink to this definition")
:   Return the possible formats to display the result of a query on ENA

    |  |  |
    | --- | --- |
    | Parameters: | **verbose** – boolean to define the printing info |
    | Returns: | dictionary with the keys being the formats and the values a description of the formats |

`enasearch.``get_download_options`(*verbose=False*)[[source]](_modules/enasearch.html#get_download_options)[¶](#enasearch.get_download_options "Permalink to this definition")
:   Return the options for download of data from ENA

    |  |  |
    | --- | --- |
    | Parameters: | **verbose** – boolean to define the printing info |
    | Returns: | dictionary with the options and the values a description of the options |

`enasearch.``get_filter_fields`(*result*, *verbose=False*)[[source]](_modules/enasearch.html#get_filter_fields)[¶](#enasearch.get_filter_fields "Permalink to this definition")
:   Return the filter fields of a result

    This function returns the fields that can be used to build a query on a
    result on ENA. Each field is described in a dictionary with a short
    description and its type (text, number, etc).

    |  |  |
    | --- | --- |
    | Parameters: | * **result** – id of the result (partition of ENA db), accessible with get\_results * **verbose** – boolean to define the printing info |
    | Returns: | dictionary with the keys being the fields ids and the values dictionary to describe the fields |

`enasearch.``get_filter_types`(*verbose=False*)[[source]](_modules/enasearch.html#get_filter_types)[¶](#enasearch.get_filter_types "Permalink to this definition")
:   Return the filters that can be used for the different type of data in a query on ENA

    This function returns the filters that can be used for the different type of
    data (information available with the information on the filter fileds). For
    each type of data is given the operations applicable and a description of the
    type of expected values

    |  |  |
    | --- | --- |
    | Parameters: | * **result** – id of the result (partition of ENA db), accessible with get\_results * **verbose** – boolean to define the printing info |
    | Returns: | dictionary with the keys being the type of data and the values dictionary to describe the filters for this type of data |

`enasearch.``get_result`(*result*, *verbose=False*)[[source]](_modules/enasearch.html#get_result)[¶](#enasearch.get_result "Permalink to this definition")
:   Return the description of a result (description, returnable and filter fields)

    |  |  |
    | --- | --- |
    | Parameters: | * **result** – id of the result (partition of ENA db), accessible with get\_results * **verbose** – boolean to define the printing info |
    | Returns: | dictionary with a description of the result, the list of returnable fields and a dictionnary with the filter fields |

`enasearch.``get_results`(*verbose=True*)[[source]](_modules/enasearch.html#get_results)[¶](#enasearch.get_results "Permalink to this definition")
:   Return the possible results (type of data) in ENA (other than taxonomy)

    Each result is described in a dictionary with a description of the result,
    the list of returnable fields associated with the result and a dictionnary
    with the filter fields associated with the result

    |  |  |
    | --- | --- |
    | Parameters: | **verbose** – boolean to define the printing info |
    | Returns: | a dictionary with the keys being the result ids and the values dictionary to describe the results |

`enasearch.``get_returnable_fields`(*result*, *verbose=False*)[[source]](_modules/enasearch.html#get_returnable_fields)[¶](#enasearch.get_returnable_fields "Permalink to this definition")
:   Return the returnable fields of a result

    This function returns the list of fields that can be extracted for a result
    in a query on ENA

    |  |  |
    | --- | --- |
    | Parameters: | * **result** – id of the result (partition of ENA db), accessible with get\_results * **verbose** – boolean to define the printing info |
    | Returns: | list of fields that can be extracted for a result |

`enasearch.``get_search_result_number`(*free\_text\_search*, *query*, *result*, *need\_check\_result=True*)[[source]](_modules/enasearch.html#get_search_result_number)[¶](#enasearch.get_search_result_number "Permalink to this definition")
:   Get the number of results for a query on a result

    This function builds a query on ENA to extract the number of results
    matching the query on ENA

    |  |  |
    | --- | --- |
    | Parameters: | * **free\_text\_search** – boolean to describe the type of query * **query** – query string, made up of filtering conditions, joined by logical ANDs, ORs and NOTs and bound by double quotes * **result** – id of the result (partition of ENA db), accessible with get\_results |
    | Returns: | an integer corresponding to the number of results of a query on ENA |

`enasearch.``get_search_url`(*free\_text\_search*)[[source]](_modules/enasearch.html#get_search_url)[¶](#enasearch.get_search_url "Permalink to this definition")
:   Get the prefix for the URL to search ENA database

    |  |  |
    | --- | --- |
    | Parameters: | **free\_text\_search** – boolean to describe the type of query |
    | Returns: | a string with the prefix of an URL to search ENA database |

`enasearch.``get_sortable_fields`(*result*, *verbose=False*)[[source]](_modules/enasearch.html#get_sortable_fields)[¶](#enasearch.get_sortable_fields "Permalink to this definition")
:   Return the sortable fields of a result

    This function returns the fields that can be used to sort the output of a
    query for a result on ENA. Each field is described in a dictionary with a
    short description and its type (text, number, etc).

    |  |  |
    | --- | --- |
    | Parameters: | * **result** – id of the result (partition of ENA db), accessible with get\_results * **verbose** – boolean to define the printing info |
    | Returns: | dictionary with the keys being the fields ids and the values dictionary to describe the fields |

`enasearch.``get_taxonomy_results`(*verbose=False*)[[source]](_modules/enasearch.html#get_taxonomy_results)[¶](#enasearch.get_taxonomy_results "Permalink to this definition")
:   Return description about the possible results accessible via the taxon portal.

    Each taxonomy result is described with a short description.

    |  |  |
    | --- | --- |
    | Parameters: | **verbose** – boolean to define the printing info |
    | Returns: | a dictionary with the keys being the result ids and the values dictionary to describe the results |

`enasearch.``load_object`(*filepath*)[[source]](_modules/enasearch.html#load_object)[¶](#enasearch.load_object "Permalink to this definition")
:   Load object from a pickle file

    |  |  |
    | --- | --- |
    | Parameters: | **filepath** – path to pickle file with serialized data |

`enasearch.``request_url`(*url*, *display*, *file=None*)[[source]](_modules/enasearch.html#request_url)[¶](#enasearch.request_url "Permalink to this definition")
:   Run the URL request and return content or status

    This function tooks an URL built to query or extract data from ENA and apply
    this URL. If a filepath is given, the function puts the result into the
    file and returns the status of the request. Otherwise, the results of the
    request is returned by the function in different format depending of the
    display format

    |  |  |
    | --- | --- |
    | Parameters: | * **url** – URL to request on ENA * **display** – display option * **length** – number of records to retrieve * **file** – filepath to save the content of the search |
    | Returns: | status of the request or the result of the request (in different format) |

`enasearch.``retrieve_analysis_report`(*accession*, *fields=None*, *file=None*)[[source]](_modules/enasearch.html#retrieve_analysis_