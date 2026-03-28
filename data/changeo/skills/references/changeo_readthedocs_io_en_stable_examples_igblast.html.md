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

* Using IgBLAST
  + [Example data](#example-data)
  + [Configuring IgBLAST](#configuring-igblast)
  + [Running IgBLAST](#running-igblast)
  + [Processing the output of IgBLAST](#processing-the-output-of-igblast)
* [Parsing IMGT output](imgt.html)
* [Parsing 10X Genomics V(D)J data](10x.html)
* [Filtering records](filtering.html)
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

* Using IgBLAST
* [View page source](../_sources/examples/igblast.rst.txt)

---

# Using IgBLAST[](#using-igblast "Link to this heading")

## Example data[](#example-data "Link to this heading")

We have hosted a small example data set resulting from the
[UMI barcoded MiSeq workflow](https://presto.readthedocs.io/en/stable/workflows/Stern2014_Workflow.html)
described in the [pRESTO](http://presto.readthedocs.io) documentation. In addition to the
example FASTA files, we have included the standalone [IgBLAST](https://ncbi.github.io/igblast)
results. The files can be downloded from here:

[Change-O Example Files](http://clip.med.yale.edu/immcantation/examples/AIRR_Example.tar.gz)

## Configuring IgBLAST[](#configuring-igblast "Link to this heading")

A collection of scripts for setting up the standalone IgBLAST database from the
IMGT reference sequences are available on the
[Immcantation repository](https://github.com/immcantation/immcantation/tree/master/scripts).
To use these scripts, copy all the tools in the `/scripts` folder to a location
in your `PATH`. At a minimum, you’ll need the following scripts:

1. `fetch_igblastdb.sh`
2. `fetch_imgtdb.sh`
3. `clean_imgtdb.py`
4. `imgt2igblast.sh`

Download and configure the IgBLAST and IMGT reference databases
as follows, adjusting the version number to taste:

```
 1# Download and extract IgBLAST
 2VERSION="1.22.0"
 3wget https://ftp.ncbi.nlm.nih.gov/blast/executables/igblast/release/${VERSION}/ncbi-igblast-${VERSION}-x64-linux.tar.gz
 4tar -zxf ncbi-igblast-${VERSION}-x64-linux.tar.gz
 5cp ncbi-igblast-${VERSION}/bin/* ~/bin
 6# Download reference databases and setup IGDATA directory
 7fetch_igblastdb.sh -o ~/share/igblast
 8cp -r ncbi-igblast-${VERSION}/internal_data ~/share/igblast
 9cp -r ncbi-igblast-${VERSION}/optional_file ~/share/igblast
10# Build IgBLAST database from IMGT reference sequences
11fetch_imgtdb.sh -o ~/share/germlines/imgt
12imgt2igblast.sh -i ~/share/germlines/imgt -o ~/share/igblast
```

Note

Several Immcantation tools require the observed V(D)J sequence
(`sequence_alignment`) and associated germline fields (`germline_alignment`
or `germline_alignment_d_mask`) to have gaps inserted to conform to the
IMGT numbering scheme. Thus, when a tool such as [MakeDb.py](../tools/MakeDb.html#makedb) or
[CreateGermlines.py](../tools/CreateGermlines.html#creategermlines) requires a reference sequence set as input,
it will required the IMGT-gapped reference set. Meaning,
the reference sequences that were downloaded using the `fetch_imgtdb.sh`
script, or downloaded manually from the
[IMGT reference directory](http://imgt.org/vquest/refseqh.html),
rather than the final upgapped reference set required by IgBLAST.

See also

The provided scripts download only the mouse and human IMGT reference databases.
See the [IgBLAST documentation](https://ncbi.github.io/igblast) for instructions
on how to build the database in a more general case. Shown below is an example of how
to perform the same steps as the Immcantation scripts using a separately
downloaded IMGT reference set and the scripts provided by IgBLAST. You must have all of
the associated commands in your `PATH` and the appropriate directories created:

```
 1# V segment database
 2edit_imgt_file.pl IMGT_Human_IGHV.fasta > ~/share/igblast/fasta/imgt_human_ig_v.fasta
 3makeblastdb -parse_seqids -dbtype nucl -in ~/share/igblast/fasta/imgt_human_ig_v.fasta \
 4    -out ~/share/igblast/database/imgt_human_ig_v
 5# D segment database
 6edit_imgt_file.pl IMGT_Human_IGHD.fasta > ~/share/igblast/fasta/imgt_human_ig_d.fasta
 7makeblastdb -parse_seqids -dbtype nucl -in ~/share/igblast/fasta/imgt_human_ig_d.fasta \
 8    -out ~/share/igblast/database/imgt_human_ig_d
 9# J segment database
10edit_imgt_file.pl IMGT_Human_IGHJ.fasta > ~/share/igblast/fasta/imgt_human_ig_j.fasta
11makeblastdb -parse_seqids -dbtype nucl -in ~/share/igblast/fasta/imgt_human_ig_j.fasta \
12    -out ~/share/igblast/database/imgt_human_ig_j
13# Constant region database
14edit_imgt_file.pl IMGT_Human_IGHC.fasta > ~/share/igblast/fasta/imgt_human_ig_c.fasta
15makeblastdb -parse_seqids -dbtype nucl -in ~/share/igblast/fasta/imgt_human_ig_c.fasta \
16    -out ~/share/igblast/database/imgt_human_ig_c.fasta
```

Once these databases are built for each segment they can be referenced when
running IgBLAST.

## Running IgBLAST[](#running-igblast "Link to this heading")

Change-O provides a simple wrapper script to run IgBLAST with the required
options as the **igblast** subcommand of [AssignGenes.py](../tools/AssignGenes.html#assigngenes). This wrapper
can be run as follows using the database built using the Immcantation scripts:

```
AssignGenes.py igblast -s HD13M.fasta -b ~/share/igblast \
    --organism human --loci ig --format blast
```

The optional `--format blast` argument
defines the output format of IgBLAST. The default, `blast`, is the
blocked tabular output provided by specifying the `-outfmt '7 std qseq sseq btop'`
argument to IgBLAST. Specifying `--format airr`
will output a tab-delimited file compliant with the
[AIRR Rearrangement schema](https://airr-standards.readthedocs.io/en/stable/datarep/rearrangements.html)
defined by the [AIRR Community](https://www.antibodysociety.org/the-airr-community/).
AIRR format support requires IgBLAST v1.9.0 or higher.

The `-b ~/share/igblast` argument specifies the
path containing the `database`, `internal_data`, and `optional_file`
directories required by IgBLAST. This option sets the `IGDATA` environment variable
that controls where IgBLAST looks for internal database files. See the
[IgBLAST documentation](https://ncbi.github.io/igblast) for more details
regarding the `IGDATA` environment variable.

See also

The [AssignGenes.py](../tools/AssignGenes.html#assigngenes) IgBLAST wrapper provides limited functionality.
For more control, IgBLAST should be run directly. The only strict
requirement for compatibility with Changeo-O is that the output must
either be an AIRR tab-delimited file (`--outfmt 19`) or a blast-style
tabular output with the optional query sequence, subject sequence and BTOP fields
(`-outfmt '7 std qseq sseq btop'`). An example of how to run IgBLAST
directly is shown below:

```
 1# Run IgBLAST
 2export IGDATA=~/share/igblast
 3igblastn \
 4    -germline_db_V ~/share/igblast/database/imgt_human_ig_v\
 5    -germline_db_D ~/share/igblast/database/imgt_human_ig_d \
 6    -germline_db_J ~/share/igblast/database/imgt_human_ig_j \
 7    -c_region_db ~/share/igblast/database/imgt_human_ig_c \
 8    -auxiliary_data ~/share/igblast/optional_file/human_gl.aux \
 9    -domain_system imgt -ig_seqtype Ig -organism human \
10    -outfmt '7 std qseq sseq btop' \
11    -query HD13M.fasta \
12    -out HD13M.fmt7
```

## Processing the output of IgBLAST[](#processing-the-output-of-igblast "Link to this heading")

Standalone IgBLAST blast-style tabular output is parsed by the **igblast**
subcommand of [MakeDb.py](../tools/MakeDb.html#makedb) to generate the standardized tab-delimited database file
on which all subsequent Change-O modules operate. In addition to the IgBLAST output
(`-i HD13M.fmt7`), both the FASTA files input to IgBLAST
(`-s HD13M.fasta`) and the IMGT-gapped reference sequences
(`-r IMGT_Human_IGHV.fasta IMGT_Human_IGHD.fasta IMGT_Human_IGHJ.fasta`)
must be provided to [MakeDb.py](../tools/MakeDb.html#makedb):

```
MakeDb.py igblast -i HD13M.fmt7 -s HD13M.fasta \
    -r IMGT_Human_IGHV.fasta IMGT_Human_IGHD.fasta IMGT_Human_IGHJ.fasta \
    --extended
```

The optional `--extended` argument adds extra
columns to the output database containing IMGT-gapped CDR/FWR regions and
alignment metrics.

Warning

The references sequences you provide to [MakeDb.py](../tools/MakeDb.html#makedb) must contain IMGT-gapped
V segment references, and these reference must be the same sequences used to
build the IgBLAST reference database. If your IgBLAST germlines are not IMGT-gapped
and/or they are not identical to those provided to [MakeDb.py](../tools/MakeDb.html#makedb), then sequences
which were assigned missing germlines will fail the parsing operation and the
junction (CDR3) sequences will not be correct.

[Previous](../modules/Receptor.html "changeo.Receptor")
[Next](imgt.html "Parsing IMGT output")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).