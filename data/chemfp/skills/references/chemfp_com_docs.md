[chemfp.com](https://chemfp.com/)

chemfp documentation

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* [Command-line examples for sparse count fingerprints](count_tools.html)
* [The chemfp command-line tools](tool_help.html)
* [Getting started with the API](getting_started_api.html)
* [Fingerprint family and type examples](fingerprint_types.html)
* [Toolkit API examples](toolkit.html)
* [Text toolkit examples](text_toolkit.html)
* [chemfp API](chemfp_api.html)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1b1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

chemfp documentation

* chemfp 5.1 documentation

---

# chemfp 5.1 documentation[](#chemfp-5-1-documentation "Link to this heading")

[chemfp](http://chemfp.com/) is the package you’ve been looking for,
if you work with binary cheminformatics fingerprints in Python.

Chemfp is perhaps best known for its
high-performance
[fingerprint similarity search](tools.html#simsearch-knearest-search).
Its
[Taylor/Butina clustering](tools.html#chemfp-butina-intro),
[MaxMin diversity selection](tools.html#chemfp-maxmin-intro),
and
[sphere exclusion](tools.html#chemfp-spherex-intro),
(including
[directed sphere exclusion](tools.html#chemfp-spherex-dise-intro))
are equally world-class, and in some cases more than an order
of magnitude faster than its competitors. Or, if you simply need
a 100K by 100K distance array to pass into scikit-learn,
chemfp’s
[simarray](tools.html#chemfp-simarray-intro)
can generate that in less than a minute.

All of that functionality is available using
[command-line tools](tool_help.html#tool-help) or,
for those who need more customization, through a
[comprehensive Python API](chemfp_toplevel.html#chemfp-toplevel).
Research scientists and IT developers will both enjoy chemfp’s
extensive integration with NumPy, SciPy, and Pandas.

Do you want to evaluate the effectiveness of different fingerprint
types? No other system has built-in support for [RDKit](tools.html#chemfp-rdkit2fps-intro), [OEChem/OEGraphSim](tools.html#chemfp-oe2fps-intro), [CDK](tools.html#chemfp-cdk2fps-intro), [Open
Babel](tools.html#chemfp-ob2fps-intro), and [jCompoundMapper](whats_new_in_42.html#whats-new-jcompoundmapper) fingerprints, or you can import your own
fingerprints using the text-based FPS format or [convert your
sparse count fingerprints](count_tools.html#using-count-tools) to binary fingerprints with
one of several methods. Chemfp even includes tools to extract
fingerprints from [SDF tag data](tools.html#pubchem-fingerprints). or
extract or process fields from [CSV columns](tools.html#chemfp-csv2fps-intro).

Do you want to develop your own analysis methods? Let chemfp handle
fingerprint generation and [file I/O](getting_started_api.html#load-fingerprints-intro)
and give you a [`NumPy view of the fingerprint data`](chemfp_arena.html#chemfp.arena.FingerprintArena.to_numpy_array "chemfp.arena.FingerprintArena.to_numpy_array"). You can also build on chemfp’s
own components, including its [cross-toolkit wrapper API](toolkit.html#toolkit-chapter) for molecule I/O and its [text toolkit](text_toolkit.html#text-toolkit-chapter) for processing SDF and SMILES files directly
as text records.

At its heart, chemfp is a Python library, designed to be a component
in a larger system. Do you need to add similarity search to a Django
component? Create a Jupyter widget? Write a desktop application GUI
with PyQt? If you can “import chemfp” then all those are possible.

## Summary and recent release details[](#summary-and-recent-release-details "Link to this heading")

[chemfp](http://chemfp.com/) is a set of [command-line tools](tool_help.html#tool-help) and a [Python package](getting_started_api.html#getting-started-api) for
working with binary cheminformatics fingerprints, typically between
several hundred and a few thousand bits long. Chemfp 5.0 added initial
support for [generating sparse count fingerprints](count_tools.html#using-count-tools) and [converting them to binary](count_tools.html#chemfp-fpc2fps-intro).

Chemfp 5.1b1 was released on 20 February 2026. It further refines the
sparse count fingerprint support added in chemfp 5.0. RDKit byte
fingerprint generation now has direct support support for
“superimposed” count simulation, fpc parsing and conversion to byte
fingerprints performance is 2-3 times faster, and there is initial API
support for working with FPC files and count fingerprints. For full
details see [What’s new in chemfp 5.1b1](whats_new_in_51.html#whats-new-51).

It was tested with Python 3.9-3.14. It requires the “[click](https://click.palletsprojects.com/)” and “[tqdm](https://tqdm.github.io/)” third-party packages, which should be
installed automatically as part of the normal [installation
process](installing.html#installing). Some optional features will only work if they
are installed by other methods, like the NumPy, SciPy, and Pandas
integration.

Chemfp 5.0 was released on 24 September 2025. This version adds
[shardsearch](chemfp_shardsearch_command.html#chemfp-shardsearch) to search multiple target
files, [simhistogram](chemfp_simhistogram_command.html#chemfp-simhistogram) to generate a
histogram of all similarity scores, an [updated FPB format](whats_new_in_50.html#fpb-format-50) which now handles more than 1 billion
fingerprints, new [Klekota-Roth fingerprint type](whats_new_in_50.html#klekota-roth-50) implementations for OEChem and RDKit, and initial
support for sparse count fingerprints, with a new [FPC text format](https://chemfp.com/fpc_format/), [chemfp rdkit2fpc](chemfp_rdkit2fpc_command.html#chemfp-rdkit2fpc) command to generate FPC files with RDKit,
[chemfp fpc2fps](chemfp_fpc2fps_command.html#chemfp-fpc2fps) to convert FPC files to FPS or
FPB format, and [chemfp fps2fpc](chemfp_fps2fpc_command.html#chemfp-fps2fpc) for the other
direction. See [What’s new in chemfp 5.0](whats_new_in_50.html#whats-new-50) for details.

Chemfp 4.2 was released on 10 July 2024 with simarray support to
generate an all-by-all NumPy array, updates to the latest RDKit
fingerprint generators, including count simulation, and
jCompoundMapper support. See [What’s new in chemfp 4.2](whats_new_in_42.html#whats-new-42) for details.

Chemfp 4.1 was released on 17 May 2023. with CXSMILES support, methods
to save and load similarity search results to a SciPy sparse matrix,
Butina clustering, methods to work with CSV files, and a tool to
convert between structure formats. See [What’s new in chemfp 4.1](whats_new_in_41.html#whats-new-41) for
details.

Chemfp 4.0 added new methods for diversity selection and improves API
usability with new high-level functions and improved feedback for
interactive use (including progress bars!). See [What’s new in chemfp 4.0](whats_new_in_40.html#whats-new-40)
for details.

Remember: chemfp cannot generate fingerprints from a structure file
without a third-party chemistry toolkit. The supported toolkits are
OEChem/OEGraphSim, Open Babel, RDKit and CDK (via the JPype
adapter). jCompoundMapper requires the CDK jar on the CLASSPATH
folllowed by either “jCMapperCLI.jar” or “jCMapperLibOnly.jar”,
available from [its Sourceforge distribution](https://jcompoundmapper.sourceforge.net/).

## Table of Contents[](#table-of-contents "Link to this heading")

* [Installing chemfp](installing.html)
  + [Installing a pre-compiled package](installing.html#installing-a-pre-compiled-package)
  + [Installing from source](installing.html#installing-from-source)
  + [Configuration options](installing.html#configuration-options)
  + [Installing CDK and JPype](installing.html#installing-cdk-and-jpype)
  + [Installing jCompoundMapper](installing.html#installing-jcompoundmapper)
* [Command-line examples for binary fingerprints](tools.html)
  + [Generate fingerprint files from PubChem SD tags](tools.html#generate-fingerprint-files-from-pubchem-sd-tags)
  + [csv background](tools.html#csv-background)
  + [csv2fps command intro](tools.html#csv2fps-command-intro)
  + [MolPort csv file](tools.html#molport-csv-file)
  + [csv2fps --describe](tools.html#csv2fps-describe)
  + [csv2fps column specifiers](tools.html#csv2fps-column-specifiers)
  + [csv2fps input structure format](tools.html#csv2fps-input-structure-format)
  + [Specify csv2fps fingerprint type](tools.html#specify-csv2fps-fingerprint-type)
  + [Extract fingerprints from a CSV file](tools.html#extract-fingerprints-from-a-csv-file)
  + [k-nearest neighbor search](tools.html#k-nearest-neighbor-search)
  + [simsearch CSV output](tools.html#simsearch-csv-output)
  + [Threshold search](tools.html#threshold-search)
  + [simsearch CSV output when no hits](tools.html#simsearch-csv-output-when-no-hits)
  + [Combined k-nearest and threshold search](tools.html#combined-k-nearest-and-threshold-search)
  + [Saving simsearch results to “npz” format](tools.html#saving-simsearch-results-to-npz-format)
  + [NxN (self-similar) searches](tools.html#nxn-self-similar-searches)
  + [Using a toolkit to process the ChEBI dataset](tools.html#using-a-toolkit-to-process-the-chebi-dataset)
  + [Use structures as input to simsearch](tools.html#use-structures-as-input-to-simsearch)
  + [Make new fingerprints matching the type in an existing file](tools.html#make-new-fingerprints-matching-the-type-in-an-existing-file)
  + [Alternate error handlers](tools.html#alternate-error-handlers)
  + [chemfp’s two cross-toolkit substructure fingerprints](tools.html#chemfp-s-two-cross-toolkit-substructure-fingerprints)
  + [substruct fingerprints](tools.html#substruct-fingerprints)
  + [Generate binary FPB files from a structure file](tools.html#generate-binary-fpb-files-from-a-structure-file)
  + [Convert between FPS and FPB formats](tools.html#convert-between-fps-and-fpb-formats)
  + [Specify the fpcat output format](tools.html#specify-the-fpcat-output-format)
  + [Alternate fingerprint file formats](tools.html#alternate-fingerprint-file-formats)
  + [The FPB format](tools.html#the-fpb-format)
  + [Get licensed FPB files containing ChEMBL 34 fingerprints](tools.html#get-licensed-fpb-files-containing-chembl-34-fingerprints)
  + [Similarity search with the FPB format](tools.html#similarity-search-with-the-fpb-format)
  + [Multi-core similarity search](tools.html#multi-core-similarity-search)
  + [Converting large data sets to FPB format](tools.html#converting-large-data-sets-to-fpb-format)
  + [Faster gzip decompression](tools.html#faster-gzip-decompression)
  + [bzip2, xv, and other compression formats](tools.html#bzip2-xv-and-other-compression-formats)
  + [Generate fingerprints in parallel and merge to FPB format](tools.html#generate-fingerprints-in-parallel-and-merge-to-fpb-format)
  + [GDB-13 fingerprints in one FPB](tools.html#gdb-13-fingerprints-in-one-fpb)
  + [Single query shardsearch](tools.html#single-query-shardsearch)
  + [shardsearch with compressed shards](tools.html#shardsearch-with-compressed-shards)
  + [shardsearch with several queries](tools.html#shardsearch-with-several-queries)
  + [shardsearch batch size](tools.html#shardsearch-batch-size)
  + [shardsearch load strategies](tools.html#shardsearch-load-strategies)
  + [Generate a full Tanimoto similarity array](tools.html#generate-a-full-tanimoto-similarity-array)
  + [Generate the array using another metric or datatype](tools.html#generate-the-array-using-another-metric-or-datatype)
  + [Generate a simarray using an “abcd” metric](tools.html#generate-a-simarray-using-an-abcd-metric)
  + [Simarray and arrays larger than memory](tools.html#simarray-and-arrays-larger-than-memory)
  + [Histogram generation](tools.html#histogram-generation)
  + [Histogram identity bin](tools.html#histogram-identity-bin)
  + [Increasing histogram accuracy](tools.html#increasing-histogram-accuracy)
  + [Histogram between two data sets](tools.html#histogram-between-two-data-sets)
  + [Histogram between two datasets, including input histograms](tools.html#histogram-between-two-datasets-including-input-histograms)
  + [Butina on the command-line](tools.html#butina-on-the-command-line)
  + [Alternate Butina output formats](tools.html#alternate-butina-output-formats)
  + [Butina parameter tuning with npz files](tools.html#butina-parameter-tuning-with-npz-files)
  + [Sphere exclusion](tools.html#sphere-exclusion)
  + [Sphere exclusion output options](tools.html#sphere-exclusion-output-options)
  + [Sphere exclusion with initial picks, and saving candidates](tools.html#sphere-exclusion-with-initial-picks-and-saving-candidates)
  + [Directed sphere exclusion](tools.html#directed-sphere-exclusion)
  + [MaxMin diversity selection](tools.html#maxmin-diversity-selection)
  + [The initial MaxMin pick](tools.html#the-initial-maxmin-pick)
  + [MaxMin diversity selection including references](tools.html#maxmin-diversity-selection-including-references)
  + [Heapsweep diversity selection](tools.html#heapsweep-diversity-selection)
  + [Structure file format translation](tools.html#structure-file-format-translation)
  + [Structure translation reader and writer args](tools.html#structure-translation-reader-and-writer-args)
  + [Structure translation with two toolkits](tools.html#structure-translation-with-two-toolkits)
* [Command-line examples for sparse count fingerprints](count_tools.html)
  + [Sparse fingerprints quick start](count_tools.html#sparse-fingerprints-quick-start)
  + [What are sparse count fingerprints?](count_tools.html#what-are-sparse-count-fingerprints)
  + [The FPC format](count_tools.html#the-fpc-format)
  + [The two count Tanimoto similarities](count_tools.html#the-two-count-tanimoto-similarities)
  + [Generate sparse count fingerprints with RDKit](count_tools.html#generate-sparse-count-fingerprints-with-rdkit)
  + [Count fingerprint search with the RDKit API](count_tools.html#count-fingerprint-search-with-the-rdkit-api)
  + [Convert sparse count fingerprints to binary](count_tools.html#convert-sparse-count-fingerprints-to-binary)
  + [fpc2fps “fold” method](count_tools.html#fpc2fps-fold-method)
  + [fpc2fps “rdkit-countsim” method](count_tools.html#fpc2fps-rdkit-countsim-method)
  + [fpc2fps “superimpose” method](count_tools.html#fpc2fps-superimpose-method)
  + [fpc2fps “scaled” method](count_tools.html#fpc2fps-scaled-method)
  + [fpc2fps “seq” method](count_tools.html#fpc2fps-seq-method)
  + [fpc2fps “scaled-seq” method](count_tools.html#fpc2fps-scaled-seq-method)
  + [Convert binary fingerprints to count](count_tools.html#convert-binary-fingerprints-to-count)
* [The chemfp command-line tools](tool_help.html)
* [Getting started with the API](getting_started_api.html)
  + [Get ChEMBL 34 fingerprints in FPB format](getting_started_api.html#get-chembl-34-fingerprints-in-fpb-format)
  + [Similarity search of ChEMBL by id](getting_started_api.html#similarity-search-of-chembl