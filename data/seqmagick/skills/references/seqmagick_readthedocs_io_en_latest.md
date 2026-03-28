### Navigation

* [index](genindex.html "General Index")
* [next](changelog.html "Changes for seqmagick") |
* seqmagick documentation »

![Logo](_static/seqmagick_logo_small.png)

### Table of Contents

* seqmagick
  + [Motivation](#motivation)
  + [Installation](#installation)
  + [Use](#use)
  + [List of Subcommands](#list-of-subcommands)
  + [Supported File Extensions](#supported-file-extensions)
    - [Default Format](#default-format)
    - [Compressed file support](#compressed-file-support)
  + [Acknowledgements](#acknowledgements)
  + [Contributing](#contributing)

#### Next topic

[Changes for seqmagick](changelog.html "next chapter")

### This Page

* [Show Source](_sources/index.rst.txt)

### Quick search

[![Fork me on GitHub](_static/fork.png)](http://github.com/fhcrc/seqmagick)

# [seqmagick](#id1)[¶](#seqmagick "Permalink to this headline")

Contents

* [seqmagick](#seqmagick)
  + [Motivation](#motivation)
  + [Installation](#installation)
  + [Use](#use)
  + [List of Subcommands](#list-of-subcommands)
  + [Supported File Extensions](#supported-file-extensions)
    - [Default Format](#default-format)
    - [Compressed file support](#compressed-file-support)
  + [Acknowledgements](#acknowledgements)
  + [Contributing](#contributing)

* [Changes for seqmagick](changelog.html)

## [Motivation](#id2)[¶](#motivation "Permalink to this headline")

We often have to convert between sequence formats and do little tasks on them,
and it’s not worth writing scripts for that. Seqmagick is a kickass little
utility built in the spirit of [imagemagick](http://www.imagemagick.org/script/command-line-tools.php) to expose the file format
conversion in Biopython in a convenient way. Instead of having a big mess of
scripts, there is one that takes arguments:

```
seqmagick convert a.fasta b.phy    # convert from fasta to phylip
seqmagick mogrify --ungap a.fasta  # remove all gaps from a.fasta, in place
seqmagick info *.fasta             # describe all FASTA files in the current directory
```

And more.

## [Installation](#id3)[¶](#installation "Permalink to this headline")

Install the latest release with:

```
pip install seqmagick
```

This should also install [BioPython](http://www.biopython.org/). NumPy (which parts of BioPython
depend on) is not required for `seqmagick` to function, but may be
installed as a dependency of `BioPython`.

To install the bleeding edge version:

```
pip install git+https://github.com/fhcrc/seqmagick.git@master#egg-info=seqmagick
```

Note that as of version 0.8.0, this package requires Python 3.5+. If
you want to use the most recent version compatible with Python 2.7:

```
pip install seqmagick==0.6.2
```

## [Use](#id4)[¶](#use "Permalink to this headline")

Seqmagick can be used to query information about sequence files, convert
between types, and modify sequence files. All functions are accessed through
subcommands:

```
seqmagick <subcommand> [options] arguments
```

## [List of Subcommands](#id5)[¶](#list-of-subcommands "Permalink to this headline")

* [`convert` and `mogrify`](convert_mogrify.html)
  + [Examples](convert_mogrify.html#examples)
* [`backtrans-align`](backtrans_align.html)
* [`extract-ids`](extract_ids.html)
* [`info`](info.html)
  + [Example](info.html#example)
* [`quality-filter`](quality_filter.html)

## [Supported File Extensions](#id6)[¶](#supported-file-extensions "Permalink to this headline")

By default, `seqmagick` infers the file type from extension. Currently mapped
extensions are:

| Extension | Format |
| --- | --- |
| .afa | fasta |
| .aln | clustal |
| .fa | fasta |
| .faa | fasta |
| .fas | fasta |
| .fasta | fasta |
| .fastq | fastq |
| .ffn | fasta |
| .fna | fasta |
| .fq | fastq |
| .frn | fasta |
| .gb | genbank |
| .gbk | genbank |
| .needle | emboss |
| .nex | nexus |
| .phy | phylip |
| .phylip | phylip |
| .phyx | phylip-relaxed |
| .qual | qual |
| .sff | sff-trim |
| .sth | stockholm |
| .sto | stockholm |

Note

NEXUS-format output requires the `--alphabet` flag.

### [Default Format](#id7)[¶](#default-format "Permalink to this headline")

When reading from stdin or writing to stdout, `seqmagick` defaults to fasta
format. This behavior may be overridden with the `--input-format` and
`--output-format` flags.

If an extension is not listed, you can either rename the file to a supported
extension, or specify it manually via `--input-format` or `--output-format`.

### [Compressed file support](#id8)[¶](#compressed-file-support "Permalink to this headline")

most commands support gzip (files ending in `.gz`) and bzip (files ending in
`.bz2` or `.bz`) compressed inputs and outputs. File types for these files
are inferred using the extension of the file after stripping the file extension
indicating that the file is compressed, so `input.fasta.gz` would be inferred
to be in FASTA format.

## [Acknowledgements](#id9)[¶](#acknowledgements "Permalink to this headline")

seqmagick is written and maintained by the [Matsen Group](http://matsen.fhcrc.org/) at the Fred
Hutchinson Cancer Research Center.

## [Contributing](#id10)[¶](#contributing "Permalink to this headline")

We welcome contributions! Simply fork the repository [on GitHub](http://github.com/fhcrc/seqmagick/) and send a pull request.

### Navigation

* [index](genindex.html "General Index")
* [next](changelog.html "Changes for seqmagick") |
* seqmagick documentation »

© Copyright 2011-2023, The Matsen Group.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.6.