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
* chemfp API
  + [chemfp top-level](chemfp_toplevel.html)
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
  + [Overview](#overview)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1b1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* chemfp API

---

# chemfp API[](#chemfp-api "Link to this heading")

This chapter contains the docstrings for the public portion of the
chemfp API. Chemfp also has internal modules and functions that should
not be imported or used directly. If you use parts of the undocumented
API then your code is more likely to break with newer chemfp releases.

See “[Getting started with the API](getting_started_api.html#getting-started-api)” for some introductory examples.

* [chemfp top-level](chemfp_toplevel.html)
* [chemfp.arena](chemfp_arena.html)
* [chemfp.base\_toolkit](chemfp_base_toolkit.html)
* [chemfp.bitops](chemfp_bitops.html)
* [chemfp.cdk\_toolkit](chemfp_cdk_toolkit.html)
* [chemfp.cdk\_types](chemfp_cdk_types.html)
* [chemfp.clustering](chemfp_clustering.html)
* [chemfp.countops module](chemfp_countops.html)
* [Core count fingerprint datatypes](chemfp_countops.html#core-count-fingerprint-datatypes)
* [Parse a string to create a count fingerprint](chemfp_countops.html#parse-a-string-to-create-a-count-fingerprint)
* [Create a string given a count fingerprint](chemfp_countops.html#create-a-string-given-a-count-fingerprint)
* [Convert a count fingerprint to a byte fingerprint](chemfp_countops.html#convert-a-count-fingerprint-to-a-byte-fingerprint)
* [Functions which work on count fingerprints](chemfp_countops.html#functions-which-work-on-count-fingerprints)
* [Work with RDKit fingerprint binary strings](chemfp_countops.html#work-with-rdkit-fingerprint-binary-strings)
* [chemfp.csv\_readers](chemfp_csv_readers.html)
* [chemfp.diversity](chemfp_diversity.html)
* [chemfp.encodings](chemfp_encodings.html)
* [chemfp.fpb\_io](chemfp_fpb_io.html)
* [chemfp.fps\_io](chemfp_fps_io.html)
* [chemfp.fps\_search](chemfp_fps_search.html)
* [chemfp.highlevel.arena\_tools](chemfp_highlevel_arena_tools.html)
* [chemfp.highlevel.clustering](chemfp_highlevel_clustering.html)
* [chemfp.highlevel.conversion](chemfp_highlevel_conversion.html)
* [chemfp.highlevel.diversity](chemfp_highlevel_diversity.html)
* [chemfp.highlevel.simarray](chemfp_highlevel_simarray.html)
* [chemfp.highlevel.similarity](chemfp_highlevel_similarity.html)
* [chemfp.io](chemfp_io.html)
* [chemfp.jcmapper\_types](chemfp_jcmapper_types.html)
* [chemfp.openbabel\_toolkit](chemfp_openbabel_toolkit.html)
* [chemfp.openbabel\_types](chemfp_openbabel_types.html)
* [chemfp.openeye\_toolkit](chemfp_openeye_toolkit.html)
* [chemfp.openeye\_types](chemfp_openeye_types.html)
* [chemfp.rdkit\_toolkit](chemfp_rdkit_toolkit.html)
* [chemfp.rdkit\_types](chemfp_rdkit_types.html)
* [chemfp.search](chemfp_search.html)
* [chemfp.simarray\_io](chemfp_simarray_io.html)
* [chemfp.text\_records](chemfp_text_records.html)
* [chemfp.text\_toolkit](chemfp_text_toolkit.html)
* [chemfp.toolkit](chemfp_toolkit.html)
* [chemfp.types](chemfp_types.html)

## Overview[](#overview "Link to this heading")

The top-level chemfp module is the starting point for using chemfp. It
contains functions to read and write fingerprint files, “high-level”
commands for working with chemfp, and more.

The API for the FPS and FPS fingerprint readers and writers are
defined in [`chemfp.fps_io`](chemfp_fps_io.html#module-chemfp.fps_io "chemfp.fps_io") and [`chemfp.fpb_io`](chemfp_fpb_io.html#module-chemfp.fpb_io "chemfp.fpb_io"), which may
refer to a [`Location`](chemfp_io.html#chemfp.io.Location "chemfp.io.Location") object defined in [`chemfp.io`](chemfp_io.html#module-chemfp.io "chemfp.io").

The fingerprint arena class is defined in [`chemfp.arena`](chemfp_arena.html#module-chemfp.arena "chemfp.arena").

The [`chemfp.search`](chemfp_search.html#module-chemfp.search "chemfp.search") module contains similarity search functions
for searching fingerprint arenas, and the [`SearchResult`](chemfp_search.html#chemfp.search.SearchResult "chemfp.search.SearchResult") and
[`SearchResults`](chemfp_search.html#chemfp.search.SearchResults "chemfp.search.SearchResults") result class definitions. It also contains the
similarity array functions to generate an all-by-all NumPy comparison
array. These are the low-level APIs used for the high-level
[`chemfp.simsearch()`](chemfp_toplevel.html#chemfp.simsearch "chemfp.simsearch") and [`chemfp.simarray()`](chemfp_toplevel.html#chemfp.simarray "chemfp.simarray") functions.

The [`chemfp.fps_search`](chemfp_fps_search.html#module-chemfp.fps_search "chemfp.fps_search") module contains similarity search
functions for searching FPS files, and the search result class
definitions. This is only needed when working in a streaming
environment where fingerprint arena creation overhead is too large.

The [`chemfp.diversity`](chemfp_diversity.html#module-chemfp.diversity "chemfp.diversity") module contains chemfp’s diversity
pickers, all of which require a fingerprint arena. This is a
lower-level API than using [`chemfp.maxmin()`](chemfp_toplevel.html#chemfp.maxmin "chemfp.maxmin"),
[`chemfp.heapsweep()`](chemfp_toplevel.html#chemfp.heapsweep "chemfp.heapsweep"), or [`chemfp.spherex()`](chemfp_toplevel.html#chemfp.spherex "chemfp.spherex").

The [`chemfp.clustering`](chemfp_clustering.html#module-chemfp.clustering "chemfp.clustering") module contains the
[`ButinaClusters`](chemfp_highlevel_clustering.html#chemfp.highlevel.clustering.ButinaClusters "chemfp.highlevel.clustering.ButinaClusters") result from Butina clustering using
[`chemfp.butina()`](chemfp_toplevel.html#chemfp.butina "chemfp.butina").

The [`chemfp.cdk_toolkit`](chemfp_cdk_toolkit.html#module-chemfp.cdk_toolkit "chemfp.cdk_toolkit"), [`chemfp.openbabel_toolkit`](chemfp_openbabel_toolkit.html#module-chemfp.openbabel_toolkit "chemfp.openbabel_toolkit"),
[`chemfp.openeye_toolkit`](chemfp_openeye_toolkit.html#module-chemfp.openeye_toolkit "chemfp.openeye_toolkit") and [`chemfp.rdkit_toolkit`](chemfp_rdkit_toolkit.html#module-chemfp.rdkit_toolkit "chemfp.rdkit_toolkit") modules
contain the public-facing API for chemfp’s cheminformatics toolkit
wrapper implementations. The [`chemfp.cdk`](chemfp_toplevel.html#chemfp.cdk "chemfp.cdk"),
[`chemfp.openbabel`](chemfp_toplevel.html#chemfp.openbabel "chemfp.openbabel"), [`chemfp.openeye`](chemfp_toplevel.html#chemfp.openeye "chemfp.openeye"), [`chemfp.rdkit`](chemfp_toplevel.html#chemfp.rdkit "chemfp.rdkit")
objects will automatically import the underlying toolkit and forward
to them.

The [`FingerprintType`](chemfp_types.html#chemfp.types.FingerprintType "chemfp.types.FingerprintType") implementations for the different
toolkits are:

* CDK
  :   + [`chemfp.cdk_types`](chemfp_cdk_types.html#module-chemfp.cdk_types "chemfp.cdk_types"): core CDK toolkit fingerprints
      + `chemfp.cdk_patterns`: chemfp’s CDK-based fingerprints
      + [`chemfp.jcmapper_types`](chemfp_jcmapper_types.html#module-chemfp.jcmapper_types "chemfp.jcmapper_types"): jCompoundMapper fingerprints
* RDKit
  :   + [`chemfp.rdkit_types`](chemfp_rdkit_types.html#module-chemfp.rdkit_types "chemfp.rdkit_types"): core RDKit toolkit fingerprints
      + `chemfp.rdkit_patterns`: chemfp’s RDKit-based fingerprints
* OpenEye
  :   + [`chemfp.openeye_types`](chemfp_openeye_types.html#module-chemfp.openeye_types "chemfp.openeye_types"): core OEGraphSim fingerprints
      + `chemfp.openeye_patterns`: chemfp’s OEChem-based fingerprints
* Open Babel
  :   + [`chemfp.openbabel_types`](chemfp_openbabel_types.html#module-chemfp.openbabel_types "chemfp.openbabel_types"): core Open Babel toolkit fingerprints
      + `chemfp.openbabel_patterns`: chemfp’s Open Babel-based fingerprints

Sometimes you need to work with SMILES or SD files as text records,
not molecules. For that, use the [`chemfp.text_toolkit`](chemfp_text_toolkit.html#module-chemfp.text_toolkit "chemfp.text_toolkit") module.

Sometimes you need to work with CVS files containing structure records
or fingerprint. For that, use functions like
[`read_csv_ids_and_fingerprints()`](chemfp_csv_readers.html#chemfp.csv_readers.read_csv_ids_and_fingerprints "chemfp.csv_readers.read_csv_ids_and_fingerprints") and [`read_csv_rows()`](chemfp_csv_readers.html#chemfp.csv_readers.read_csv_rows "chemfp.csv_readers.read_csv_rows")
from the [`chemfp.csv_readers`](chemfp_csv_readers.html#module-chemfp.csv_readers "chemfp.csv_readers") module, or the
[`read_csv_ids_and_molecules()`](chemfp_toolkit.html#chemfp.toolkit.read_csv_ids_and_molecules "chemfp.toolkit.read_csv_ids_and_molecules") function in the toolkit
wrapper module.

The [`chemfp.bitops`](chemfp_bitops.html#module-chemfp.bitops "chemfp.bitops") module has functions to work with
fingerprints represented as byte strings or hex-encoded strings, as
well as configuration functions for configuring chemfp’s bit
operations. Use the [`chemfp.encodings`](chemfp_encodings.html#module-chemfp.encodings "chemfp.encodings") to decode from various
fingerprint string representations to a byte string.

Finally, the [`chemfp.types`](chemfp_types.html#module-chemfp.types "chemfp.types") module contains a few public
exceptions which derived from ValueError but which don’t yet also
derive from ChemFPError.

[Previous](text_toolkit.html "Text toolkit examples")
[Next](chemfp_toplevel.html "Top-level API")

---

© Copyright 2010-2026, Andrew Dalke.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).