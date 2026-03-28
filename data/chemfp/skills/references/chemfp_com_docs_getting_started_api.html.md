[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* [Command-line examples for binary fingerprints](tools.html)
* [Command-line examples for sparse count fingerprints](count_tools.html)
* [The chemfp command-line tools](tool_help.html)
* Getting started with the API
  + [Get ChEMBL 34 fingerprints in FPB format](#get-chembl-34-fingerprints-in-fpb-format)
  + [Similarity search of ChEMBL by id](#similarity-search-of-chembl-by-id)
  + [Similarity search of ChEMBL using a SMILES](#similarity-search-of-chembl-using-a-smiles)
  + [Sorting the search results](#sorting-the-search-results)
  + [Fingerprints as byte strings](#fingerprints-as-byte-strings)
  + [Generating Fingerprints](#generating-fingerprints)
  + [Similarity Search of ChEMBL by fingerprint](#similarity-search-of-chembl-by-fingerprint)
  + [Load fingerprints into an arena](#load-fingerprints-into-an-arena)
  + [Generate an NxN sparse similarity matrix](#generate-an-nxn-sparse-similarity-matrix)
  + [Generate an NxM similarity matrix](#generate-an-nxm-similarity-matrix)
  + [Exporting SearchResults to SciPy and NumPy](#exporting-searchresults-to-scipy-and-numpy)
  + [Save simsearch results to an npz file](#save-simsearch-results-to-an-npz-file)
  + [Use simarray to generate a NumPy array](#use-simarray-to-generate-a-numpy-array)
  + [Compute your own metric with “abcd”](#compute-your-own-metric-with-abcd)
  + [Save a simarray to an npy file](#save-a-simarray-to-an-npy-file)
  + [Direct histogram generation](#direct-histogram-generation)
  + [Generating fingerprint files](#generating-fingerprint-files)
  + [Generating fingerprints with an alternative type](#generating-fingerprints-with-an-alternative-type)
  + [Extracting fingerprints from SDF tags](#extracting-fingerprints-from-sdf-tags)
  + [Butina clustering](#butina-clustering)
  + [Butina clustering parameters](#butina-clustering-parameters)
  + [Butina clustering with a precomputed matrix](#butina-clustering-with-a-precomputed-matrix)
  + [The effect of Butina threshold size when clustering ChEMBL](#the-effect-of-butina-threshold-size-when-clustering-chembl)
  + [Select diverse fingerprints with MaxMin](#select-diverse-fingerprints-with-maxmin)
  + [Use MaxMin with references](#use-maxmin-with-references)
  + [Select diverse fingerprints with Heapsweep](#select-diverse-fingerprints-with-heapsweep)
  + [Sphere exclusion](#sphere-exclusion)
  + [Directed sphere exclusion](#directed-sphere-exclusion)
* [Fingerprint family and type examples](fingerprint_types.html)
* [Toolkit API examples](toolkit.html)
* [Text toolkit examples](text_toolkit.html)
* [chemfp API](chemfp_api.html)
* [Licenses](licenses.html)
* [What’s new in chemfp 5.1](whats_new_in_51.html)
* [What’s new in chemfp 5.0](whats_new_in_50.html)
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* Getting started with the API

---

# Getting started with the API[](#getting-started-with-the-api "Link to this heading")

Chemfp has [an extensive Python API](chemfp_toplevel.html#chemfp-toplevel). This
chapter gives examples of how to use the high-level commands for
different types of [similarity search](#simsearch-api-with-query-id), [similarity arrays](#simarray-api), [fingerprint generation](#to-fps-api) and
[extraction](#sdf2fps-api), [Butina clustering](#butina-api), and [MaxMin](#maxmin-api) and [sphere
exclusion](#spherex-api) diversity picking.

## Get ChEMBL 34 fingerprints in FPB format[](#get-chembl-34-fingerprints-in-fpb-format "Link to this heading")

Many of the examples in this section use the RDKit Morgan fingerprints
for ChEMBL 32. These are available in [FPS format](https://ftp.ebi.ac.uk/pub/databases/chembl/ChEMBLdb/releases/chembl_34/chembl_34.fps.gz)
from ChEMBL. I distributed a version in [FPB format](https://chemfp.com/datasets/chembl_34.fpb.gz) which includes a
chemfp license key to unlock all chemfp functionality for that file.

You will need to download and uncompress that file. Here is one way:

```
% curl -O https://chemfp.com/datasets/chembl_34.fpb.gz
% gunzip chembl_34.fpb.gz
```

The FPB file includes the required ChEMBL notices. To see them use:

```
% chemfp fpb_text chembl_34.fpb
```

## Similarity search of ChEMBL by id[](#similarity-search-of-chembl-by-id "Link to this heading")

In this section you’ll use the high-level subsearch command to find
the closest neighbors to a named fingerprint record.

[CHEMBL113](https://www.ebi.ac.uk/chembl/compound_report_card/CHEMBL113/) is
the ChEMBL record for caffeine.

What are the 5 most similar fingerprints in ChEMBL 32?

Chemfp has several “high-level” functions which provide a lot of
functionality through a single function call. The
[`chemfp.simsearch()`](chemfp_toplevel.html#chemfp.simsearch "chemfp.simsearch") function, like the [simsearch](simsearch_command.html#simsearch) command, implements similarity searches.

If given a query id and a target filename then it will open the target
fingerprints, find the first fingerprint whose the id matches the
query id, and use that fingerprint for a similarity search. When no
search parameters are specified, it does a Tanimoto search for the 3
nearest neighbors, which in this case will include CHEMBL113 itself.

```
>>> import chemfp
>>> result = chemfp.simsearch(query_id="CHEMBL113", targets="chembl_34.fpb")
>>> result
SingleQuerySimsearch('3-nearest Tanimoto search. #queries=1, #targets=2409270
(search: 46.64 ms total: 68.10 ms)', result=SearchResult(#hits=3))
```

The [`SingleQuerySimsearch`](chemfp_highlevel_similarity.html#chemfp.highlevel.similarity.SingleQuerySimsearch "chemfp.highlevel.similarity.SingleQuerySimsearch") summaries the query and the search
times. In this case it took about 47 milliseconds for the actual
fingerprint search, and 68 milliseconds total; the high-level
organization also has some overhead.

Note

Timings are highly variable. It took 68 ms because the content was
in disk cache. With a clear cache it took 210 ms total.

The simsearch result object depends on the type of search. In this case
it was a single query vs. a set of targets. The two other supported
cases 1) multiple queries against a set of targets, and 2) using the
same fingerprints for both targets and queries (a “NxN” search).

The result is a wrapper (really, a proxy) for the underlying search
object, which you can get through `result.out`:

```
>>> result.out
SearchResult(#hits=3)
```

You can access the underlying object directly, but I found myself
often forgetting to do that, so the simsearch result objects also
implement the underlying search result(s) API, by forwarding them to
the actual result, which lets you do things like:

```
>>> result.get_ids_and_scores()
[('CHEMBL113', 1.0), ('CHEMBL4591369', 0.7333333333333333), ('CHEMBL1232048', 0.7096774193548387)]
```

As expected, CHEMBL113 is 100% identical to itself. The next closest
records are [CHEMBL4591369](https://www.ebi.ac.uk/chembl/compound_report_card/CHEMBL4591369/)
and [CHEMBL1232048](https://www.ebi.ac.uk/chembl/compound_report_card/CHEMBL1232048/).

If you have Pandas installed then use [`SearchResult.to_pandas()`](chemfp_search.html#chemfp.search.SearchResult.to_pandas "chemfp.search.SearchResult.to_pandas")
to export the target id and score to a Pandas Dataframe:

```
>>> result.to_pandas()
       target_id     score
0      CHEMBL113  1.000000
1  CHEMBL4591369  0.733333
2  CHEMBL1232048  0.709677
```

The k parameter specifies the number of neighbors to select. The
following finds the 10 nearest neighbors and exports the results to a
Pandas table using the columns “id” and “Tanimoto”:

```
>>> chemfp.simsearch(query_id="CHEMBL113",
...      targets="chembl_34.fpb", k=10).to_pandas(columns=["id", "Tanimoto"])
              id  Tanimoto
0      CHEMBL113  1.000000
1  CHEMBL4591369  0.733333
2  CHEMBL1232048  0.709677
3   CHEMBL446784  0.677419
4  CHEMBL1738791  0.666667
5  CHEMBL2058173  0.666667
6   CHEMBL286680  0.647059
7   CHEMBL417654  0.647059
8  CHEMBL2058174  0.647059
9  CHEMBL1200569  0.641026
```

## Similarity search of ChEMBL using a SMILES[](#similarity-search-of-chembl-using-a-smiles "Link to this heading")

In this section you’ll use the high-level subsearch command to find
target fingerprints which are at least 0.75 similarity to a given
SMILES string. The [next section](#simsearch-api-sort-results)
will show how to sort by score.

[Wikipedia](https://en.wikipedia.org/wiki/Capsaicin) gives
`O=C(NCc1cc(OC)c(O)cc1)CCCC/C=C/C(C)C` as a SMILES for
capsaicin. What ChEMBL structures are at leat 0.75 similar to that
SMILES?

The [`chemfp.simsearch()`](chemfp_toplevel.html#chemfp.simsearch "chemfp.simsearch") function supports many types of query
inputs. The previous section used used a query id to look up the
fingerprint in the targets. Alternatively, the `query` parameter
takes a string containing a structure record, by default in “smi”
format. (Use `query_format` to specify “sdf”, “molfile”, or other
supported format.):

```
>>> import chemfp
>>> result = chemfp.simsearch(query = "O=C(NCc1cc(OC)c(O)cc1)CCCC/C=C/C(C)C",
...     targets="chembl_34.fpb", threshold=0.75)
>>> len(result)
23
>>> result.to_pandas()
        target_id     score
0   CHEMBL4227443  0.791667
1     CHEMBL87171  0.795918
2     CHEMBL76903  0.764706
3     CHEMBL80637  0.764706
4     CHEMBL86356  0.764706
5     CHEMBL88024  0.764706
6     CHEMBL87024  0.764706
7     CHEMBL89699  0.764706
8     CHEMBL88913  0.764706
9     CHEMBL89176  0.764706
10    CHEMBL89356  0.764706
11    CHEMBL89829  0.764706
12   CHEMBL121925  0.764706
13   CHEMBL294199  1.000000
14   CHEMBL313971  1.000000
15   CHEMBL314776  0.764706
16   CHEMBL330020  0.764706
17   CHEMBL424244  0.764706
18  CHEMBL1672687  0.764706
19  CHEMBL1975693  0.764706
20  CHEMBL3187928  1.000000
21    CHEMBL88076  0.750000
22   CHEMBL313474  0.750000
```

The next section will show how to sort the results by score.

## Sorting the search results[](#sorting-the-search-results "Link to this heading")

The [previous section](#simsearch-api-with-query-smiles) showed
how to find all ChEMBL fingerprints with 0.75 similarity to
capsaicin. This section shows how to sort the scores in chemfp, which
is faster than using Pandas to sort.

While chemfp’s k-nearest search orders the hits from highest to
lowest, the threshold search order is arbitrary (or more precisely,
based on implementation-specific factors). If you want sorted scores
in the Pandas table you could do so using Pandas’ `sort_values`
method, as in the following:

```
>>> chemfp.simsearch(query = "O=C(NCc1cc(OC)c(O)cc1)CCCC/C=C/C(C)C",
...     targets="chembl_34.fpb", threshold=0.75).to_pandas().sort_values("score", ascending=False)
        target_id     score
20  CHEMBL3187928  1.000000
14   CHEMBL313971  1.000000
13   CHEMBL294199  1.000000
1     CHEMBL87171  0.795918
0   CHEMBL4227443  0.791667
19  CHEMBL1975693  0.764706
18  CHEMBL1672687  0.764706
17   CHEMBL424244  0.764706
16   CHEMBL330020  0.764706
15   CHEMBL314776  0.764706
12   CHEMBL121925  0.764706
11    CHEMBL89829  0.764706
10    CHEMBL89356  0.764706
9     CHEMBL89176  0.764706
8     CHEMBL88913  0.764706
7     CHEMBL89699  0.764706
6     CHEMBL87024  0.764706
5     CHEMBL88024  0.764706
4     CHEMBL86356  0.764706
3     CHEMBL80637  0.764706
2     CHEMBL76903  0.764706
21    CHEMBL88076  0.750000
22   CHEMBL313474  0.750000
```

However, it’s a bit faster to have chemfp sort the results before
exporting to Pandas. (For a large data set, about 10x faster.)

The simsearch `ordering` parameter takes one of the following
strings:

* “increasing-score” - sort by increasing score
* “decreasing-score” - sort by decreasing score
* “increasing-score-plus” - sort by increasing score, break ties by increasing index
* “decreasing-score-plus” - sort by decreasing score, break ties by increasing index
* “increasing-index” - sort by increasing target index
* “decreasing-index” - sort by decreasing target index
* “move-closest-first” - move the hit with the highest score to the first position
* “reverse” - reverse the current ordering

Here’s how order the simsearch results by “decreasing-score”:

```
>>> chemfp.simsearch(query = "O=C(NCc1cc(OC)c(O)cc1)CCCC/C=C/C(C)C",
...     targets="chembl_34.fpb", threshold=0.75, ordering="decreasing-score").to_pandas()
        target_id     score
0    CHEMBL294199  1.000000
1    CHEMBL313971  1.000000
2   CHEMBL3187928  1.000000
3     CHEMBL87171  0.795918
4   CHEMBL4227443  0.791667
5     CHEMBL76903  0.764706
6     CHEMBL80637  0.764706
7     CHEMBL86356  0.764706
8     CHEMBL88024  0.764706
9     CHEMBL87024  0.764706
10    CHEMBL89699  0.764706
11    CHEMBL88913  0.764706
12    CHEMBL89176  0.764706
13    CHEMBL89356  0.764706
14    CHEMBL89829  0.764706
15   CHEMBL121925  0.764706
16   CHEMBL314776  0.764706
17   CHEMBL330020  0.764706
18   CHEMBL424244  0.764706
19  CHEMBL1672687  0.764706
20  CHEMBL1975693  0.764706
21    CHEMBL88076  0.750000
22   CHEMBL313474  0.750000
```

## Fingerprints as byte strings[](#fingerprints-as-byte-strings "Link to this heading")

In this section you’ll learn how chemfp uses byte strings to represent
a fingerprint.

Chemfp works with binary fingerprints, typically in the range of a few
hundred to a few thousand bits, and with a bit density high enough
that sparse representations aren’t useful.

There are several common ways to represent these fingerprints. Chemfp
uses a byte string, including at the Python level. (Two common
alternatives are to have detected “fingerprint object”, or to re-use
something like Python’s arbitrary-length integers.)

Here, for example, is a 24-bit fingerprint in Python:

```
>>> fp = b"XYZ"
```

The leading ‘b’ indicates the string is a byte string.

Remember, normal Python strings (also called Unicode strings) are
different from byte strings. Byte strings are a sequence of 8-bits
values, while normal strings use a more complicated representation
that can handle the diversity of human language.

Chemfp includes functions in the bitops module to work with
byte-string fingerprints. For example, here are the positions of the
on-bits in the fingerprint:

```
>>> from chemfp import bitops
>>> bitops.byte_to_bitlist(b"XYZ")
[3, 4, 6, 8, 11, 12, 14, 17, 19, 20, 22]
>>> bitops.byte_to_bitlist(b"ABC")
[0, 6, 9, 14, 16, 17, 22]
```

and here is the Tanimoto between those two byte strings:

```
>>> bitops.byte_tanimoto(b"ABC", b"XYZ")
0.2857142857142857
```

You can verify they share bits 6, 14, 17, and 22, while the other 10
bits are distinct, giving a Tanimoto of 4/14 = 0.2857142857142857.

If you are working with hex-encoded fingerprints then you can use
Python’s bytestring methods to convert to- and from- those values:

```
>>> b"ABC".hex()
'414243'
>>> bytes.fromhex("4101ff")
b'A\x01\xff'
```

Python’s fromhex() does not accept a byte s