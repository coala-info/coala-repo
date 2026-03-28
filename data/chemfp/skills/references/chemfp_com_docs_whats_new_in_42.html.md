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
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* What’s new in chemfp 4.2
  + [Warnings about likely upcoming API changes](#warnings-about-likely-upcoming-api-changes)
  + [Simarray](#simarray)
    - [chemfp.simarray()](#chemfp-simarray)
    - [chemfp simarray command-line tool](#chemfp-simarray-command-line-tool)
    - [Generating large arrays](#generating-large-arrays)
    - [Single fingerprint queries and NxM queries](#single-fingerprint-queries-and-nxm-queries)
    - [Metrics and data types](#metrics-and-data-types)
    - [The “abcd” data type](#the-abcd-data-type)
    - [chemfp’s three “abcd” metrics](#chemfp-s-three-abcd-metrics)
    - [The low-level simarray API](#the-low-level-simarray-api)
  + [RDKit fingerprint generation](#rdkit-fingerprint-generation)
    - [Count simulation](#count-simulation)
    - [RDKit-Fingerprint type changes](#rdkit-fingerprint-type-changes)
    - [RDKit-Morgan type changes](#rdkit-morgan-type-changes)
    - [RDKit-AtomPair type changes](#rdkit-atompair-type-changes)
    - [RDKit-Torsion type changes](#rdkit-torsion-type-changes)
  + [CDK updates](#cdk-updates)
    - [“hydrogens” reader argument](#hydrogens-reader-argument)
    - [CDK PubChem fingerprints](#cdk-pubchem-fingerprints)
  + [jCompoundMapper](#jcompoundmapper)
  + [Modern Python](#modern-python)
  + [Experimental support for single-link clustering](#experimental-support-for-single-link-clustering)
  + [Other changes](#other-changes)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* What’s new in chemfp 4.2

---

# What’s new in chemfp 4.2[](#what-s-new-in-chemfp-4-2 "Link to this heading")

Released 10 July 2024.

The main additions to chemfp 4.2 are:

* the “simarray” methods to generate a complete (dense) all-by-all
  NumPy matrix using several comparison metrics;
* support for the latest RDKit fingerprint generators, which
  includes new options like count simulation;
* improved support for CDK fingerprints and new support for
  the jCompoundMapper fingerprint types;
* support for Python 3.12 and NumPy 2.0, PEP 517-builds
  with pyproject.toml, and initial support for type annotations.

## Warnings about likely upcoming API changes[](#warnings-about-likely-upcoming-api-changes "Link to this heading")

I am planning some changes for the chemfp 5.0 release.

Warning

Changing rdkit2fps default fingerprint type to Morgan

For the chemfp 5.0 release I will likely change the default rdkit2fps
fingerprint type from RDKit-Fingerprint (the Daylight-like
fingerprints) to the Morgan fingerprint with radius 3. If you
currently use the default of RDKit fingerprints then you should add
`--RDK` now so this change won’t affect you. Let me know if this is
an issue for you.

Warning

Removing `from_*` and `to_*` toolkit helper functions.

The toolkit shortcut functions matching the pattern “from\_{format}”,
“to\_{format}”, “from\_{format}\_file” and “to\_{format}\_file” were added
in chemfp 4.0. In practice these were inconsistent with other parts
of the chemfp API so they were deprecated by 4.1, with a
PendingDeprecationWarning suggesting you use the “parse\_{format}” and
“create\_{format}” functions. For example, use `parse_smistring()`
instead of `from_smistring()`.

These old functions now generate a DeprecationWarning and will be
removed in chemfp 5.0.

Warning

Removing bitops.byte\_difference() and bitops.hex\_difference()

The [`chemfp.bitops`](chemfp_bitops.html#module-chemfp.bitops "chemfp.bitops") module functions byte\_difference() and
hex\_difference() functions were deprecated in favor of [`byte_xor`](chemfp_bitops.html#chemfp.bitops.byte_xor "chemfp.bitops.byte_xor") and [`hex_xor`](chemfp_bitops.html#chemfp.bitops.hex_xor "chemfp.bitops.hex_xor"). Starting
with 4.1 these generated a PendingDeprecationWarning. They now
generate a DeprecationWarning and will be removed for chemfp 5.0.

Warning

Adding a default delay for progress bars.

Chemfp 4.0 added progress bars, which are great for long-running
tasks, but sometimes chemfp can show three or four progress bars in a
fraction of a second, where I don’t care to see any progress bars at
all. While I’ve gotten into the habit of using `progress=False` for
when I know I don’t care, I think a better solution is to introduce a
minimum delay, like 0.5 seconds, before showing any progress bar.

This 4.2 release adds the initial support for that option, like
passing `progress=0.5`, or using the `CHEMFP_PROGRESS` environment
variable, though the default is to always show a progress bar.

Warning

Many object repr strings are likely to change.

As I get feedback about people using the API, and more experience
using it myself, I’ve noticed various places where I can improve the
repr.

Warning

SearchResult’s “result” will likely change to “out”.

The high-level [`chemfp.simsearch()`](chemfp_toplevel.html#chemfp.simsearch "chemfp.simsearch") function returns a high-level
search result object which itself contains a `result` attribute
containing the low-level search search object.

I’ve found that referring to the low-level object as `result.result`
to be very confusing.

With chemfp 4.2 that object is also available as `result.out`,
following the “out” parameter convention used in NumPy. If it proves
better I will make the old `result` attribute generate a
PendingDeprecationWarning in chemfp 5.0, for eventual removal by
chemfp 5.1 or 5.2.

Warning

The “npz” JSON metadata array format will likely change.

The new simarray functionality has the option to store metadata as a
JSON string in a NumPy array, but the JSON schema is different than
the JSON used in the simsearch “npz” format . Based on that
experience, I plan to change the “npz” JSON format so the two are more
consistent.

## Simarray[](#simarray "Link to this heading")

Chemfp has new support for creating the complete set of comparisons
between a fingerprint set and itself (“symmetric” or “NxN”), the
complete set of comparison between a query fingerprint set and a
target fingerprint set (“NxM”) or between a query fingerprint and a
target fingerprint set (“N”).

### chemfp.simarray()[](#chemfp-simarray "Link to this heading")

The primary use case is to generate a NumPy array as input to sci-kit
clustering algorithms and other algorithms which require the full
(dense) matrix as input. Here is an example using the
[`chemfp.simarray()`](chemfp_toplevel.html#chemfp.simarray "chemfp.simarray") function:

```
>>> import chemfp
>>> simarr = chemfp.simarray(targets="benzodiazepine_morgan2.fps.gz", as_distance=True)
benzodiazepine_morgan2.fps.gz: 100%|███████████████| 492k/492k [00:00<00:00, 15.1Mbytes/s]
scores: 100%|██████████████████████████████████████| 76.7M/76.7M [00:01<00:00, 73.0M/s]
>>> simarr
SimarrayResult(metric=<1-Tanimoto distance>, out=<12386x12386 symmetric array of dtype float64>,
query_ids=target_ids=['1688', '1963', '2118', ...], times=<process: 1.05 s, total: 1.11 s>)
>>> simarr.out[:3,:3]
array([[0.        , 0.65      , 0.51923077],
       [0.65      , 0.        , 0.46428571],
       [0.51923077, 0.46428571, 0.        ]])
>>> import sklearn.cluster
>>> agg_complete = sklearn.cluster.AgglomerativeClustering(linkage="complete", metric="precomputed")
>>> agg_complete.fit(simarr.out)
AgglomerativeClustering(linkage='complete', metric='precomputed')
```

In this case it took about 50ms to load the 12,386 fingerprints and
1.05 seconds to generate the complete distance matrix, computed as
1-Tanimoto. A complete timing breakdown is:

```
>>> simarr.get_times_description()
'load_targets: 54.84 ms init: 200.03 us process: 1.05 s total: 1.11 s'
```

with the raw times (in seconds) available as the `simarr.times`
dictionary.

Use [`save()`](chemfp_search.html#chemfp.search.SimarrayContent.save "chemfp.search.SimarrayContent.save") to save the array in NumPy’s
“npy” format, or in a “bin”ary format containing only the raw data
bytes:

```
>>> simarr.save("benzodiazepine.npy")
```

### chemfp simarray command-line tool[](#chemfp-simarray-command-line-tool "Link to this heading")

On the command-line, the new [chemfp simarray](chemfp_simarray_command.html#chemfp-simarray)
subcommand will generate the all-by-all comparison and save the result
to a NumPy “npy” file containing:

```
% chemfp simarray benzodiazepine_morgan2.fps.gz --as-distance \
       --no-lower-triangle -o benzodiazepine_NxN.npy
benzodiazepine_morgan2.fps.gz: 100%|█████| 492k/492k [00:00<00:00, 17.7Mbytes/s]
scores: 100%|███████████████████████████████| 76.7M/76.7M [00:00<00:00, 86.5M/s]
% python
  ...
>>> import numpy as np
>>> arr = np.load("benzodiazepine_NxN.npy")
>>> arr[:3,:3]
array([[0.        , 0.65      , 0.51923077],
       [0.        , 0.        , 0.46428571],
       [0.        , 0.        , 0.        ]])
```

The `--no-lower-triangle` (or `include_lower_triangle=False` in
the API) leaves the lower triangle as the zero values. This option
improves the overall performance but does not save any space!

The “npy” file contains up to four arrays, though the `np.load()`
only returns the first one, with the comparison values. The second
contains metadata about the comparison, as a JSON-encoded 1-element
NumPy string array. The third contains the target ids (or simply the
ids for an NxN comparison), and the fourth contains the query ids, if
relevant. You can use `np.load()` with a file handle to read these
arrays directly, or use chemfp’s new [`load_simarray()`](chemfp_toplevel.html#chemfp.load_simarray "chemfp.load_simarray"):

```
>>> import chemfp
>>> simarr = chemfp.load_simarray("benzodiazepine_NxN.npy")
>>> simarr
SimarrayFileContent(metric=<1-Tanimoto distance>,
out=<12386x12386 upper-triangular array of dtype float64>,
query_ids=target_ids=['1688', '1963', '2118', ...])
>>> import pprint
>>> pprint.pprint(simarr.get_metadata())
{'dtype': 'float64',
'format': 'multiple',
'matrix_type': 'upper-triangular',
'method': 'Tanimoto as_distance=1',
'metric': {'as_distance': True,
            'is_distance': True,
            'is_similarity': False,
            'name': 'Tanimoto'},
 'metric_description': '1-Tanimoto distance',
 'num_bits': 2048,
 'shape': (12386, 12386)}
```

See the [`chemfp.simarray_io`](chemfp_simarray_io.html#module-chemfp.simarray_io "chemfp.simarray_io") documentation for a description of
the JSON content.

Finally, the [`chemfp.simarray()`](chemfp_toplevel.html#chemfp.simarray "chemfp.simarray") API function
creates the entire comparison array in-memory, as well as the
[chemfp simarray](chemfp_simarray_command.html#chemfp-simarray) subcommand when generating
“npy” output. This may be a problem when computing a large comparison
array which may not fit into memory.

### Generating large arrays[](#generating-large-arrays "Link to this heading")

If you want to create an array which exceeds available memory, the
[chemfp simarray](chemfp_simarray_command.html#chemfp-simarray) subcommand has special
support for computing 2GB portions of the output array a time, and
writing the results to a “bin” file. This file contains the raw data
bytes for the array, equivalent to NumPy’s `arr.tobytes()`.

The following example computes the cosine similarity (as 32-bit
floats) for 100,000 randomly selected PubChem fingerprints. The raw
bytes are saved to `pubchem_100K.bin`, with additional data about
the calculation saved to `pubchem_100K_meta.npy`:

```
% chemfp simarray --metric cosine --dtype float32 pubchem_100K.fpb \
      -o pubchem_100K.bin --metadata-output pubchem_100K_meta.npy
scores: 100%|█████████████████| 10.0G/10.0G [01:22<00:00, 122M/s]
% ls -lh pubchem_100K.bin
-rw-r--r--  1 dalke  admin    37G Jun 18 10:09 pubchem_100K.bin
```

That’s 122 million comparisons per second, or just under 90 seconds
for 100Kx100K = 10 billion comparisons, on my 16GB laptop which has
12GB in use for other things.

The “bin” file can be memory-mapped directly into NumPy, if you know
the shape and dtype:

```
>>> import numpy as np
>>> arr = np.memmap("pubchem_100K.bin",
     shape=(100_000, 100_000), dtype=np.float32)
>>> arr[5000:5003,5000:5003]
memmap([[1.        , 0.6666667 , 0.47619048],
        [0.6666667 , 1.        , 0.3809524 ],
        [0.47619048, 0.3809524 , 1.        ]], dtype=float32)
```

The auxillary “metadata” npy file is the same format as the normal
simarray npy file except the first array contains a 0x0 array with the
appropriate NumPy data. The JSON `shape` value in the second array
can be used to get the size, followed by the ids in the third array.

If you have the “bin” and auxillary “npy” file then the easiest way to
access the data is with [`chemfp.load_simarray()`](chemfp_toplevel.html#chemfp.load_simarray "chemfp.load_simarray"):

```
>>> import chemfp
>>> simarr = chemfp.load_simarray("pubchem_100K.bin",
...        metadata_source="pubchem_100K_meta.npy")
>>> simarr
SimarrayFileContent(metric=<cosine similarity>, out=<100000x100000
symmetric array of dtype float32>, query_ids=target_ids=[
'783', '1038', '23913', ...])
>>>
>>> import numpy as np
>>> np.count_nonzero(simarr.out)
9807887295
```

By default is uses a memory-map to read a “bin” file as read-only,
while it loads an “npy” into memory. Use the `mmap_mode` to change
these behaviors.

### Single fingerprint queries and NxM queries[](#single-fingerprint-queries-and-nxm-queries "Link to this heading")

The [`simarray()`](chemfp_toplevel.html#chemfp.simarray "chemfp.simarray") function can also be used to compute all the
comparisons between a query fingerprint and a set of target
fingerprints, like the following example which computes the Tanimoto
similarity between CHEMBL113 and all of ChEMBL 33, then shows the
histogram counts (which acts as a log scale graphic):

```
>>> import chemfp
>>> a = chemfp.load_fingerprints("chembl_33.fpb")
>>> query_fp = a.get_fingerprint_by_id("CHEMBL113")
>>> simarr = chemfp.simarray(query_fp=query_fp, targets=a)
scores: 100%|█████████████████████████████████████| 2.37M/2.37M
[00:00<00:00, 3.99M/s]
>>> simarr
SimarrayResult(metric=<Tanimoto similarity>, out=<2372674 vector of
dtype float64>, query_ids=None, target_ids=['CHEMBL17564',
'CHEMBL4300465', 'CHEMBL4302507', ...], times=<process: 620.04 ms,
total: 623.88 ms>)
>>> import numpy as np
>>> for count, bin in zip(*np.histogram(simarr.out, bins=20)):
...   print(f"{bin:.2f}: {count}")
..