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
* What’s new in chemfp 5.0
  + [Backwards-incompatible changes](#backwards-incompatible-changes)
  + [Updated FPB format](#updated-fpb-format)
  + [shardsearch](#shardsearch)
  + [simhistogram](#simhistogram)
    - [simhistogram output header](#simhistogram-output-header)
    - [simhistogram output data](#simhistogram-output-data)
    - [High-level chemfp.simhistogram function](#high-level-chemfp-simhistogram-function)
  + [sparse count fingerprints](#sparse-count-fingerprints)
    - [FPC format](#id1)
    - [rdkit2fpc](#rdkit2fpc)
    - [fpc2fps](#fpc2fps)
    - [fps2fpc](#fps2fpc)
  + [Klekota-Roth fingerprints](#klekota-roth-fingerprints)
  + [New APIs](#new-apis)
  + [CDK](#cdk)
  + [Other](#other)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* What’s new in chemfp 5.0

---

# What’s new in chemfp 5.0[](#what-s-new-in-chemfp-5-0 "Link to this heading")

Version 5.0 was released on 24 September 2025.

The main additions to chemfp 5.0 are:

* Update the FPB format to handle over 1 billion fingerprints.
* New [chemfp shardsearch](chemfp_shardsearch_command.html#chemfp-shardsearch) command-line tool
  which does similarity search across multiple target files and merges
  the result.
* New [chemfp simhistogram](chemfp_simhistogram_command.html#chemfp-simhistogram) / [chemfp
  simhist](chemfp_simhistogram_command.html#chemfp-simhistogram) command-line tool and corresponding
  [`chemfp.simhistogram()`](chemfp_toplevel.html#chemfp.simhistogram "chemfp.simhistogram") high-level API function to create a
  histogram of similarity scores.
* Experimental support to [generate sparse count fingerprints
  using RDKit](chemfp_rdkit2fpc_command.html#chemfp-rdkit2fpc) along with methods to [convert
  sparse count fingerprints to binary fingerprints](chemfp_fpc2fps_command.html#chemfp-fpc2fps)
  and [vice versa](chemfp_fps2fpc_command.html#chemfp-fps2fpc).
* Implementations of the 4860-bit Klekota-Roth fingerprint for the
  OpenEye and RDKit toolkits.

See below for more details.

## Backwards-incompatible changes[](#backwards-incompatible-changes "Link to this heading")

Dropped support for Python 3.8.

If no explicit fingerprint type is specified then [rdkit2fps](rdkit2fps_command.html#rdkit2fps) now generates Morgan fingerprints with radius 3 instead
of RDKit’s Daylight-like fingerprints. Use an explicit `--RDK` to
the command-line to get the RDKit fingerprint type. This change was
documented in the chemfp 4.2 release notes.

The toolkit helper functions matching the pattern “from\_{format}”,
“to\_{format}”, “from\_{format}\_file” and “to\_{format}\_file” (like
`chemfp.rdkit_toolkit.from_smi` to parse a SMILES record into a
molecule) were added in chemfp 4.0 and documented as deprecated in
chemfp 4.1. Using them in chemfp 4.2 generated a DeprecationWarnings.
With chemfp 5.0 they have been removed. Instead, use the
“parse\_{format}” and “create\_{format}” functions, like
[`parse_smi()`](chemfp_toolkit.html#chemfp.toolkit.parse_smi "chemfp.toolkit.parse_smi") instead of `from_smi()`.

The [`chemfp.bitops`](chemfp_bitops.html#module-chemfp.bitops "chemfp.bitops") functions `byte_difference()` and
`hex_difference()` have been removed. Using them generated a
PendingDeprecationWarning in chemfp 4.1 and a DeprecationWarning in
chemfp 4.2. Instead, use [`byte_xor`](chemfp_bitops.html#chemfp.bitops.byte_xor "chemfp.bitops.byte_xor")
and [`hex_xor`](chemfp_bitops.html#chemfp.bitops.hex_xor "chemfp.bitops.hex_xor").

The fingerprint type method `from_mol()` and `from_mols()`
were documented as deprecated in chemfp 4.2. Using them now generates
a DeprecationWarning. They will be removed by chemfp 5.2. Instead, use
`compute_fingerprint()` or `compute_fingerprints()`.

The high-level [`chemfp.simsearch()`](chemfp_toplevel.html#chemfp.simsearch "chemfp.simsearch"), [`chemfp.maxmin()`](chemfp_toplevel.html#chemfp.maxmin "chemfp.maxmin"),
[`chemfp.spherex()`](chemfp_toplevel.html#chemfp.spherex "chemfp.spherex") [`chemfp.heapsweep()`](chemfp_toplevel.html#chemfp.heapsweep "chemfp.heapsweep") functions provide
access to the low-level data structure as the attribute `out`.
Originally this was stored in the `result` attribute but experience
showed that referring to the low-level object as `result.result` was
more confusing than using `result.out`. The `out` alias for
`result` was added in chemp 4.2. Using `result` in chemfp 5.0
gives a PendingDeprecationWarning. In chemfp 5.1 it will give a
DeprecationWarning, with removal in chemfp 5.2.

WARNING: RDKit 2024.09.3 fixed a bug in how Morgan fingerprints
handled chiral atoms (see “[Morgan fingerprints with chirality
distinguish chiral atoms too early](https://github.com/rdkit/rdkit/issues/7986)”), causing some
fingerprints to change when `includeChirality=1`. This does not affect
the default Morgan fingerprints, which has `includeChirality=0`.

Previously this would trigger a version number change in the chemfp
fingerprint, from RDKit-Morgan/2 to RDKit-Morgan/3. However, by design
the version number change triggers downstream compatibility warnings,
because chemfp has no way to figure out if the version difference is
meaningful for a given set of options, and I haven’t figured out a
good solution.

WARNING: RDKit versions 2024.9.2 changed the implementation of
`includeRedundantEnvironments=1` but the RDKit-Morgan version number
has not changed, for the same reason as above.

NOT YET: The chemfp 4.2 release notes mention that chemfp 5.0 will
change so that progress bars aren’t shown unless there is a certain
minimum delay. This change has not been done, but may in the future.

NOT YET: The chemfp 4.2 release notes mention that the “npz” JSON
metadata array format “will likely change”, to be more consistent with
then-new simarray JSON. This has not yet happened but may in the
future.

## Updated FPB format[](#updated-fpb-format "Link to this heading")

The original FPB format could not handle more than about 270 million
fingerprints due to an implementation detail in the “HASH” chunk.
Chemfp 5.0 supports a new “HSH2” chunk which should handle at least 2
billion fingerprints, though it has only been tested with [977
million fingerprints](tools.html#gdb13-fpb) from GDB-13.

See the [FPB specification](https://chemfp.com/fpb_format/) for
details.

Warning

Even though the `--max-spool-size` of the
[fpcat](fpcat_command.html#fpcat) command-line tool helps limit the amount
of RAM needed, the final FPB generation step loads all of the ids
into memory. You will likely need about 35-40 GB of RAM to
generate an FPB file with 1 billion fingerprints.

## shardsearch[](#shardsearch "Link to this heading")

The new [chemfp shardsearch](chemfp_shardsearch_command.html#chemfp-shardsearch) command-line
tool does similarity search across multiple target files, possibly in
parallel, and merges the result.

Chemfp’s [simsearch](simsearch_command.html#simsearch) searches a single target
file. Sometimes it is useful to search multiple target files, which
I’ll refer to as a “shard.”

The most common case is to work with data sets in the ~1-10 billion
fingerprint range, where it is difficult or impossible to store all of
the data into a single FPB file, even with the new HSH2 chunk
mentioned above. Instead, split the data set into a dozen or two
shards of 100M-200M fingerprints each.

```
% chemfp shardsearch --query 'Cn1cnc2c1c(=O)[nH]c(=O)n2C' \
        --threshold 0.2 shard*.fpb --out csv
query_id,target_id,score
Query1,CHEMBL327316,0.2203390
Query1,CHEMBL539424,0.2340426
```

Another common case is to handle data sets which are larger than
available RAM. Chemfp by default uses memory-mapped FPB files, which
lets it work with datasets that are larger than memory. While the
operating system will cache the most commonly used parts of the file,
as the file size increases the cache becomes less useful, which means
the data must be re-read from the much slower hard disk or network
file system.

What should take seconds in RAM may instead take 20 minutes.

Shardsearch can be configured to process a user-defined number of
queries against each shard in order. If the shard fits into memory
then the data is only loaded either “each-time”, “onces”, or before
the “first” search.

The documentation contains several :ref`:examples of using shardsearch
<chemfp\_shardsearch\_intro>`.

If the shards are on a network file system then you should compress
the FPB files with ZStandard, that is, as fpb.zst files, because most
of the time will be spent transfering the data from the remote
computer, and decompressing is fast. See the [shardsearch load
guidelines](tools.html#shardsearch-load-guidelines) for a more detailed
description.

Finally, some data sets have a monthly or quarterly primary release
with daily or weekly updates for records which changed. It can be
easier to use one shard for each update cycle, do the shardsearch, and
post-process the output to handle possible duplicates than to create a
single FPB file for the entire dataset.

## simhistogram[](#simhistogram "Link to this heading")

The new “simhistogram” feature computes a histogram of the Tanimoto
similarity scores in a fingerprint dataset with itself (“NxN”), or
between two different fingerprint datasets (“NxM”). It is available
using the [chemfp simhistogram](chemfp_simhistogram_command.html#chemfp-simhistogram)
command-line tool or in the Python API using the
[`chemfp.simhistogram()`](chemfp_toplevel.html#chemfp.simhistogram "chemfp.simhistogram") function.

The command-line tool, when used to generate an NxM histogram, can
also include the NxN histograms for each of the two input dataset.

These histograms can give a sense of the overall similarity
distribution. For example, the following image shows the distribution
of Tanimoto scores between ChEBI and ChEMBL, and compares that
distribution with the distribution of scores for each dataset with
itself.

![Histograms of the Tanimoto score distribution of ChEBI vs ChEMBL, and of each dataset with itself. Based on 100,000 random samples (without duplicates) using 2048-bit RDKit Morgan fingerprints with radius 2.](_images/histogram_chebi_chembl.png)

It was generated on the command-line with the following command-line,
the progress bar, and the first 27 lines of output (the first line of
output starts with `#simhistogram/1`):

```
% chemfp simhist --queries chebi_morgan.fpb chembl_35.fpb \
      --num-samples 100_000 --include-inputs
NxM: 100%|██████████████████████████| 100000/100000 [00:03<00:00, 31624.51/s]
#simhistogram/1 identity-bin=0
#type=sample matrix-type=NxM bins=100 num-samples=100000 seed=1719484950
#size=281256950220 queries=113658 targets=2474590
#identical=0
#average=0.090 min=0.085 max=0.095
#queries-type=sample matrix-type=upper-triangular bins=100 num-samples=100000 seed=2822803993
#queries-size=6459013653 N=113658
#queries-identical=3
#queries-average=0.098 min=0.093 max=0.103
#targets-type=sample matrix-type=upper-triangular bins=100 num-samples=100000 seed=336081226
#targets-size=3061796596755 N=2474590
#targets-identical=0
#targets-average=0.111 min=0.106 max=0.116
#queries=chebi_morgan.fpb
#targets=chembl_35.fpb
start end     count   percent queries_count   queries_percent targets_count   targets_percent
0.00  0.01    1981    1.981   3492    3.492   110     0.110
0.01  0.02    2166    2.166   2436    2.436   278     0.278
0.02  0.03    2837    2.837   3087    3.087   533     0.533
0.03  0.04    4048    4.048   4014    4.014   1043    1.043
0.04  0.05    5646    5.646   5696    5.696   2023    2.023
0.05  0.06    7541    7.541   7633    7.633   3756    3.756
0.06  0.07    8779    8.779   8854    8.854   5775    5.775
0.07  0.08    9532    9.532   9401    9.401   7931    7.931
0.08  0.09    9937    9.937   9563    9.563   9842    9.842
0.09  0.10    8784    8.784   8215    8.215   9944    9.944
0.10  0.11    8901    8.901   8102    8.102   11587   11.587
```

The **simhist** subcommand is an alias for
**simhistogram**.

This shows the default output format, which includes a header second
containing metadata about the calculation. Use `--out` or an
appropriate output filename extension to get just the histogram data
formatted as “tsv” or “csv”.

### simhistogram output header[](#simhistogram-output-header "Link to this heading")

The output contains a header followed by the histogram lines. The
first header line identifies the format version and subtype. The
`#type` line describes how the histogram was generated, including
any parameters. In this case it contains 100,000 scores randomly
sampled from an NxM similarity matrix, placed into 100 bins. The
initial RNG seed, in this case generated by Python’s built-in RNG,
is 1719484950.

The `#size` line reports the ChEBI and ChEMBL datasets have 113,658
and 2,474,590 fingerprints, respectively, so the full NxM comparison
matrix contains over 281 billion scores.

Based on the histogram data (computing by the weighted average of
`bin count * bin center`), the `#average` ChEBI vs. ChEMBL score
is 0.090. This may not be the actual average score as the actual
scores may be anywhere in the bin, but it’s certainly between 0.093
and 0.103, because in this case the bin width is 0.1 and there are no
`#identical` scores. (Internally chemfp always places the identical
scores in their own bin, with a bin center of 1.0 and width of 0.0,
even with the default of `--no-identity-bin`, which affects how
average, min, and max are calculated.)

The lines starting `#queries-` give the corresponding details for
strictly upper-diagonal triange of the similarity scores of the
`--queries` dataset with itself, and the lines starting `#targets-`
do the same for the targets.

The `#queries` and `#targets` lines describe the source for the
queries and targets, which is typically the filename.

By default (with `--no-identity_bin`) there are N bins and each bin
has the width `N / --num-bins`. The first `N-1` bins are
half-closed/half-open, while the last bin is closed. For example, if
there are 2 bins then bin 0 contains the count of scores S where `0
<= S < 0.5`, and bin 1 contains the count of scores where `0 <= S <=
0.5`.

With `--identity-bin`, the first N bins are all half-closed/half
open, and last bin contains the count of sc