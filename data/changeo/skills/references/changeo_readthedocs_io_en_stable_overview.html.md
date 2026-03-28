[changeo
![Logo](_static/changeo.png)](index.html)

* [Immcantation Portal](http://immcantation.readthedocs.io)

Getting Started

* Overview
* [Download](install.html)
* [Installation](install.html#installation)
* [Contributing](contributing.html)
* [Data Standards](standard.html)
* [Release Notes](news.html)

Usage Documentation

* [Commandline Usage](usage.html)
* [API](api.html)

Examples

* [Using IgBLAST](examples/igblast.html)
* [Parsing IMGT output](examples/imgt.html)
* [Parsing 10X Genomics V(D)J data](examples/10x.html)
* [Filtering records](examples/filtering.html)
* [Clustering sequences into clonal groups](examples/cloning.html)
* [Reconstructing germline sequences](examples/germlines.html)
* [Generating MiAIRR compliant GenBank/TLS submissions](examples/genbank.html)

Methods

* [Clonal clustering methods](methods/clustering.html)
* [Reconstruction of germline sequences from alignment data](methods/germlines.html)

About

* [Contact](info.html)
* [Citation](info.html#citation)
* [License](info.html#license)

[changeo](index.html)

* Overview
* [View page source](_sources/overview.rst.txt)

---

# Overview[](#overview "Link to this heading")

Change-O performs analyses of lymphocyte receptor sequences following alignment
against the germline reference. It includes tools for standardizing the
output of alignment software, clonal assignment, germline reconstruction, and
basic database manipulation. Change-O was designed to be simple to use, but it
does require some familiarity with commandline applications.
To maximize flexibility, Change-O employs a simple tab-delimited database format
with [standardized column names](standard.html#standard), allowing easy use of Change-O
output with external environments and interoperability with the
[Alakazam](http://alakazam.readthedocs.io),
[SHazaM](http://shazam.readthedocs.io), and
[TIgGER](http://tigger.readthedocs.io) R packages.
A brief description of each tool is shown in the table below.

| Tool | Subcommand | Description |
| --- | --- | --- |
| [AlignRecords.py](tools/AlignRecords.html#alignrecords) |  | Multiple aligns sequences in a database |
|  | across | Aligns sequence columns within groups and across rows |
|  | block | Aligns sequence groups across both columns and rows |
|  | within | Aligns sequence fields within rows |
| [AssignGenes.py](tools/AssignGenes.html#assigngenes) | igblast | Runs IgBLAST on nucleotide sequences |
|  | igblast-aa | Runs IgBLAST on amino acid sequences |
| [BuildTrees.py](tools/BuildTrees.html#buildtrees) |  | Generates IgPhyML input files |
| [ConvertDb.py](tools/ConvertDb.html#convertdb) |  | Converts tab delimited database files |
|  | airr | Converts input to an AIRR TSV file |
|  | baseline | Creates a special BASELINe formatted fasta file from a database |
|  | changeo | Converts input into a Change-O TSV file |
|  | fasta | Creates a fasta file from database records |
|  | genbank | Creates fasta and feature table files for input to tbl2asn |
| [CreateGermlines.py](tools/CreateGermlines.html#creategermlines) |  | Reconstructs germline sequences from alignment data |
| [DefineClones.py](tools/DefineClones.html#defineclones) |  | Assigns clones by V gene, J gene and junction distance |
| [MakeDb.py](tools/MakeDb.html#makedb) |  | Creates standardized databases from germline alignment results |
|  | igblast | Parses IgBLAST nucleotide alignments |
|  | igblast-aa | Parses IgBLAST amino acid alignments |
|  | ihmm | Parses iHMMune-Align output |
|  | imgt | Parses IMGT/HighV-QUEST output |
| [ParseDb.py](tools/ParseDb.html#parsedb) |  | Parses annotations in tab delimited database files |
|  | add | Adds fields to the database |
|  | delete | Deletes specific records |
|  | drop | Deletes entire fields |
|  | index | Adds a numeric index field |
|  | merge | Merge files |
|  | rename | Renames fields |
|  | select | Selects specific records |
|  | sort | Sorts records by a field |
|  | split | Splits database files by field values |
|  | update | Updates field and value pairs |

[Previous](index.html "Change-O - Repertoire clonal assignment toolkit")
[Next](install.html "Download")

---

© Copyright Kleinstein Lab, Yale University, 2025.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).