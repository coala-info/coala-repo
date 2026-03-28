[changeo
![Logo](../_static/changeo.png)](../index.html)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* [Overview](../overview.html)
* [Download](../install.html)
* [Installation](../install.html#installation)
* [Contributing](../contributing.html)
* [Data Standards](../standard.html)
* [Release Notes](../news.html)

Usage Documentation

* [Commandline Usage](../usage.html)
* [API](../api.html)

Examples

* [Using IgBLAST](igblast.html)
* [Parsing IMGT output](imgt.html)
* [Parsing 10X Genomics V(D)J data](10x.html)
* Filtering records
  + [Removing non-productive sequences](#removing-non-productive-sequences)
  + [Removing disagreements between the C-region primers and the reference alignment](#removing-disagreements-between-the-c-region-primers-and-the-reference-alignment)
  + [Exporting records to FASTA files](#exporting-records-to-fasta-files)
    - [Standard FASTA](#standard-fasta)
    - [BASELINe FASTA](#baseline-fasta)
* [Clustering sequences into clonal groups](cloning.html)
* [Reconstructing germline sequences](germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](genbank.html)

Methods

* [Clonal clustering methods](../methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](../methods/germlines.html)

About

* [Contact](../info.html)
* [Citation](../info.html#citation)
* [License](../info.html#license)

[changeo](../index.html)

* Filtering records
* [View page source](../_sources/examples/filtering.rst.txt)

---

# Filtering records[](#filtering-records "Link to this heading")

The [ParseDb.py](../tools/ParseDb.html#parsedb) tool provides a basic set of operations for manipulating
Change-O database files from the commandline, including removing or updating
rows and columns.

## Removing non-productive sequences[](#removing-non-productive-sequences "Link to this heading")

After building a Change-O database from either [IMGT/HighV-QUEST](imgt.html#imgt) or
[IgBLAST](igblast.html#igblast) output, you may wish to subset your data to only
productive sequences. This can be done in one of two roughly equivalent ways
using the [ParseDb.py](../tools/ParseDb.html#parsedb) tool:

```
1ParseDb.py select -d HD13M_db-pass.tsv -f productive -u T
2ParseDb.py split -d HD13M_db-pass.tsv -f productive
```

The first line above uses the **select** subcommand to output a single file
labeled `parse-select` containing only records with the value of `T`
(`-u T`) in the `productive` column
(`-f productive`).

Alternatively, the second line above uses the **split** subcommand to output
multiple files with each file containing records with one of the values found in the
`productive` column (`-f productive`). This will
generate two files labeled `productive-T` and `productive-F`.

## Removing disagreements between the C-region primers and the reference alignment[](#removing-disagreements-between-the-c-region-primers-and-the-reference-alignment "Link to this heading")

If you have data that includes both heavy and light chains in the same library,
the V-segment and J-segment alignments from IMGT/HighV-QUEST or IgBLAST may not
always agree with the isotype assignments from the C-region primers. In these cases,
you can filter out such reads with the **select** subcommand of [ParseDb.py](../tools/ParseDb.html#parsedb).
An example function call using an imaginary file `db.tsv` is provided below:

```
1ParseDb.py select -d db.tsv -f v_call j_call c_call -u "IGH" \
2    --logic all --regex --outname heavy
3ParseDb.py select -d db.tsv -f v_call j_call c_call -u "IG[LK]" \
4    --logic all --regex --outname light
```

These commands will require that all of the `v_call`, `j_call` and `c_call`
fields (`-f v_call j_call c_call` and
`--logic all`) contain the string `IGH` (lines 1-2)
or one of `IGK` or `IGL` (lines 3-4). The `--regex`
argument allows for partial matching and interpretation of regular expressions. The
output from these two commands are two files, one containing only heavy chains
(`heavy_parse-select.tsv`) and one containg only light chains (`light_parse-select.tsv`).

## Exporting records to FASTA files[](#exporting-records-to-fasta-files "Link to this heading")

You may want to use external tools, or tools from [pRESTO](presto.readthedocs.io),
on your Change-O result files. The [ConvertDb.py](../tools/ConvertDb.html#convertdb) tool provides two options for
exporting data from tab-delimited files to FASTA format.

### Standard FASTA[](#standard-fasta "Link to this heading")

The **fasta** subcommand allows you to export sequences and annotations to
FASTA formatted files in the
[pRESTO annototation scheme](http://presto.readthedocs.io/en/stable/overview.html#annotation-scheme):

```
ConvertDb.py fasta -d HD13M_db-pass.tsv --if sequence_id \
    --sf sequence_alignment --mf v_call duplicate_count
```

Where the column containing the sequence identifier is specified by
`--if sequence_id`, the nucleotide sequence column is
specified by `--sf sequence_id`, and additional annotations
to be added to the sequence header are specified by
`--mf v_call duplicate_count`.

### BASELINe FASTA[](#baseline-fasta "Link to this heading")

The **baseline** subcommand generates a FASTA derivative format required by the
[BASELINe](http://selection.med.yale.edu/baseline) web tool. Generating these
files is similar to building standard FASTA files, but requires a few more options.
An example function call using an imaginary file `db.tsv` is provided below:

```
ConvertDb.py baseline -d db.tsv --if sequence_id \
    --sf sequence_alignment --mf v_call duplicate_count \
    --cf clone_id --gf germline_alignment_d_mask
```

The additional arguments required by the **baseline** subcommand include the
clonal grouping (`--cf clone_id`) and germline sequence
(`--gf germline_alignment_d_mask`) columns added by
the [DefineClones](cloning.html#cloning) and [CreateGermlines](germlines.html#germlines) tasks,
respectively.

Note

The **baseline** subcommand requires the `CLONE` column to be sorted.
[DefineClones.py](../tools/DefineClones.html#defineclones) generates a sorted `CLONE` column by default. However,
you needed to alter the order of the `CLONE` column at some point,
then you can re-sort the clonal assignments using the **sort**
subcommand of [ParseDb.py](../tools/ParseDb.html#parsedb). An example function call using an imaginary
file `db.tsv` is provided below:

```
ParseDb.py sort -d db.tsv -f clone_id
```

Which will sort records by the value in the `clone_id` column
(`-f clone_id`).

[Previous](10x.html "Parsing 10X Genomics V(D)J data")
[Next](cloning.html "Clustering sequences into clonal groups")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).