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
* What’s new in chemfp 5.1b1
  + [Background](#background)
  + [Backwards-incompatible changes](#backwards-incompatible-changes)
  + [rdkit2fps “superimposed” count simulation](#rdkit2fps-superimposed-count-simulation)
  + [count fingerprint API](#count-fingerprint-api)
  + [FPC format and fps2fps conversion changes](#fpc-format-and-fps2fps-conversion-changes)
  + [Other changes](#other-changes)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* What’s new in chemfp 5.1b1

---

# What’s new in chemfp 5.1b1[](#what-s-new-in-chemfp-5-1b1 "Link to this heading")

Version 5.1b1 was released on 20 February 2026.

The main additions to chemfp 5.1 are:

* RDKit countSimulation supports a new “superimposed” value
* FPC file parsing is twice as fast.
* Sparse count fingerprint conversion using “fold” and “superimposed”
  is 2-3 times faster.
* Experimental API for count fingerprints is now public
* Support for Python 3.14 and reduced support for Python 3.9.

See below for more details.

## Background[](#background "Link to this heading")

Most of the work for this release went into writing the paper
“Superimposed Coding of Count Fingerprints to Binary Fingerprints.”
The paper shows that if random superimposed coding is use to convert
count fingerprints to binary fingerprints then a Tanimoto
nearest-neighbor search of the binary fingerprints is a good
approximation of the multset Tanimoto of the original count
fingerprints, and better than using RDKit’s count simulation
method. (The multset Tanimoto is also referred to as the MinMax
kernel, among others.)

Information from that paper has informed changes and improvments to
this release of chemfp.

That research started when I was writing the documentation for the
[chemfp fpc2fps](chemfp_fpc2fps_command.html#chemfp-fpc2fps) subcommand added to chemfp
5.0. It implements several methods to convert sparse count
fingerprints into binary. I noticed that the “superimposed” method was
better than RDKit’s “countsim” at approximating the count Tanimoto.

After chemfp 5.0 explored this topic in more detail. Among other
things, I learned that there are two forms of the count Tanimoto –
the vector Tanimoto from the 1980s and the multiset Tanimoto from the
early 2000s. Of the two, I prefer the multiset Tanimoto, which is why
RDKit (and now chemfp) implements.

We can interpret count simulation as way to convert a count
fingerprint to a byte fingerprint such that the Tanimoto
nearest-neighbor search of the byte fingerprint acts as an approximate
nearest-neighbor search of the original count fingerprints. The
k-recall@k score is a way to compare different approximatation
method. Given the k-nearest neighbors in the approximate (binary)
Tanimoto search, which fraction are also k-nearest neighbors in the
exact (count) search?

I found that the recall rate for superimposed conversion was higher
(in the 0.95 range) than RDKit’s count simultation (around 0.85) or
simple folding (around 0.8). The chemfp 5.1 release is very much
informed by the results of that research.

I also found that setting more than one bit per feature was not useful
for normal bit densities. That is, using 2 bits per feature gave worse
recall than 1 bit per feature. This can be compensated by doubling the
number of bits, in which case the recall is slightly better. However,
doubling the fingerprint size while using 1 bit per feature was better
still.

This strongly suggests that RDKit’s default numBitsPerFeature=2 for the
RDKit fingerprint should instead be numBitsPerFeature=1.

A paper about research has been submitted to the Journal of
Cheminformatics. A preprint is available as “[Superimposed Coding of
Count Fingerprints to Binary Fingerprints](https://chemrxiv.org/doi/full/10.26434/chemrxiv-2026-j3hbj)” from
ChemRxiv.

## Backwards-incompatible changes[](#backwards-incompatible-changes "Link to this heading")

Python 3.9 end-of-life was 2025 October 31. While the chemfp 5.1
source distribution has been tested with Python 3.9, pre-compiled
manylinux wheels are no longer distributed. Python 3.9 will be not be
supported in future chemfp releases.

Warning

Changed default value of numBitsPerFeature in rdkit2fpc.

The default value of numBitsPerFeature for the RDKit fingerprint
generator is 2. The research described above strongly suggests that
setting more than 1 bit per feature does not improve
similarity. Therefore, in [chemfp rdkit2fpc](chemfp_rdkit2fpc_command.html#chemfp-rdkit2fpc),
the default value for numBitsPerFeature has been changed from 2 to
1. The numBitsPerFeature value is now always included in the metadata
to reduce possible confusion between the RDKit and chemfp defaults.

For backwards-compatibly, the default value in [rdkit2fps](rdkit2fps_command.html#rdkit2fps) has not changed.

NOT YET: The chemfp 4.2 release notes mention that chemfp 5.0 will
change so that progress bars aren’t shown unless there is a certain
minimum delay. This change has not been done, but may in the future.

NOT YET: The chemfp 4.2 release notes mention that the “npz” JSON
metadata array format “will likely change”, to be more consistent with
then-new simarray JSON. This has not yet happened but may in the
future.

## rdkit2fps “superimposed” count simulation[](#rdkit2fps-superimposed-count-simulation "Link to this heading")

The [rdkit2fps](rdkit2fps_command.html#rdkit2fps) `--countSimulation` command-line
parameter now also accepts “superimposed” as an option, in addition to
“0” for modulo folding ignoring counts over 1, and “1” for RDKit’s
count simulation method.

This option is available for the RDK, Morgan, AtomPair and Torsion
fingerprints.

```
% echo "c1ccccc1O phenol" | rdkit2fps --fpSize 128 --no-date
#FPS1
#num_bits=128
#type=RDKit-Morgan/2 fpSize=128 radius=3 useFeatures=0
#software=RDKit/2025.09.4 chemfp/5.1b1
20800008808000000700420010020400      phenol
%
% echo "c1ccccc1O phenol" |
     rdkit2fps --fpSize 128 --countSimulation superimposed --no-date
#FPS1
#num_bits=128
#type=RDKit-Morgan/2 fpSize=128 radius=3 useFeatures=0 countSimulation=superimposed
#software=RDKit/2025.09.4 chemfp/5.1b1
26040850080a824c0800108001181000      phenol
```

These fingerprints set respectively 13 and 22 bits. The corresponding
count fingerprint using [chemfp rdkit2fpc](chemfp_rdkit2fpc_command.html#chemfp-rdkit2fpc),
and with a newline added for formatting, is:

```
% echo "c1ccccc1O phenol" | chemfp rdkit2fpc --numBitsPerFeature 2 --no-date
#FPC1
#num_bits=18446744073709551615
#type=RDKit-MorganCount/2 radius=3 useFeatures=0
#software=RDKit/2025.09.4 chemfp/5.1b1
26234434,98513984:3,251179073:2,742000539,859799282,864662311,951226070:2,
2763854213,2905660137,2985234959,3217380708,3218693969:5,3999906991:2 phenol
```

which has 13 features and a total count of 22.

Note that rdkit2fpc requires using `--numBitsPerFeature 2` to match
the fingerprints generated by rdkit2fps as the default value for those
two programs are different!

In case you are wondering, the RDKit count simulation generates a
fingerprint with 18 bits, which is in between the other two methods:

```
% echo "c1ccccc1O phenol" | rdkit2fps --fpSize 128 --countSimulation 1 --no-date
#FPS1
#num_bits=128
#type=RDKit-Morgan/2 fpSize=128 radius=3 useFeatures=0 countSimulation=1
#software=RDKit/2025.09.4 chemfp/5.1b1
33011110100000307001000300100000      phenol
```

## count fingerprint API[](#count-fingerprint-api "Link to this heading")

This release introduces an API for working with count fingerprints. It
is still in development and subject to change, but is stable enough
for the bold and the curious.

In chemfp 5.0 a count fingerprint was stored as a Python
dictionary. This was not part of the public API. With chemfp 5.1 it is
now its own [`CountFingerprint`](chemfp_countops.html#chemfp.countops.CountFingerprint "chemfp.countops.CountFingerprint") data type, and available for
wider use. Each count fingerprint feature has a 64-bit unsigned index
and a 32-bit unsigned count. A fingerprint may have at most 1 million
features.

One consequence of switching from a Python dictionary to a C data type
is that reading an FPC file is twice as fast. This, combined with
other optimizations, has lead to a 2-3x performance improvement in
[fpc2fps](chemfp_fpc2fps_command.html#chemfp-fpc2fps) when using the “fold” or “superimpose”
methods.

To read count fingerprints from an FPC file, use
[`read_count_fingerprints()`](chemfp_toplevel.html#chemfp.read_count_fingerprints "chemfp.read_count_fingerprints"). To read them from a string use
[`read_count_fingerprints_from_string()`](chemfp_toplevel.html#chemfp.read_count_fingerprints_from_string "chemfp.read_count_fingerprints_from_string").

```
>>> import chemfp
>>> reader = chemfp.read_count_fingerprints("Morgan3/sparse.fpc")
>>> next(reader)
('CHEMBL440245', CountFingerprint(#features=245))
>>> id, fp = _
>>> len(fp)
245
>>> fp[0]
(8819703, 1)
>>> list(fp)[:3]
[(8819703, 1), (10565946, 6), (21411075, 1)]
```

The [`chemfp.countops`](chemfp_countops.html#module-chemfp.countops "chemfp.countops") contains functions to work with count
fingerprints. There are ways to convert them to and from the binary
string for RDKit’s UInt and ULong count fingerprints, and to and from
FPC-encoded fingerprints, and to parse an FPC-encoded fingerprint to
Python dictionary.

```
>>> from chemfp import countops
>>> fp = countops.CountFingerprint.from_features(
...   [(1, 5), (8, 3), (10, 1)])
>>> str(fp)
'1:5,8:3,10'
>>> from rdkit import DataStructs
>>> rdk_fp = DataStructs.UIntSparseIntVect(
...   countops.create_rdkit_binary_UIntSparseIntVect(fp, 128))
>>> rdk_fp
<rdkit.DataStructs.cDataStructs.UIntSparseIntVect object at 0x7d5a597575b0>
>>> rdk_fp.GetNonzeroElements()
{1: 5, 8: 3, 10: 1}
```

You can also compute the Tanimoto between two count fingerprints.

```
>>> id1, fp1 = next(reader)
>>> id2, fp2 = next(reader)
>>> score = countops.count_tanimoto(fp1, f2)
>>> score = countops.count_tanimoto(fp1, fp2)
>>> print(f"score between {id1} and {id2}: {score}")
score between CHEMBL440249 and CHEMBL503643: 0.03484848484848485
```

as well as between two count dictionaries:

```
>>> countops.dict_tanimoto({1: 3, 2: 4}, {1: 2, 4: 1})
0.25
>>> countops.dict_tanimoto(dict(fp1), dict(fp2))
0.03484848484848485
```

If you are interested in working with count fingerprints directly, and
would like to experiment with and provide feedback on the API, please
contact me.

## FPC format and fps2fps conversion changes[](#fpc-format-and-fps2fps-conversion-changes "Link to this heading")

The [FPC format specification](https://chemfp.com/fpc_format/) has
been changed so that a count of 0 is not allowed. Chemfp 5.0 supported
it. That option was removed to make it easier to count the number of
non-zero features in the fingerprint. If the fingerprint field is “\*”
then there are no features, otherwise it is one more than the number
commas.

The specification now specifically includes “num\_bits” in the
metadata, with the same meaning as the FPS format. This is needed
because each RDKit fingerprints also stores the total number of
possible bits, and two fingerprints can be compared if and only if
they have same size. Without this information it is impossible to
round-trip RDKit fingerprints to a file.

Chemfp has been updated to read and write the num\_bits. Note that
RDKit’s UIntSparseIntVect uses 2\*\*32-1 to mean 2\*\*32 bits, and
RDKit’s ULongSparseIntVect uses 2\*\*64-1 to mean 2\*\*64 bits. These
are special cases in RDKit. Chemfp does not currently adjust the size
to reflect the actual number of bits possible.

The “fold” count conversion method in fpc2fps now supports a
`--hash` option. The distribution of RDKit topological torsion
indices after modulo folding are poorly distributed. This is because
the first 9 bits (or 11 bits with `--includeChirality 1`) contain
type information for the first atom, the second 9 (or 11) bits
contains the type information for the second, and so on. Modulo
folding at 1024 bits means that only the first 10 bits are used. For
topological torsions this means only the first atom type and perhaps
one bit of the second type are used – the rest are ignored! Instead,
with `--hash 1` the index is used to seed a pseudo-random number
generator to generate the value to hash. This gives a much better
distribution of hashed values.

The “superimpose” count conversion in fpc2fps now uses a maximum
count, with a default 1000, as an upper-bound for the feature
count. Without it, a fingerprint like “1:4294967295” caused the
converter to take a very long time to generate a byte fingerprint with
all bits set to 1. Use `--max-count` to change the size.

The “rdkit-count-sim” method name in fpc2fpc was changed to
“rdkit-countsim”.

## Other changes[](#other-changes "Link to this heading")

A change in RDKit 2025.09.4 caused some of the SECFP fingerprints to
change. Chemfp refers to these new fingerprints as “RDKit-SECFP/2” and
the older ones as “RDKit-SECFP/1”.

Chemfp 5.0 added support for Python 3.15, NumPy 2.4, and click
8.2. The changes were minimal and limited to the test suite. The
“license” field in pyproject.toml file was updated to reflect a
breaking change to the format.

If the environment variable CHEMFP\_CYTHONIZE is “1” then setup.py will
always cythonize the .pyz files to c, instead of using
timestamps. This is useful if you’ve upgraded Cython and want to
rebuild the cythonized C extensions.

The FPC parser in chemfp 5.0 used terms like “bit number” for the
feature index. This was visible in the error messages like “Sparse bit
number must be < 2\*\*64”. These have been replaced with “feature
index”, such as “Feature index must be < 2\*\*64”.

Finally, there are a number of bug fixes, corrected typos, and other
small changes that aren’t worth noting.

[Previous](licenses.html "Licenses")
[Next](whats_new_in_50.html "What’s new in chemfp 5.0")

---

© Copyright 2010-2026, Andrew Dalke.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).