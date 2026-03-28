[Pynteny](../..)

* [Home](../..)

Subcommands

* [Search](../search/)
* [Build](./)
* [Parse](../parse/)
* [Download](../download/)

Examples

* [Example CLI](../../examples/example_cli/)
* [Example API](../../examples/example_api/)
* [Sus operon](../../examples/example_sus/)

References

* [API references](../../references/api/)

[Pynteny](../..)

* »
* Subcommands »
* Build
* [Edit on GitHub](https://github.com/Robaina/Pynteny/edit/master/docs/subcommands/build.md)

---

Translate assembly sequence data and assign positional metadata to labels

## Usage

```
usage: pynteny build [-h] [args]
```

## Arguments

| short | long | default | help |
| --- | --- | --- | --- |
| `-h` | `--help` |  | show this help message and exit |
| `-i` | `--data` | `None` | path to assembly input nucleotide data or annotated GenBank file. It can be a single file or a directory of files (either of FASTA or GeneBank format). If a directory, file name is prepended to the label of each translated peptide originally coming from that file (i.e., to track the genome of origin) |
| `-x` | `--prepend-filename` |  | whether to prepend file name to peptide sequences when a directory with multiple fasta or genbank files is used as input. |
| `-o` | `--outfile` | `None` | path to output (labelled peptide database) file. Defaults to file in directory of input data. |
| `-p` | `--processes` | `None` | set maximum number of processes. Defaults to all but one. |
| `-t` | `--tempdir` | `None` | path to directory to store temporary files. Defaults to system temp directory. |
| `-l` | `--log` | `None` | path to log file. Log not written by default. |

## Description

Translate nucleotide assembly file and assign contig and gene location info
to each identified ORF (using [prodigal](https://github.com/hyattpd/Prodigal)). Label predicted ORFs according to
positional info and export a fasta file containing predicted and translated ORFs.
Alternatively, extract peptide sequences from GenBank file containing ORF annotations
and write labeled peptide sequences to a fasta file.

[Previous](../search/ "Search")
[Next](../parse/ "Parse")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[GitHub](https://github.com/Robaina/Pynteny)
[« Previous](../search/)
[Next »](../parse/)