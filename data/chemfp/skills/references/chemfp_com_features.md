# [chemfp](https://chemfp.com/index.html)

* [Features](https://chemfp.com/features/)
* [Download](https://chemfp.com/download/)
* [Datasets](https://chemfp.com/datasets/)
* [License](https://chemfp.com/license/)
* [News](https://chemfp.com/news/)
* [Contact](https://chemfp.com/contact/)

* [High Performance Search](/performance/)
* [FPS Format](/fps_format/)
* [FPB Format](/fpb_format/)
* [FPC Format](/fpc_format/)
* [• Datasets](/datasets/)
* [Multiple Toolkit Support](/toolkits/)
* [Documentation:](/docs/)
* [• Command-line Tools](/docs/tools.html)
* [• Python API](/docs/chemfp_api.html)
* [• Example Programs](https://hg.sr.ht/~dalke/chemfp_examples)

## chemfp features

## Similarity search performance

One of the main chemfp goals is high-performance similarity search. It
combines efficient memory organization,
[linear and sublinear search bounds](https://pubs.acs.org/doi/abs/10.1021/ci600358f),
and fast popcount algorithms (including special support for CPUs which
implement the POPCNT and AVX2 instructions) to do a Tanimoto search of
1 million fingerprints in 10 milliseconds, using a single thread.

For multi-threaded machines, it uses OpenMP to make it possible to
cluster 1 million fingerprints in well less than an hour on a
four-core machine. Details for both timings are on the
[performance](/performance/) page.

Chemfp uses the same techniques to implement high-performance Tversky
search.

## Clustering, diversity, and NumPy

Chemfp has expanded beyond it similarity search core to add built-in
support for
[Butina clustering](/docs/tools.html#chemfp-butina-intro),
[sphere exclusion](/docs/tools.html#chemfp-spherex-intro)
(including
[directed sphere
exclusion](/docs/tools.html#chemfp-spherex-dise-intro)),
and
[MaxMin diversity selection](/docs/tools.html#chemfp-maxmin-intro).

Butina clutering is quite fast, typically less than a second unless
there is extensive pruning. However, it requires the NxN sparse
comparison matrix, which can take hours to generate. Chemfp can
[save the matrix to a file](/docs/getting_started_api.html#save-simsearch-results-to-an-npz-file)
and load it for (re)clustering, which lets you
[explore parameter space](/docs/getting_started_api.html#the-effect-of-butina-threshold-size-when-clustering-chembl).
The file format is based on the SciPy sparse arrary format, which
means you can also import the results into other SciPytools.

Some clustering methods, like many of those in scikit-learn, require
the complete comparison matrix as a NumPy array. Chemfp's
[simarray](/docs/tools.html#chemfp-simarray-intro) can
generate roughly 100 million comparisons per second. The command-line
version can even create arrays which are
[too large for RAM](/docs/tools.html#simarray-and-arrays-larger-than-memory)
by writing the results directly to a file, for later processing on
another computer, or for memory-mapped use.

## Fast load times

Chemfp performance extends beyond its algorithms. Chemfp natively
supports the [FPS](/fps_format/) and [FPB](/fpb_format/) fingerprint
file formats. The FPS format is text-format designed as an exchange
format which is easy to read and write. Chemfp can search directly on
an FPS file at over 500 MB/second, and can load an FPS file into
memory, at between 40 and 250MB/second, for 166-bit fingerprints and
2048-bit fingerprints, respectively.

If that isn't fast enough, the FPB file is designed for
high-performance I/O. The file layout matches chemfp's internal
layout, which means the file can be loaded directly as a memory-mapped
file for effectively instantaneous "open" times. It still takes time
to load the data into memory when the first search starts, that's
where the linear and sublinear search bounds shine. With a high
threshold it's often possible to leave most of the data on the disk,
because it won't be needed.

## Multiple Toolkit Support

Another goal of chemfp is to make it easier to work with different
fingerprint types, no matter the source. Chemfp can work with the
[RDKit, OEChem/OEGraphSim, Open Babel and CDK toolkits](/toolkits/) to
read and write structure files and to generate fingerprints. You can
also use chemfp with your own custom fingerprint types.

It does this through a
"[toolkit API](/docs/toolkit.html)",
which is a high-level wrapper around the underlying toolkits. Among
other things, it normalizes most of the I/O handling differences in
the toolkits, gives a common framework for error-handling. It also
includes discovery methods so your tools can figure out which
structure formats, fingerprint types, and fingerprint type parameters
are available.

Chemfp even provides its own
"[text toolkit](/docs/text_toolkit.html)"
API, which follows the toolkit API and knows just enough about SMILES
and SD files to be able parse individual records as strings, and to
extract the title/identifier and SD tag data.

This may not sound useful, until you start working with multiple
toolkits where one toolkit might parse a record while another does
not - which toolkit do you use to read the structure file and record
the failure?

## Command-line Users

Chemfp integrates well with a standard command-line workflow.

It comes with
[command-line tools](/docs/tools.html)
to generate fingerprints from structure files, to extract fingerprints
from an SD file, to convert between fingerprint file formats, and to
carry out a similarity search. These tools follow standard Unix
idioms, including command-line arguments like
[`--help`](/docs/tool_help.html) and
support for both file I/O and stdin/stdout I/O.

The tools all generate formats which are easy to parse by other
tools. For example, the
[`simsearch`](/docs/simsearch_command.html)
output is a line-oriented format with tab-separated results, which
makes it straight-forward to integrate with other tools.

The FPB format even makes it possible to do a similarity search of a
multi-million fingerprint dataset, on the command-line, in a fraction
of a second. Most of the time is simply waiting for Python to start
up!

## Library API

Chemfp is a fingerprint toolkit; that is, it includes a Python API
which can be used to no just create and search fingerprint data,
but also to build sophisticated fingerprint analysis tools.

For example, the methods to get the
[cumulative scores of a search result](/docs/chemfp_search.html#chemfp.search.SearchResults.cumulative_score_all)
and to
[select a fingerprint subset](/docs/chemfp_arena.html#chemfp.arena.FingerprintArena.sample)
were added to make it easier to do an SEA analysis, and the
"[arena.to\_numpy\_bitarray](/docs/chemfp_arena.html#chemfp.arena.FingerprintArena.to_numpy_bitarray)"
method added to do k-means clustering on the fingerprint bits.

For a walk-through in how to use the chemfp API for a complex
fingerprint analysis project, see the three-part blog entry on building
an association network based on ChEMBL targets:
[part 1](http://www.dalkescientific.com/writings/diary/archive/2017/03/20/fingerprint_set_similarity.html),
[part 2](http://www.dalkescientific.com/writings/diary/archive/2017/03/24/chembl_bioactivity_data.html),
[part 3](http://www.dalkescientific.com/writings/diary/archive/2017/03/27/chembl_target_sets_association_network.html).

The API is
[extensively documented](/doct/toolkit.html),
at roughtly 1,000 pages long (including the extracted docstrings). The documentation includes sections on:

* [Getting started with the API](/docs/getting_started_api.html),
* [Managing fingerprint types](/docs/fingerprint_types.html),
* [Interfacing with a supported cheminformatics toolkit](/docs/toolkit.html)
* [Using chemfp's "text toolkit"](/docs/text_toolkit.html)

Parts of the documentation were extracted from the chemfp library,
which includes docstrings for all of the public functions, methods,
and classes include full docstrings. These docstrings are also easily
accessible to interactive users on the Python shell, in the Jupyter
notebook, and though modern editors.

## Web Development

The chemfp 1.x API was based around files, which worked well for
command-line tools, but it wasn't so useful for web application and
web service development where, for example, the input structure comes
in as a string.

The theme for version 2.0 was to make chemfp "web-enabled", with new
APIs to meet the needs of web development. One of the key ones, of
course, was to support string-based I/O.

The discovery methods mentioned above, in the "Multiple Toolkit
Support" section, were added so the web application could tell the
user which formats and fingerprint types were supported, and provide a
basic interface so the user could specify different fingerprint type
parameters.

Another part of "web-enabled" was to make chemfp more robust at
detecting and reporting problems, for example, to report to the web
client that the 3rd record of the 10 SDF records uploaded
could not be parsed.

The FPB format was developed to help the web application development
processs. Web developers often make a small change to the code and
restart the server to see the effect. With the FPS format, it might
take a few seconds to reload a corporate database with 5 million
fingerprints, and the delay multiplies if the application uses several
different fingerprint types for the same data set.

Even just a few seconds of delay is irritating for those used to fast
restarts.

The FPB format is very fast to load because it only needs to do some
basic processing. Chemfp uses a memory-map to access the file, which
means the data isn't loaded until it's used, and that load time is
fast. Furthermore, it's a shared read-only memory map, which means
that multiple web servers on the same machine can use the same FPB
file image, rather than having each one load its own private copy of
the file.

Copyright © 2012-2025 Andrew Dalke Scientific AB