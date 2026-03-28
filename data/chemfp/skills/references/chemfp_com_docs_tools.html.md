[chemfp.com](https://chemfp.com/)

[chemfp documentation](index.html)

* [Installing chemfp](installing.html)
* Command-line examples for binary fingerprints
  + [Generate fingerprint files from PubChem SD tags](#generate-fingerprint-files-from-pubchem-sd-tags)
  + [csv background](#csv-background)
  + [csv2fps command intro](#csv2fps-command-intro)
  + [MolPort csv file](#molport-csv-file)
  + [csv2fps --describe](#csv2fps-describe)
    - [csv character encoding](#csv-character-encoding)
  + [csv2fps column specifiers](#csv2fps-column-specifiers)
    - [structure formats with embedded identifiers](#structure-formats-with-embedded-identifiers)
  + [csv2fps input structure format](#csv2fps-input-structure-format)
    - [csv2fps processing errors](#csv2fps-processing-errors)
  + [Specify csv2fps fingerprint type](#specify-csv2fps-fingerprint-type)
  + [Extract fingerprints from a CSV file](#extract-fingerprints-from-a-csv-file)
  + [k-nearest neighbor search](#k-nearest-neighbor-search)
  + [simsearch CSV output](#simsearch-csv-output)
  + [Threshold search](#threshold-search)
  + [simsearch CSV output when no hits](#simsearch-csv-output-when-no-hits)
  + [Combined k-nearest and threshold search](#combined-k-nearest-and-threshold-search)
  + [Saving simsearch results to “npz” format](#saving-simsearch-results-to-npz-format)
  + [NxN (self-similar) searches](#nxn-self-similar-searches)
  + [Using a toolkit to process the ChEBI dataset](#using-a-toolkit-to-process-the-chebi-dataset)
    - [ChEBI record titles don’t contain the id](#chebi-record-titles-don-t-contain-the-id)
    - [The `--id-tag` option](#the-id-tag-option)
    - [Generate fingerprints with Open Babel](#generate-fingerprints-with-open-babel)
    - [Generate fingerprints with OpenEye](#generate-fingerprints-with-openeye)
    - [Generate fingerprints with RDKit](#generate-fingerprints-with-rdkit)
    - [Generate fingerprints with CDK](#generate-fingerprints-with-cdk)
  + [Use structures as input to simsearch](#use-structures-as-input-to-simsearch)
  + [Make new fingerprints matching the type in an existing file](#make-new-fingerprints-matching-the-type-in-an-existing-file)
  + [Alternate error handlers](#alternate-error-handlers)
  + [chemfp’s two cross-toolkit substructure fingerprints](#chemfp-s-two-cross-toolkit-substructure-fingerprints)
  + [substruct fingerprints](#substruct-fingerprints)
  + [Generate binary FPB files from a structure file](#generate-binary-fpb-files-from-a-structure-file)
  + [Convert between FPS and FPB formats](#convert-between-fps-and-fpb-formats)
  + [Specify the fpcat output format](#specify-the-fpcat-output-format)
  + [Alternate fingerprint file formats](#alternate-fingerprint-file-formats)
  + [The FPB format](#the-fpb-format)
    - [Licensed FPB files](#licensed-fpb-files)
  + [Get licensed FPB files containing ChEMBL 34 fingerprints](#get-licensed-fpb-files-containing-chembl-34-fingerprints)
  + [Similarity search with the FPB format](#similarity-search-with-the-fpb-format)
    - [Performance breakdown](#performance-breakdown)
  + [Multi-core similarity search](#multi-core-similarity-search)
  + [Converting large data sets to FPB format](#converting-large-data-sets-to-fpb-format)
  + [Faster gzip decompression](#faster-gzip-decompression)
  + [bzip2, xv, and other compression formats](#bzip2-xv-and-other-compression-formats)
  + [Generate fingerprints in parallel and merge to FPB format](#generate-fingerprints-in-parallel-and-merge-to-fpb-format)
  + [GDB-13 fingerprints in one FPB](#gdb-13-fingerprints-in-one-fpb)
  + [Single query shardsearch](#single-query-shardsearch)
  + [shardsearch with compressed shards](#shardsearch-with-compressed-shards)
  + [shardsearch with several queries](#shardsearch-with-several-queries)
  + [shardsearch batch size](#shardsearch-batch-size)
  + [shardsearch load strategies](#shardsearch-load-strategies)
    - [Split ChEMBL into 4 shards](#split-chembl-into-4-shards)
    - [Load “each-time” overhead](#load-each-time-overhead)
    - [Load “first” strategy](#load-first-strategy)
    - [Load “once” strategy](#load-once-strategy)
    - [Which shardsearch `--load` to use?](#which-shardsearch-load-to-use)
  + [Generate a full Tanimoto similarity array](#generate-a-full-tanimoto-similarity-array)
  + [Generate the array using another metric or datatype](#generate-the-array-using-another-metric-or-datatype)
  + [Generate a simarray using an “abcd” metric](#generate-a-simarray-using-an-abcd-metric)
  + [Simarray and arrays larger than memory](#simarray-and-arrays-larger-than-memory)
  + [Histogram generation](#histogram-generation)
  + [Histogram identity bin](#histogram-identity-bin)
  + [Increasing histogram accuracy](#increasing-histogram-accuracy)
  + [Histogram between two data sets](#histogram-between-two-data-sets)
  + [Histogram between two datasets, including input histograms](#histogram-between-two-datasets-including-input-histograms)
  + [Butina on the command-line](#butina-on-the-command-line)
    - [Pruning the number of Butina clusters](#pruning-the-number-of-butina-clusters)
  + [Alternate Butina output formats](#alternate-butina-output-formats)
  + [Butina parameter tuning with npz files](#butina-parameter-tuning-with-npz-files)
    - [Number of Butina clusters in ChEMBL](#number-of-butina-clusters-in-chembl)
  + [Sphere exclusion](#sphere-exclusion)
  + [Sphere exclusion output options](#sphere-exclusion-output-options)
  + [Sphere exclusion with initial picks, and saving candidates](#sphere-exclusion-with-initial-picks-and-saving-candidates)
  + [Directed sphere exclusion](#directed-sphere-exclusion)
  + [MaxMin diversity selection](#maxmin-diversity-selection)
  + [The initial MaxMin pick](#the-initial-maxmin-pick)
  + [MaxMin diversity selection including references](#maxmin-diversity-selection-including-references)
  + [Heapsweep diversity selection](#heapsweep-diversity-selection)
  + [Structure file format translation](#structure-file-format-translation)
  + [Structure translation reader and writer args](#structure-translation-reader-and-writer-args)
  + [Structure translation with two toolkits](#structure-translation-with-two-toolkits)
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
* [What’s new in chemfp 4.2](whats_new_in_42.html)
* [What’s new in chemfp 4.1](whats_new_in_41.html)
* [What’s new in chemfp 4.0](whats_new_in_40.html)

[chemfp documentation](index.html)

* Command-line examples for binary fingerprints

---

# Command-line examples for binary fingerprints[](#command-line-examples-for-binary-fingerprints "Link to this heading")

The sections in this chapter show examples of using [the chemfp
command-line tools](tool_help.html#tool-help) to generate and work with binary
fingerprint files. Examples of using the command-line tools for sparse
count fingerprints are in [its own chapter](count_tools.html#using-count-tools).

## Generate fingerprint files from PubChem SD tags[](#generate-fingerprint-files-from-pubchem-sd-tags "Link to this heading")

In this section you’ll learn how to create a fingerprint file from an
SD file which contains pre-computed CACTVS fingerprints. You do not
need a chemistry toolkit for this section.

These files will be re-used in many parts of the documentation.

[PubChem](http://pubchem.ncbi.nlm.nih.gov/) is a great resource of
publically available chemistry information. The data is available for
[download](https://ftp.ncbi.nlm.nih.gov/) (and ftp download). We’ll use some of their [SD formatted](http://en.wikipedia.org/wiki/Structure_Data_File#SDF) files. Each
record has a PubChem/CACTVS fingerprint field, which we’ll extract to
generate an FPS file.

Start by downloading the files Compound\_099000001\_099500000.sdf.gz
(from
<https://ftp.ncbi.nlm.nih.gov/pubchem/Compound/CURRENT-Full/SDF/Compound_099000001_099500000.sdf.gz>
) and Compound\_048500001\_049000000.sdf.gz (from
<https://ftp.ncbi.nlm.nih.gov/pubchem/Compound/CURRENT-Full/SDF/Compound_048500001_049000000.sdf.gzs>
). At the time of writing in June 2024 they contain 10,969 and 14,753
records, respectively. (I chose some of the smallest files so they
would be easier to open and review.)

Next, convert the files into fingerprint files. On the command line
do the following two commands:

```
sdf2fps --pubchem Compound_099000001_099500000.sdf.gz -o pubchem_queries.fps
sdf2fps --pubchem Compound_048500001_049000000.sdf.gz -o pubchem_targets.fps
```

You’ll see a progress bar for each command, which looks like:

```
Compound_099000001_099500000.sdf.gz: 100%|█████████████| 6.99M/6.99M [00:00<00:00, 47.4Mbytes/s]
```

Add the `--no-progress` option to turn off the progess bar, as in:

```
sdf2fps --pubchem Compound_099000001_099500000.sdf.gz -o \
     pubchem_queries.fps  --no-progress
```

Congratulations, that was it!

If you’re curious about what an FPS file looks like, here are the
first 10 lines of pubchem\_queries.fps, with some of the lengthy
fingerprint lines replaced with an ellipsis:

```
#FPS1
#num_bits=881
#type=CACTVS-E_SCREEN/1.0 extended=2
#software=CACTVS/unknown
#source=Compound_099000001_099500000.sdf.gz
#date=2024-06-19T08:14:14+00:00
07de0d00000000 ... 10200000000000000000     99000039
07de1c00020000 ... 00000000000000000000     99000230
074e1c00000000 ... 00000000000000000000     99001517
07de0c00000000 ... 00000400000000000000     99002251
```

How does this work? Each PubChem record contains the precomputed
CACTVS substructure keys in the PUBCHEM\_CACTVS\_SUBSKEYS tag. Here’s
what it looks like for record 99000039, which is the first record in
Compound\_099000001\_099500000.sdf.gz:

```
> <PUBCHEM_CACTVS_SUBSKEYS>
AAADceB7sAAAAAAAAAAAAAAAAAAAAAAAAAA8YIAABYAAAACx9AAAHgAQAA
AADCjBngQ8wPLIEACoAzV3VACCgCA1AiAI2KG4ZNgIYPrA1fGUJYhglgDI
yccci4COAAAAAAQCAAAAAAAACAQAAAAAAAAAAA==
```

The `--pubchem` flag tells [sdf2fps](sdf2fps_command.html#sdf2fps) to get the value
of that tag and decode it to get the fingerprint. It also adds a few
metadata fields to the fingerprint file header.

The order of the FPS fingerprints are the same as the order of the
corresponding record in the SDF. You can see that in the output, where
99000039 is the first record in the FPS fingerprints.

If you store records in an SD file then you almost certainly don’t use
the same fingerprint encoding as PubChem. [sdf2fps](sdf2fps_command.html#sdf2fps) can
decode from a number of encodings, like hex and base64. Use
[sdf2fps --help](sdf2fps_command.html#sdf2fps-help) to see the list of available
decoders.

The example uses `-o` to have sdf2fps write the output to a file
instead of to stdout. By default, filenames ending in “.fps” are saved
in FPS format. Use “.fps.gz” for the gzip-compressed FPS format and
“.fps.zst” for the zstandard-compressed FPS format.

Filenames ending with “.fpb” are saved in FPB format. This is a binary
format which is significantly faster to load.

## csv background[](#csv-background "Link to this heading")

This section provides background about what “csv” means in a chemfp
context. It sets the stage for the next sections.

The term “csv” comes from the initialism for “[Comma-Separated Values](https://en.wikipedia.org/wiki/Comma-separated_values), but is also
used to describe several other related formats, like tab-separated
values, so is something interpreted as “Character-Separated Values”. I
will use to mean the files that can be parsed with Python’s [csv
module](https://docs.python.org/3/library/csv.html) .

In chemfp, the “csv” or “excel” dialect is a comma-separated format
following the quoting rules that Excel uses. (Quoting rules are used
to, for example, allow a comma in a field without it being intepreted
as a separated.) Both “csv” and “excel” are implemented using Python’s
“[excel](https://docs.python.org/3/library/csv.html#csv.excel)”
dialect.

In chemfp, the “tsv” or “excel-tab” dialect is a tab-separated format
following the quoting rules that Excel uses. Both “tsv” and
“excel-tab” are implemented using Python’s “[excel-tab](https://docs.python.org/3/library/csv.html#csv.excel_tab)” dialect.

There is also a “unix” dialect, implemented using Python’s
“[unix\_dialect](https://docs.python.org/3/library/csv.html#csv.unix_dialect)”
dialect, which is another comma-separated dialect.

Python’s csv module lets you specify [your own csv dialect](https://docs.python.org/3/library/csv.html#dialects-and-formatting-parameters),
with options for which delimiter character to use, how escaping and
quoting work, and whether or not initial spaces should be
ignored. These are:

* delimiter: The character used to separate fields
* escapechar: On reading, the escapechar removes any special meaning from the following character
* quotechar: A one-character string used to quote fields containing special characters
* quoting: Controls if the reader should recognize quoting
* skipinitialspace: If True, ignore leading spaces in a field.

For details see [the Python documentation](https://docs.python.org/3/library/csv.html#dialects-and-formatting-parameters),

## csv2fps command intro[](#csv2fps-command-intro "Link to this heading")

In this section you’ll learn about the [chemfp csv2fps](chemfp_csv2fps_command.html#chemfp-csv2fps) command to read structures or fingerprints from
a [csv file](#csv-background).

CSV files are very common, with comma-separated and tab-separated as
the most common. They can be both easy and tricky to parse because
there are so many variations of what “csv” means.

The csv2fps command supports extracting identifiers and structures
from a CSV file to generate fingerprints and generate a fingerprint
file. The following reads a comma-separated CSV file from stdin, uses
the first column as the identifier and the second as the SMILES, then
uses RDKit to generate the MACCS key fingerprint, with the output sent
to stdout in FPS format:

```
% echo "ethane,CC" | chemfp csv2fps --type RDKit-MACCS166 --no-header
#FPS1
#num_bits=166
#type=RDKit-MACCS166/2
#software=RDKit/2024.09.5 chemfp/5.0
#date=2025-09-23T08:30:48+00:00
000000000000000000000000000000000000108000    ethane
```

The `--no-header` is needed because the default assumes the first
line is a header containing column titles, while this example input
does not have a header.

The columns can be referred to by index or column title. For example,
if the input is the three lines

```
CAS,smiles,name
74-84-0,CC,ethane
74-98-6,CCC,propane
```

then the following uses the “name” column for the id and column 2
(column numbers start at 1) for the molecule:

```
% printf "CAS,sm