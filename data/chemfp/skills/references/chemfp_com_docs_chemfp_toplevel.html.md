[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* [Command-line examples for sparse count fingerprints](count_tools.html)
* [The chemfp command-line tools](tool_help.html)
* [Getting started with the API](getting_started_api.html)
* [Fingerprint family and type examples](fingerprint_types.html)
* [Toolkit API examples](toolkit.html)
* [Text toolkit examples](text_toolkit.html)
* [chemfp API](chemfp_api.html)
  + chemfp top-level
    - [`cdk`](#chemfp.cdk)
    - [`openeye`](#chemfp.openeye)
    - [`openbabel`](#chemfp.openbabel)
    - [`rdkit`](#chemfp.rdkit)
    - [`__version__`](#chemfp.__version__)
    - [`__version_info__`](#chemfp.__version_info__)
    - [`SOFTWARE`](#chemfp.SOFTWARE)
    - [`ChemFPError`](#chemfp.ChemFPError)
    - [`ChemFPProblem`](#chemfp.ChemFPProblem)
      * [`ChemFPProblem.severity`](#chemfp.ChemFPProblem.severity)
      * [`ChemFPProblem.error_level`](#chemfp.ChemFPProblem.error_level)
      * [`ChemFPProblem.category`](#chemfp.ChemFPProblem.category)
      * [`ChemFPProblem.description`](#chemfp.ChemFPProblem.description)
    - [`EncodingError`](#chemfp.EncodingError)
    - [`FingerprintIterator`](#chemfp.FingerprintIterator)
      * [`FingerprintIterator.close()`](#chemfp.FingerprintIterator.close)
    - [`FingerprintReader`](#chemfp.FingerprintReader)
      * [`FingerprintReader.get_fingerprint_type()`](#chemfp.FingerprintReader.get_fingerprint_type)
      * [`FingerprintReader.iter_arenas()`](#chemfp.FingerprintReader.iter_arenas)
      * [`FingerprintReader.load()`](#chemfp.FingerprintReader.load)
      * [`FingerprintReader.save()`](#chemfp.FingerprintReader.save)
    - [`FingerprintWriter`](#chemfp.FingerprintWriter)
      * [`FingerprintWriter.metadata`](#chemfp.FingerprintWriter.metadata)
      * [`FingerprintWriter.format`](#chemfp.FingerprintWriter.format)
      * [`FingerprintWriter.closed`](#chemfp.FingerprintWriter.closed)
      * [`FingerprintWriter.close()`](#chemfp.FingerprintWriter.close)
      * [`FingerprintWriter.write_fingerprint()`](#chemfp.FingerprintWriter.write_fingerprint)
      * [`FingerprintWriter.write_fingerprints()`](#chemfp.FingerprintWriter.write_fingerprints)
    - [`Fingerprints`](#chemfp.Fingerprints)
    - [`Metadata`](#chemfp.Metadata)
      * [`Metadata.num_bits`](#chemfp.Metadata.num_bits)
      * [`Metadata.num_bytes`](#chemfp.Metadata.num_bytes)
      * [`Metadata.type`](#chemfp.Metadata.type)
      * [`Metadata.aromaticity`](#chemfp.Metadata.aromaticity)
      * [`Metadata.software`](#chemfp.Metadata.software)
      * [`Metadata.sources`](#chemfp.Metadata.sources)
      * [`Metadata.date`](#chemfp.Metadata.date)
      * [`Metadata.copy()`](#chemfp.Metadata.copy)
    - [`ParseError`](#chemfp.ParseError)
      * [`ParseError.msg`](#chemfp.ParseError.msg)
      * [`ParseError.location`](#chemfp.ParseError.location)
    - [`butina()`](#chemfp.butina)
    - [`cdk2fps()`](#chemfp.cdk2fps)
    - [`check_fingerprint_problems()`](#chemfp.check_fingerprint_problems)
    - [`check_metadata_problems()`](#chemfp.check_metadata_problems)
    - [`convert2fps()`](#chemfp.convert2fps)
    - [`count_tanimoto_hits()`](#chemfp.count_tanimoto_hits)
    - [`count_tanimoto_hits_symmetric()`](#chemfp.count_tanimoto_hits_symmetric)
    - [`count_tversky_hits()`](#chemfp.count_tversky_hits)
    - [`count_tversky_hits_symmetric()`](#chemfp.count_tversky_hits_symmetric)
    - [`get_default_progressbar()`](#chemfp.get_default_progressbar)
    - [`get_fingerprint_families()`](#chemfp.get_fingerprint_families)
    - [`get_fingerprint_family()`](#chemfp.get_fingerprint_family)
    - [`get_fingerprint_family_names()`](#chemfp.get_fingerprint_family_names)
    - [`get_fingerprint_type()`](#chemfp.get_fingerprint_type)
    - [`get_fingerprint_type_from_text_settings()`](#chemfp.get_fingerprint_type_from_text_settings)
    - [`get_metadata_from_source()`](#chemfp.get_metadata_from_source)
    - [`get_num_threads()`](#chemfp.get_num_threads)
    - [`get_omp_num_threads()`](#chemfp.get_omp_num_threads)
    - [`get_toolkit()`](#chemfp.get_toolkit)
    - [`get_toolkit_names()`](#chemfp.get_toolkit_names)
    - [`has_fingerprint_family()`](#chemfp.has_fingerprint_family)
    - [`has_toolkit()`](#chemfp.has_toolkit)
    - [`heapsweep()`](#chemfp.heapsweep)
    - [`knearest_tanimoto_search()`](#chemfp.knearest_tanimoto_search)
    - [`knearest_tanimoto_search_symmetric()`](#chemfp.knearest_tanimoto_search_symmetric)
    - [`knearest_tversky_search()`](#chemfp.knearest_tversky_search)
    - [`knearest_tversky_search_symmetric()`](#chemfp.knearest_tversky_search_symmetric)
    - [`load_fingerprints()`](#chemfp.load_fingerprints)
    - [`load_fingerprints_from_string()`](#chemfp.load_fingerprints_from_string)
    - [`load_simarray()`](#chemfp.load_simarray)
    - [`maxmin()`](#chemfp.maxmin)
    - [`ob2fps()`](#chemfp.ob2fps)
    - [`oe2fps()`](#chemfp.oe2fps)
    - [`open()`](#chemfp.open)
    - [`open_fingerprint_writer()`](#chemfp.open_fingerprint_writer)
    - [`open_from_string()`](#chemfp.open_from_string)
    - [`rdkit2fps()`](#chemfp.rdkit2fps)
    - [`read_count_fingerprints()`](#chemfp.read_count_fingerprints)
    - [`read_count_fingerprints_from_string()`](#chemfp.read_count_fingerprints_from_string)
    - [`read_molecule_fingerprints()`](#chemfp.read_molecule_fingerprints)
    - [`read_molecule_fingerprints_from_string()`](#chemfp.read_molecule_fingerprints_from_string)
    - [`sdf2fps()`](#chemfp.sdf2fps)
    - [`set_default_progressbar()`](#chemfp.set_default_progressbar)
    - [`set_num_threads()`](#chemfp.set_num_threads)
    - [`simarray()`](#chemfp.simarray)
    - [`simhistogram()`](#chemfp.simhistogram)
    - [`simsearch()`](#chemfp.simsearch)
    - [`spherex()`](#chemfp.spherex)
    - [`threshold_tanimoto_search()`](#chemfp.threshold_tanimoto_search)
    - [`threshold_tanimoto_search_symmetric()`](#chemfp.threshold_tanimoto_search_symmetric)
    - [`threshold_tversky_search()`](#chemfp.threshold_tversky_search)
    - [`threshold_tversky_search_symmetric()`](#chemfp.threshold_tversky_search_symmetric)
  + [chemfp.arena](chemfp_arena.html)
  + [chemfp.base\_toolkit](chemfp_base_toolkit.html)
  + [chemfp.bitops](chemfp_bitops.html)
  + [chemfp.cdk\_toolkit](chemfp_cdk_toolkit.html)
  + [chemfp.cdk\_types](chemfp_cdk_types.html)
  + [chemfp.clustering](chemfp_clustering.html)
  + [chemfp.countops module](chemfp_countops.html)
  + [Core count fingerprint datatypes](chemfp_countops.html#core-count-fingerprint-datatypes)
  + [Parse a string to create a count fingerprint](chemfp_countops.html#parse-a-string-to-create-a-count-fingerprint)
  + [Create a string given a count fingerprint](chemfp_countops.html#create-a-string-given-a-count-fingerprint)
  + [Convert a count fingerprint to a byte fingerprint](chemfp_countops.html#convert-a-count-fingerprint-to-a-byte-fingerprint)
  + [Functions which work on count fingerprints](chemfp_countops.html#functions-which-work-on-count-fingerprints)
  + [Work with RDKit fingerprint binary strings](chemfp_countops.html#work-with-rdkit-fingerprint-binary-strings)
  + [chemfp.csv\_readers](chemfp_csv_readers.html)
  + [chemfp.diversity](chemfp_diversity.html)
  + [chemfp.encodings](chemfp_encodings.html)
  + [chemfp.fpb\_io](chemfp_fpb_io.html)
  + [chemfp.fps\_io](chemfp_fps_io.html)
  + [chemfp.fps\_search](chemfp_fps_search.html)
  + [chemfp.highlevel.arena\_tools](chemfp_highlevel_arena_tools.html)
  + [chemfp.highlevel.clustering](chemfp_highlevel_clustering.html)
  + [chemfp.highlevel.conversion](chemfp_highlevel_conversion.html)
  + [chemfp.highlevel.diversity](chemfp_highlevel_diversity.html)
  + [chemfp.highlevel.simarray](chemfp_highlevel_simarray.html)
  + [chemfp.highlevel.similarity](chemfp_highlevel_similarity.html)
  + [chemfp.io](chemfp_io.html)
  + [chemfp.jcmapper\_types](chemfp_jcmapper_types.html)
  + [chemfp.openbabel\_toolkit](chemfp_openbabel_toolkit.html)
  + [chemfp.openbabel\_types](chemfp_openbabel_types.html)
  + [chemfp.openeye\_toolkit](chemfp_openeye_toolkit.html)
  + [chemfp.openeye\_types](chemfp_openeye_types.html)
  + [chemfp.rdkit\_toolkit](chemfp_rdkit_toolkit.html)
  + [chemfp.rdkit\_types](chemfp_rdkit_types.html)
  + [chemfp.search](chemfp_search.html)
  + [chemfp.simarray\_io](chemfp_simarray_io.html)
  + [chemfp.text\_records](chemfp_text_records.html)
  + [chemfp.text\_toolkit](chemfp_text_toolkit.html)
  + [chemfp.toolkit](chemfp_toolkit.html)
  + [chemfp.types](chemfp_types.html)
  + [Overview](chemfp_api.html#overview)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* [chemfp API](chemfp_api.html)
* Top-level API

---

# Top-level API[](#top-level-api "Link to this heading")

The following functions and classes are in the top-level chemfp
module. See [Getting started with the API](getting_started_api.html#getting-started-api) for examples.

chemfp.cdk[](#chemfp.cdk "Link to this definition")
:   This is a special object which forwards any use to the
    [`chemfp.cdk_toolkit`](chemfp_cdk_toolkit.html#module-chemfp.cdk_toolkit "chemfp.cdk_toolkit"). It imports the underlying module
    as-needed so may raise an ImportError. It is designed to be used
    as `chemfp.cdk`, like the following:

    ```
    import chemfp
    fp = chemfp.cdk.pubchem.from_smiles("CCO")
    ```

    Please do not import “cdk” directly into your module as you are
    likely to get confused with CDK’s own “cdk” module. Instead,
    use one of the following:

    ```
    from chemfp import cdk_toolkit
    from chemfp import cdk_toolkit as T
    ```

chemfp.openeye[](#chemfp.openeye "Link to this definition")
:   This is a special object which forwards any use to the
    [`chemfp.openeye_toolkit`](chemfp_openeye_toolkit.html#module-chemfp.openeye_toolkit "chemfp.openeye_toolkit"). It imports the underlying
    toolkit module as-needed so may raise an ImportError. It is
    designed to be used as `chemfp.openeye`, like the following:

    ```
    import chemfp
    fp = chemfp.openeye.circular.from_smiles("CCO")
    ```

    Please do not import “openeye” directly into your module as you
    are likely to get confused with OpenEye’s own “openeye”
    module. Instead, use one of the following:

    ```
    from chemfp import openeye_toolkit
    from chemfp import openeye_toolkit as T
    ```

chemfp.openbabel[](#chemfp.openbabel "Link to this definition")
:   This is a special object which forwards to the
    [`chemfp.openbabel_toolkit`](chemfp_openbabel_toolkit.html#module-chemfp.openbabel_toolkit "chemfp.openbabel_toolkit"). It imports the underlying
    toolkit module as-needed so may raise an ImportError. It is
    designed to be used as `chemfp.openbabel`, like the following:

    ```
    import chemfp
    fp = chemfp.openbabel.fp2.from_smiles("CCO")
    ```

    Please do not import “openbabel” directly into your module as
    you are likely to get confused with Open Babel’s own “openbabel”
    modules. Instead, use one of the following:

    ```
    from chemfp import openbabel_toolkit
    from chemfp import openbabel_toolkit as T
    ```

chemfp.rdkit[](#chemfp.rdkit "Link to this definition")
:   This is a special object which forwards to the
    [`chemfp.rdkit_toolkit`](chemfp_rdkit_toolkit.html#module-chemfp.rdkit_toolkit "chemfp.rdkit_toolkit"). It imports the underlying toolkit
    module as-needed so may raise an ImportError. It is designed to
    be used as `chemfp.rdkit`, like the following:

    ```
    import chemfp
    fp = chemfp.rdkit.morgan(fpSize=128).from_smiles("CCO")
    ```

    Please do not import “rdkit” directly into your module as you are
    likely to get confused with CDK’s own “rdkit” module. Instead,
    use one of the following:

    ```
    from chemfp import rdkit_toolkit
    from chemfp import rdkit_toolkit as T
    ```

chemfp.\_\_version\_\_[](#chemfp.__version__ "Link to this definition")
:   A string describing this version of chemfp. For example, “4.2”.

chemfp.\_\_version\_info\_\_[](#chemfp.__version_info__ "Link to this definition")
:   A 3-element tuple of integers containing the (major version, minor
    version, micro version) of this version of chemfp. For example,
    (4, 2, 0).

chemfp.SOFTWARE[](#chemfp.SOFTWARE "Link to this definition")
:   The value of the string used in output file metadata to describe
    this version of chemfp. For example, “chemfp/4.2 (base license)”.

exception chemfp.ChemFPError[](#chemfp.ChemFPError "Link to this definition")
:   Bases: `Exception`

    Base class for all of the chemfp exceptions

exception chemfp.ChemFPProblem(*severity: Literal['info', 'warning', 'error']*, *category: str*, *description: str*)[](#chemfp.ChemFPProblem "Link to this definition")
:   Bases: [`ChemFPError`](#chemfp.ChemFPError "chemfp.ChemFPError")

    Information about a compatibility problem between a query and target.

    Instances are generated by [`chemfp.check_fingerprint_problems()`](#chemfp.check_fingerprint_problems "chemfp.check_fingerprint_problems")
    and [`chemfp.check_metadata_problems()`](#chemfp.check_metadata_problems "chemfp.check_metadata_problems").

    The public attributes are:

    severity: str[](#chemfp.ChemFPProblem.severity "Link to this definition")
    :   One of “info”, “warning”, or “error”.

    error\_level: int[](#chemfp.ChemFPProblem.error_level "Link to this definition")
    :   5 for “info”, 10 for “warning”, and 20 for “error”

    category: str[](#chemfp.ChemFPProblem.category "Link to this definition")
    :   A category name. This string will not change over time.

        The current category names are:
        :   * “num\_bits mismatch” (error)
            * “num\_bytes\_mismatch” (error)
            * “type mismatch” (warning)
            * “aromaticity mismatch” (info)
            * “software mismatch” (info)

    description: str[](#chemfp.ChemFPProblem.description "Link to this definition")
    :   A more detailed description of the error, including details of
        the mismatch. The description depends on *query\_name* and
        *target\_name* and may change over time.

exception chemfp.EncodingError[](#chemfp.EncodingError "Link to this definition")
:   Bases: [`ChemFPError`](#chemfp.ChemFPError "chemfp.ChemFPError"), `ValueError`

    Exception raised when the encoding or the encoding\_error is unsupported or unknown

class chemfp.FingerprintIterator(*metadata: [Metadata](#chemfp.Metadata "chemfp.Metadata")*, *id\_fp\_iterator: \_typing.IdAndFingerprintIter*, *location: \_typing.OptionalLocation = None*, *close: \_Optional[\_typing.CloseType] = None*)[](#chemfp.FingerprintIterator "Link to this definitio