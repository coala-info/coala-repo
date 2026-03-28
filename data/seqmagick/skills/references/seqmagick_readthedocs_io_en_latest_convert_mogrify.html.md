### Navigation

* [index](genindex.html "General Index")
* [next](backtrans_align.html "backtrans-align") |
* [previous](changelog.html "Changes for seqmagick") |
* [seqmagick documentation](index.html) »

[![Logo](_static/seqmagick_logo_small.png)](index.html)

### [Table of Contents](index.html)

* `convert` and `mogrify`
  + [Examples](#examples)
    - [Basic Conversion](#basic-conversion)
    - [Sequence Modification](#sequence-modification)
      * [Command-line Arguments](#command-line-arguments)

#### Previous topic

[Changes for seqmagick](changelog.html "previous chapter")

#### Next topic

[`backtrans-align`](backtrans_align.html "next chapter")

### This Page

* [Show Source](_sources/convert_mogrify.rst.txt)

### Quick search

# `convert` and `mogrify`[¶](#convert-and-mogrify "Permalink to this headline")

Convert and mogrify achieve similar goals. `convert` performs some operation
on a file (from changing format to something more complicated) and writes to a
new file. `mogrify` modifies a file in place, and would not normally be used
to convert formats.

The two have similar signatures:

```
seqmagick convert [options] infile outfile
```

vs:

```
seqmagick mogrify [options] infile
```

Options are shared between convert and mogrify.

## Examples[¶](#examples "Permalink to this headline")

### Basic Conversion[¶](#basic-conversion "Permalink to this headline")

`convert` can be used to convert between any file types BioPython supports
(which is many). For a full list of supported types, see the [BioPython SeqIO
wiki page](http://www.biopython.org/wiki/SeqIO#File_Formats).

By default, file type is inferred from file extension, so:

```
seqmagick convert a.fasta a.sto
```

converts an existing file `a.fasta` from FASTA to Stockholm format. **Neat!**
But there’s more.

### Sequence Modification[¶](#sequence-modification "Permalink to this headline")

A wealth of options await you when you’re ready to do something slightly more
complicated with your sequences.

Let’s say I just want a few of my sequences:

```
$ seqmagick convert --head 5 examples/test.fasta examples/test.head.fasta
$ seqmagick info examples/test*.fasta
name                      alignment  min_len  max_len  avg_len  num_seqs
examples/test.fasta       FALSE      972      9719     1573.67  15
examples/test.head.fasta  FALSE      978      990      984.00   5
```

Or I want to remove any gaps, reverse complement, select the last 5 sequences,
and remove any duplicates from an alignment in place:

```
seqmagick mogrify --tail 5 --reverse-complement --ungap --deduplicate-sequences examples/test.fasta
```

You can even define your own functions in python and use them via
`--apply-function`.

Note

To maximize flexibility, most transformations passed as options to
`mogrify` and `convert` are processed *in order*, so:

```
seqmagick convert --min-length 50 --cut 1:5 a.fasta b.fasta
```

will work fine, but:

```
seqmagick convert --cut 1:5 --min-length 50 a.fasta b.fasta
```

will never return records, since the cutting transformation happens before
the minimum length predicate is applied.

#### Command-line Arguments[¶](#command-line-arguments "Permalink to this headline")

```
usage: seqmagick convert [-h] [--line-wrap N]
                         [--sort {length-asc,length-desc,name-asc,name-desc}]
                         [--apply-function /path/to/module.py:function_name[:parameter]]
                         [--cut start:end[,start2:end2]] [--relative-to ID]
                         [--drop start:end[,start2:end2]] [--dash-gap]
                         [--lower] [--mask start1:end1[,start2:end2]]
                         [--reverse] [--reverse-complement] [--squeeze]
                         [--squeeze-threshold PROP]
                         [--transcribe {dna2rna,rna2dna}]
                         [--translate {dna2protein,rna2protein,dna2proteinstop,rna2proteinstop}]
                         [--ungap] [--upper] [--deduplicate-sequences]
                         [--deduplicated-sequences-file FILE]
                         [--deduplicate-taxa] [--exclude-from-file FILE]
                         [--include-from-file FILE] [--head N]
                         [--max-length N] [--min-length N]
                         [--min-ungapped-length N] [--pattern-include REGEX]
                         [--pattern-exclude REGEX] [--prune-empty]
                         [--sample N] [--sample-seed N]
                         [--seq-pattern-include REGEX]
                         [--seq-pattern-exclude REGEX] [--tail N]
                         [--first-name] [--name-suffix SUFFIX]
                         [--name-prefix PREFIX]
                         [--pattern-replace search_pattern replace_pattern]
                         [--strip-range] [--input-format FORMAT]
                         [--output-format FORMAT]
                         [--alphabet {dna,dna-ambiguous,rna,rna-ambiguous,protein}]
                         source_file dest_file

Convert between sequence formats

positional arguments:
  source_file           Input sequence file
  dest_file             Output file

options:
  -h, --help            show this help message and exit
  --alphabet {dna,dna-ambiguous,rna,rna-ambiguous,protein}
                        Input alphabet. Required for writing NEXUS.

Sequence File Modification:
  --line-wrap N         Adjust line wrap for sequence strings. When N is 0,
                        all line breaks are removed. Only fasta files are
                        supported for the output format.
  --sort {length-asc,length-desc,name-asc,name-desc}
                        Perform sorting by length or name, ascending or
                        descending. ASCII sorting is performed for names

Sequence Modificaton:
  --apply-function /path/to/module.py:function_name[:parameter]
                        Specify a custom function to apply to the input
                        sequences, specified as
                        /path/to/file.py:function_name. Function should accept
                        an iterable of Bio.SeqRecord objects, and yield
                        SeqRecords. If the parameter is specified, it will be
                        passed as a string as the second argument to the
                        function. Specify more than one to chain.
  --cut start:end[,start2:end2]
                        Keep only the residues within the 1-indexed start and
                        end positions specified, : separated. Includes last
                        item. Start or end can be left unspecified to indicate
                        start/end of sequence. A negative start may be
                        provided to indicate an offset from the end of the
                        sequence. Note that to prevent negative numbers being
                        interpreted as flags, this should be written with an
                        equals sign between `--cut` and the argument, e.g.:
                        `--cut=-10:`
  --relative-to ID      Apply --cut relative to the indexes of non-gap
                        residues in sequence identified by ID
  --drop start:end[,start2:end2]
                        Remove the residues at the specified indices. Same
                        format as `--cut`.
  --dash-gap            Replace any of the characters "?.:~" with a "-" for
                        all sequences
  --lower               Translate the sequences to lower case
  --mask start1:end1[,start2:end2]
                        Replace residues in 1-indexed slice with gap-
                        characters. If --relative-to is also specified,
                        coordinates are relative to the sequence ID provided.
  --reverse             Reverse the order of sites in sequences
  --reverse-complement  Convert sequences into reverse complements
  --squeeze             Remove any gaps that are present in the same position
                        across all sequences in an alignment (equivalent to
                        --squeeze-threshold=1.0)
  --squeeze-threshold PROP
                        Trim columns from an alignment which have gaps in
                        least the specified proportion of sequences.
  --transcribe {dna2rna,rna2dna}
                        Transcription and back transcription for generic DNA
                        and RNA. Source sequences must be the correct alphabet
                        or this action will likely produce incorrect results.
  --translate {dna2protein,rna2protein,dna2proteinstop,rna2proteinstop}
                        Translate from generic DNA/RNA to proteins. Options
                        with "stop" suffix will NOT translate through stop
                        codons . Source sequences must be the correct alphabet
                        or this action will likely produce incorrect results.
  --ungap               Remove gaps in the sequence alignment
  --upper               Translate the sequences to upper case

Record Selection:
  --deduplicate-sequences
                        Remove any duplicate sequences by sequence content,
                        keep the first instance seen
  --deduplicated-sequences-file FILE
                        Write all of the deduplicated sequences to a file
  --deduplicate-taxa    Remove any duplicate sequences by ID, keep the first
                        instance seen
  --exclude-from-file FILE
                        Filter sequences, removing those sequence IDs in the
                        specified file
  --include-from-file FILE
                        Filter sequences, keeping only those sequence IDs in
                        the specified file
  --head N              Trim down to top N sequences. With the leading `-',
                        print all but the last N sequences.
  --max-length N        Discard any sequences beyond the specified maximum
                        length. This operation occurs *before* all length-
                        changing options such as cut and squeeze.
  --min-length N        Discard any sequences less than the specified minimum
                        length. This operation occurs *before* cut and
                        squeeze.
  --min-ungapped-length N
                        Discard any sequences less than the specified minimum
                        length, excluding gaps. This operation occurs *before*
                        cut and squeeze.
  --pattern-include REGEX
                        Filter the sequences by regular expression in ID or
                        description
  --pattern-exclude REGEX
                        Filter the sequences by regular expression in ID or
                        description
  --prune-empty         Prune sequences containing only gaps ('-')
  --sample N            Select a random sampling of sequences
  --sample-seed N       Set random seed for sampling of sequences
  --seq-pattern-include REGEX
                        Filter the sequences by regular expression in sequence
  --seq-pattern-exclude REGEX
                        Filter the sequences by regular expression in sequence
  --tail N              Trim down to bottom N sequences. Use +N to output
                        sequences starting with the Nth.

Sequence ID Modification:
  --first-name          Take only the first whitespace-delimited word as the
                        name of the sequence
  --name-suffix SUFFIX  Append a suffix to all IDs.
  --name-prefix PREFIX  Insert a prefix for all IDs.
  --pattern-replace search_pattern replace_pattern
                        Replace regex pattern "search_pattern" with
                        "replace_pattern" in sequence ID and description
  --strip-range         Strip ranges from sequences IDs, matching </x-y>

Format Options:
  --input-format FORMAT
                        Input file format (default: determine from extension)
  --output-format FORMAT
                        Output file format (default: determine from extension)

Filters using regular expressions are case-sensitive by default. Append "(?i)"
to a pattern to make it case-insensitive.
```

### Navigation

* [index](genindex.html "General Index")
* [next](backtrans_align.html "backtrans-align") |
* [previous](changelog.html "Changes for seqmagick") |
* [seqmagick documentation](index.html) »

© Copyright 2011-2023, The Matsen Group.
Created using [Sphinx](http://sphinx-doc.org/) 1.8.6.