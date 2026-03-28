[amdirt](index.html)

Contents:

* [Install](README.html)
* [Cite](README.html#cite)
* [More information](README.html#more-information)
* [Tutorials](tutorials/index.html)
* [How Tos](how_to/index.html)
* [Quick Reference](reference.html)
* Python API
  + [Dataset Validation](#dataset-validation)
    - [`AMDirValidator`](#amdirt.validate.application.AMDirValidator)
      * [`AMDirValidator.__init__()`](#amdirt.validate.application.AMDirValidator.__init__)
      * [`AMDirValidator.__repr__()`](#amdirt.validate.application.AMDirValidator.__repr__)
      * [`AMDirValidator.__weakref__`](#amdirt.validate.application.AMDirValidator.__weakref__)
      * [`AMDirValidator.check_columns()`](#amdirt.validate.application.AMDirValidator.check_columns)
      * [`AMDirValidator.check_duplicate_rows()`](#amdirt.validate.application.AMDirValidator.check_duplicate_rows)
      * [`AMDirValidator.check_multi_values()`](#amdirt.validate.application.AMDirValidator.check_multi_values)
      * [`AMDirValidator.check_sample_accession()`](#amdirt.validate.application.AMDirValidator.check_sample_accession)
      * [`AMDirValidator.cleanup_errors()`](#amdirt.validate.application.AMDirValidator.cleanup_errors)
      * [`AMDirValidator.dataset_to_json()`](#amdirt.validate.application.AMDirValidator.dataset_to_json)
      * [`AMDirValidator.read_dataset()`](#amdirt.validate.application.AMDirValidator.read_dataset)
      * [`AMDirValidator.read_schema()`](#amdirt.validate.application.AMDirValidator.read_schema)
      * [`AMDirValidator.to_markdown()`](#amdirt.validate.application.AMDirValidator.to_markdown)
      * [`AMDirValidator.to_rich()`](#amdirt.validate.application.AMDirValidator.to_rich)
      * [`AMDirValidator.validate_schema()`](#amdirt.validate.application.AMDirValidator.validate_schema)
  + [Dataset conversion](#dataset-conversion)
    - [`run_convert()`](#amdirt.convert.run_convert)
  + [Dataset viewing/filtering](#dataset-viewing-filtering)
    - [`run_app()`](#amdirt.viewer.run_app)
  + [Autofill](#autofill)
    - [`run_autofill()`](#amdirt.autofill.run_autofill)
  + [Merge](#merge)
    - [`merge_new_df()`](#amdirt.merge.merge_new_df)
  + [ENA API](#ena-api)
    - [`ENAPortalAPI`](#amdirt.core.ena.ENAPortalAPI)
      * [`ENAPortalAPI.__get_json__()`](#amdirt.core.ena.ENAPortalAPI.__get_json__)
      * [`ENAPortalAPI.__init__()`](#amdirt.core.ena.ENAPortalAPI.__init__)
      * [`ENAPortalAPI.__repr__()`](#amdirt.core.ena.ENAPortalAPI.__repr__)
      * [`ENAPortalAPI.__weakref__`](#amdirt.core.ena.ENAPortalAPI.__weakref__)
      * [`ENAPortalAPI.doc()`](#amdirt.core.ena.ENAPortalAPI.doc)
      * [`ENAPortalAPI.list_fields()`](#amdirt.core.ena.ENAPortalAPI.list_fields)
      * [`ENAPortalAPI.list_results()`](#amdirt.core.ena.ENAPortalAPI.list_results)
      * [`ENAPortalAPI.query()`](#amdirt.core.ena.ENAPortalAPI.query)
      * [`ENAPortalAPI.status()`](#amdirt.core.ena.ENAPortalAPI.status)
    - [`ENABrowserAPI`](#amdirt.core.ena.ENABrowserAPI)
      * [`ENABrowserAPI.__get_json__()`](#amdirt.core.ena.ENABrowserAPI.__get_json__)
      * [`ENABrowserAPI.__init__()`](#amdirt.core.ena.ENABrowserAPI.__init__)
      * [`ENABrowserAPI.__repr__()`](#amdirt.core.ena.ENABrowserAPI.__repr__)
      * [`ENABrowserAPI.__weakref__`](#amdirt.core.ena.ENABrowserAPI.__weakref__)
      * [`ENABrowserAPI.doc()`](#amdirt.core.ena.ENABrowserAPI.doc)
      * [`ENABrowserAPI.status()`](#amdirt.core.ena.ENABrowserAPI.status)

[amdirt](index.html)

* Python API
* [View page source](_sources/API.rst.txt)

---

# Python API[](#python-api "Link to this heading")

## Dataset Validation[](#dataset-validation "Link to this heading")

class amdirt.validate.application.AMDirValidator(*schema: AnyStr | BinaryIO | TextIO*, *dataset: AnyStr | BinaryIO | TextIO*)[[source]](_modules/amdirt/validate/application.html#AMDirValidator)[](#amdirt.validate.application.AMDirValidator "Link to this definition")
:   Bases: `DatasetValidator`

    Validator Class for AncientMetagenomeDir datasets

    \_\_init\_\_(*schema: AnyStr | BinaryIO | TextIO*, *dataset: AnyStr | BinaryIO | TextIO*)[](#amdirt.validate.application.AMDirValidator.__init__ "Link to this definition")
    :   Dataset validation class

        errors[](#amdirt.validate.application.AMDirValidator.errors "Link to this definition")
        :   List of DFError objects

            Type:
            :   list

        dataset\_name[](#amdirt.validate.application.AMDirValidator.dataset_name "Link to this definition")
        :   Dataset name

            Type:
            :   str

        schema\_name[](#amdirt.validate.application.AMDirValidator.schema_name "Link to this definition")
        :   Schema name

            Type:
            :   str

        schema[](#amdirt.validate.application.AMDirValidator.schema "Link to this definition")
        :   JSON schema

            Type:
            :   dict

        dataset[](#amdirt.validate.application.AMDirValidator.dataset "Link to this definition")
        :   Dataset as pandas dataframe

            Type:
            :   pd.DataFrame

        dataset\_json[](#amdirt.validate.application.AMDirValidator.dataset_json "Link to this definition")
        :   Dataset as dictionary

            Type:
            :   dict

        Parameters:
        :   * **schema** (*Schema*) – Path to schema in json format
            * **dataset** (*Dataset*) – Path to dataset in tsv format

    \_\_repr\_\_()[](#amdirt.validate.application.AMDirValidator.__repr__ "Link to this definition")
    :   Return repr(self).

    \_\_weakref\_\_[](#amdirt.validate.application.AMDirValidator.__weakref__ "Link to this definition")
    :   list of weak references to the object

    check\_columns() → bool[](#amdirt.validate.application.AMDirValidator.check_columns "Link to this definition")
    :   Checks if dataset has all required columns

        Returns:
        :   True if dataset has all required columns, False otherwise

        Return type:
        :   bool

    check\_duplicate\_rows() → bool[](#amdirt.validate.application.AMDirValidator.check_duplicate_rows "Link to this definition")
    :   Checks for duplicated rows in dataset

        Returns:
        :   True if dataset has no duplicated rows, False otherwise

        Return type:
        :   bool

    check\_multi\_values(*column\_names: Iterable[str] = ['archive\_accession']*) → bool[[source]](_modules/amdirt/validate/application.html#AMDirValidator.check_multi_values)[](#amdirt.validate.application.AMDirValidator.check_multi_values "Link to this definition")
    :   Check for duplicates entries in multi values column
        :param column\_names: List of multi values columns to check for duplications. Defaults to [“archive\_accession”].
        :type column\_names: Iterable[str], optional

    check\_sample\_accession(*remote: AnyStr | None = None*) → bool[[source]](_modules/amdirt/validate/application.html#AMDirValidator.check_sample_accession)[](#amdirt.validate.application.AMDirValidator.check_sample_accession "Link to this definition")
    :   Check that sample accession are valid

        Parameters:
        :   **remote** (*AnyStr* *|* *None**,* *optional*) – Remote to check against. Defaults to None.

    cleanup\_errors(*error: ValidationError*) → DFError[](#amdirt.validate.application.AMDirValidator.cleanup_errors "Link to this definition")
    :   Cleans up JSON schema validation errors

        Parameters:
        :   **error** (*json\_exceptions.ValidationError*) – JSON schema validation error

        Returns:
        :   Cleaned DataFrame error

        Return type:
        :   DFError

    dataset\_to\_json() → dict[](#amdirt.validate.application.AMDirValidator.dataset_to_json "Link to this definition")
    :   Convert dataset from Pandas DataFrame to JSON

        Returns:
        :   Dataset as dictionary

        Return type:
        :   dict

    read\_dataset(*dataset: AnyStr | BinaryIO | TextIO*, *schema: dict*) → DataFrame[](#amdirt.validate.application.AMDirValidator.read_dataset "Link to this definition")
    :   “Read dataset from file or string
        :param dataset: Path to dataset in tsv format
        :type dataset: str
        :param schema: Parsed schema as dictionary (from read\_schema)
        :type schema: dict

        Returns:
        :   Dataset as pandas dataframe

        Return type:
        :   pd.DataFrame

    read\_schema(*schema: AnyStr | BinaryIO | TextIO*) → dict[](#amdirt.validate.application.AMDirValidator.read_schema "Link to this definition")
    :   Read JSON schema from file or string

        Parameters:
        :   **schema** (*str*) – Path to schema in json format

        Returns:
        :   JSON schema

        Return type:
        :   dict

    to\_markdown() → bool[](#amdirt.validate.application.AMDirValidator.to_markdown "Link to this definition")
    :   Generate markdown output table for github display

        Returns:
        :   True if dataset is valid

        Return type:
        :   bool

        Raises:
        :   **SystemExit** – If dataset is invalid

    to\_rich()[](#amdirt.validate.application.AMDirValidator.to_rich "Link to this definition")
    :   Generate rich output table for console display

        Returns:
        :   True if dataset is valid

        Return type:
        :   bool

        Raises:
        :   **SystemExit** – If dataset is invalid

    validate\_schema() → bool[](#amdirt.validate.application.AMDirValidator.validate_schema "Link to this definition")
    :   Validate dataset against JSON schema

        Returns:
        :   True if dataset is valid, False otherwise

        Return type:
        :   bool

## Dataset conversion[](#dataset-conversion "Link to this heading")

amdirt.convert.run\_convert(*samples*, *libraries*, *table\_name*, *tables=None*, *output='.'*, *bibliography=False*, *dates=False*, *librarymetadata=False*, *curl=False*, *aspera=False*, *eager=False*, *fetchngs=False*, *sratoolkit=False*, *ameta=False*, *taxprofiler=False*, *mag=False*, *verbose=False*)[[source]](_modules/amdirt/convert.html#run_convert)[](#amdirt.convert.run_convert "Link to this definition")
:   Run the amdirt conversion application to input samplesheet tables for different pipelines

    Parameters:
    :   * **samples** (*str*) – Path to AncientMetagenomeDir filtered samples tsv file
        * **libraries** (*str*) – Optional path to AncientMetagenomeDir pre-filtered libraries tsv file
        * **table\_name** (*str*) – Name of the table of the table to convert
        * **tables** (*str*) – Path to JSON file listing tables
        * **output** (*str*) – Path to output table. Defaults to “.”

## Dataset viewing/filtering[](#dataset-viewing-filtering "Link to this heading")

amdirt.viewer.run\_app(*tables=None*, *verbose=False*)[[source]](_modules/amdirt/viewer.html#run_app)[](#amdirt.viewer.run_app "Link to this definition")
:   Run the amdirt interactive filtering application

    Parameters:
    :   **tables** (*str*) – path to JSON file listing AncientMetagenomeDir tables

## Autofill[](#autofill "Link to this heading")

amdirt.autofill.run\_autofill(*accession*, *table\_name=None*, *schema=None*, *dataset=None*, *sample\_output=None*, *library\_output=None*, *verbose=False*, *output\_ena\_table=None*)[[source]](_modules/amdirt/autofill.html#run_autofill)[](#amdirt.autofill.run_autofill "Link to this definition")
:   Autofill the metadata of a table from ENA

    Parameters:
    :   * **accession** (*tuple**(**str**)*) – ENA project accession. Multiple accessions can be space separated (e.g. PRJNA123 PRJNA456)
        * **table\_name** (*str*) – Name of the table to be filled
        * **schema** (*str*) – Path to the schema file
        * **dataset** (*str*) – Path to the dataset file
        * **sample\_output** (*str*) – Path to the sample output table file
        * **library\_output** (*str*) – Path to the library output table file

    Returns:
    :   ENA metadata run level table

    Return type:
    :   pd.DataFrame

## Merge[](#merge "Link to this heading")

amdirt.merge.merge\_new\_df(*dataset*, *table\_type*, *table\_name*, *markdown*, *outdir*, *verbose*, *schema\_check=True*, *line\_dup=True*, *columns=True*)[[source]](_modules/amdirt/merge.html#merge_new_df)[](#amdirt.merge.merge_new_df "Link to this definition")
:   Merge a new dataset with the remote master dataset

    Parameters:
    :   * **dataset** (*Path*) – Path to new dataset
        * **table\_type** (*str*) – Type of table to merge (samples or libraries)
        * **table\_name** (*str*) – Kind of table to merge (e.g. ancientmetagenome-hostassociated, ancientmetagenome-environmental, etc.)
        * **markdown** (*bool*) – Log in markdown format
        * **outdir** (*Path*) – Path to output directory
        * **verbose** (*bool*) – Enable verbose mode
        * **schema\_check** (*bool**,* *optional*) – Enable schema check. Defaults to True.
        * **line\_dup** (*bool**,* *optional*) – Enable line duplication check. Defaults to True.
        * **columns** (*bool**,* *optional*) – Enable columns presence/absence check. Defaults to True.

    Raises:
    :   * **ValueError** – Table type must be either ‘samples’ or ‘libraries’
        * **ValueError** – Table name not found in AncientMetagenomeDir file
        * **DatasetValidationError** – New dataset is not valid

## ENA API[](#ena-api "Link to this heading")

class amdirt.core.ena.ENAPortalAPI[[source]](_modules/amdirt/core/ena.html#ENAPortalAPI)[](#amdirt.core.ena.ENAPortalAPI "Link to this definition")
:   Bases: `ENA`

    Class to interact with the ENA Portal API

    \_\_get\_json\_\_(*url: str*) → List[Dict][](#amdirt.core.ena.ENAPortalAPI.__get_json__ "Link to this definition")
    :   Get json content from URL

        Parameters:
        :   **url** (*str*) – URL to get json content from

        Returns:
        :   json content

        Return type:
        :   List[Dict]

    \_\_init\_\_() → None[[source]](_modules/amdirt/core/ena.html#ENAPortalAPI.__init__)[](#amdirt.core.ena.ENAPortalAPI.__init__ "Link to this definition")
    :   ENA Portal API class

        base\_url[](#amdirt.core.ena.ENAPortalAPI.base_url "Link to this definition")
        :   base URL for ENA Portal API

            Type:
            :   str

    \_\_repr\_\_() → str[](#amdirt.core.ena.ENAPortalAPI.__repr__ "Link to this definition")
    :   Display URL of API documentation

    \_\_weakref\_\_[](#amdirt.core.ena.ENAPortalAPI.__weakref__ "Link to this definition")
    :   list of weak references to the object

    doc(*dir: str = '.'*) → None[](#amdirt.core.ena.ENAPortalAPI.doc "Link to this definition")
    :   Get PDF documentation for API

        Parameters:
        :   **dir** (*str*) – path to output PDF directory

    list\_fields(*result\_type: str*) → None[[source]](_modules/amdirt/core/ena.html#ENAPortalAPI.list_fields)[](#amdirt.core.ena.ENAPortalAPI.list_fields "