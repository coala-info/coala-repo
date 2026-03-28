[pytrf](index.html)

Contents:

* [Installation](installation.html)
* [Usage](usage.html)
* [Changelog](changelog.html)
* API Reference
  + [pytrf.version](#pytrf-version)
    - [`pytrf.version()`](#pytrf.version)
  + [pytrf.STRFinder](#pytrf-strfinder)
    - [`pytrf.STRFinder`](#pytrf.STRFinder)
      * [`pytrf.STRFinder.as_list()`](#pytrf.STRFinder.as_list)
  + [pytrf.GTRFinder](#pytrf-gtrfinder)
    - [`pytrf.GTRFinder`](#pytrf.GTRFinder)
      * [`pytrf.GTRFinder.as_list()`](#pytrf.GTRFinder.as_list)
  + [pytrf.ATRFinder](#pytrf-atrfinder)
    - [`pytrf.ATRFinder`](#pytrf.ATRFinder)
      * [`pytrf.ATRFinder.as_list()`](#pytrf.ATRFinder.as_list)
  + [pytrf.ETR](#pytrf-etr)
    - [`pytrf.ETR`](#pytrf.ETR)
      * [`pytrf.ETR.chrom`](#pytrf.ETR.chrom)
      * [`pytrf.ETR.start`](#pytrf.ETR.start)
      * [`pytrf.ETR.end`](#pytrf.ETR.end)
      * [`pytrf.ETR.motif`](#pytrf.ETR.motif)
      * [`pytrf.ETR.type`](#pytrf.ETR.type)
      * [`pytrf.ETR.repeat`](#pytrf.ETR.repeat)
      * [`pytrf.ETR.length`](#pytrf.ETR.length)
      * [`pytrf.ETR.seq`](#pytrf.ETR.seq)
      * [`pytrf.ETR.as_list()`](#pytrf.ETR.as_list)
      * [`pytrf.ETR.as_dict()`](#pytrf.ETR.as_dict)
      * [`pytrf.ETR.as_gff()`](#pytrf.ETR.as_gff)
      * [`pytrf.ETR.as_string()`](#pytrf.ETR.as_string)
  + [pytrf.ATR](#pytrf-atr)
    - [`pytrf.ATR`](#pytrf.ATR)
      * [`pytrf.ATR.chrom`](#pytrf.ATR.chrom)
      * [`pytrf.ATR.start`](#pytrf.ATR.start)
      * [`pytrf.ATR.end`](#pytrf.ATR.end)
      * [`pytrf.ATR.seed_start`](#pytrf.ATR.seed_start)
      * [`pytrf.ATR.seed_end`](#pytrf.ATR.seed_end)
      * [`pytrf.ATR.seed_repeat`](#pytrf.ATR.seed_repeat)
      * [`pytrf.ATR.motif`](#pytrf.ATR.motif)
      * [`pytrf.ATR.type`](#pytrf.ATR.type)
      * [`pytrf.ATR.repeat`](#pytrf.ATR.repeat)
      * [`pytrf.ATR.length`](#pytrf.ATR.length)
      * [`pytrf.ATR.matches`](#pytrf.ATR.matches)
      * [`pytrf.ATR.substitutions`](#pytrf.ATR.substitutions)
      * [`pytrf.ATR.insertions`](#pytrf.ATR.insertions)
      * [`pytrf.ATR.deletions`](#pytrf.ATR.deletions)
      * [`pytrf.ATR.identity`](#pytrf.ATR.identity)
      * [`pytrf.ATR.seq`](#pytrf.ATR.seq)
      * [`pytrf.ATR.as_list()`](#pytrf.ATR.as_list)
      * [`pytrf.ATR.as_dict()`](#pytrf.ATR.as_dict)
      * [`pytrf.ATR.as_gff()`](#pytrf.ATR.as_gff)
      * [`pytrf.ATR.as_string()`](#pytrf.ATR.as_string)

[pytrf](index.html)

* API Reference
* [View page source](_sources/api_reference.rst.txt)

---

# API Reference[](#api-reference "Link to this heading")

## pytrf.version[](#pytrf-version "Link to this heading")

pytrf.version()[](#pytrf.version "Link to this definition")
:   Get current version of pytrf

    Returns:
    :   version

    Return type:
    :   str

## pytrf.STRFinder[](#pytrf-strfinder "Link to this heading")

*class* pytrf.STRFinder(*chrom*, *seq*, *mono=12*, *di=7*, *tri=5*, *tetra=4*, *penta=4*, *hexa=4*)[](#pytrf.STRFinder "Link to this definition")
:   Find all exact or perfect short tandem repeats (STRs), simple sequence repeats (SSRs) or microsatellites that meet the minimum repeats on the input sequence

    Parameters:
    :   * **chrom** (*str*) – the sequence name
        * **seq** (*str*) – the input DNA sequence
        * **mono** (*int*) – the minimum tandem repeats for mono-nucleotide repeats
        * **di** (*int*) – the minimum tandem repeats for di-nucleotide repeats
        * **tri** (*int*) – the minimum tandem repeats for tri-nucleotide repeats
        * **tetra** (*int*) – the minimum tandem repeats for tetra-nucleotide repeats
        * **penta** (*int*) – the minimum tandem repeats for penta-nucleotide repeats
        * **hexa** (*int*) – the minimum tandem repeats for hexa-nucleotide repeats

    Returns:
    :   STRFinder object

    as\_list()[](#pytrf.STRFinder.as_list "Link to this definition")
    :   Put all SSRs in a list and return, each SSR in list has 7 columns including [sequence or chromosome name, start position, end position, motif sequence, motif length, repeat number, repeat length]

        Returns:
        :   all SSRs found

        Return type:
        :   list

## pytrf.GTRFinder[](#pytrf-gtrfinder "Link to this heading")

*class* pytrf.GTRFinder(*chrom*, *seq*, *min\_motif=1*, *max\_motif=100*, *min\_repeat=3*, *min\_length=10*)[](#pytrf.GTRFinder "Link to this definition")
:   Find all exact or perfect generic tandem repeats (GTRs) that meet the minimum repeat and minimum length on the input sequence

    Parameters:
    :   * **chrom** (*str*) – the sequence name
        * **seq** (*str*) – the input DNA sequence
        * **min\_motif** (*int*) – minimum length of motif sequence
        * **max\_motif** (*int*) – maximum length of motif sequence
        * **min\_repeat** (*int*) – minimum number of tandem repeats
        * **min\_length** (*int*) – minimum length of tandem repeats

    Returns:
    :   GTRFinder object

    as\_list()[](#pytrf.GTRFinder.as_list "Link to this definition")
    :   Put all GTRs in a list and return, each GTR in list has 7 columns including [sequence or chromosome name, start position, end position, motif sequence, motif length, repeat number, repeat length]

        Returns:
        :   all GTRs found

        Return type:
        :   list

## pytrf.ATRFinder[](#pytrf-atrfinder "Link to this heading")

*class* pytrf.ATRFinder(*chrom*, *seq*, *min\_motif=1*, *max\_motif=6*, *min\_seedrep=3*, *min\_seedlen=10*, *max\_errors=3*, *min\_identity=70*, *max\_extend=2000*)[](#pytrf.ATRFinder "Link to this definition")
:   Find all approximate or imperfect tandem repeats (ATRs) from the input sequence

    Parameters:
    :   * **chrom** (*str*) – the sequence name
        * **seq** (*str*) – the input DNA sequence
        * **min\_motif** (*int*) – minimum length of motif
        * **max\_motif** (*int*) – maximum length of motif
        * **min\_seedrep** (*int*) – minimum number of repeat for seed
        * **min\_seedlen** (*int*) – minimum length of seed
        * **max\_errors** (*int*) – maximum number of allowed consecutive errors
        * **min\_identity** (*float*) – minimum identity of alignment (0~100)
        * **max\_extend** (*int*) – maximum length allowed to extend

    Returns:
    :   ATRFinder object

    as\_list()[](#pytrf.ATRFinder.as_list "Link to this definition")
    :   Put all ATRs in a list and return, each ATR in list has 16 columns including [sequence or chromosome name, start position, end position, motif sequence, motif length, repeat number, repeat length, seed start position, seed end position, seed repeat, seed length, extend matches, extend substitutions, extend insertions, extend deletions, extend identity]

## pytrf.ETR[](#pytrf-etr "Link to this heading")

*class* pytrf.ETR[](#pytrf.ETR "Link to this definition")
:   Readonly exact tandem repeat (ETR) object generated by iterating over STRFinder or GTRFinder object

    chrom[](#pytrf.ETR.chrom "Link to this definition")
    :   chromosome or sequence name where ETR located on

    start[](#pytrf.ETR.start "Link to this definition")
    :   ETR one-based start position on sequence

    end[](#pytrf.ETR.end "Link to this definition")
    :   ETR one-based end position on sequence

    motif[](#pytrf.ETR.motif "Link to this definition")
    :   motif sequence

    type[](#pytrf.ETR.type "Link to this definition")
    :   motif length

    repeat[](#pytrf.ETR.repeat "Link to this definition")
    :   number of repeats

    length[](#pytrf.ETR.length "Link to this definition")
    :   length of ETR

    seq[](#pytrf.ETR.seq "Link to this definition")
    :   get the sequence of ETR

    as\_list()[](#pytrf.ETR.as_list "Link to this definition")
    :   convert ETR object to a list, [sequence or chromosome name, start position, end position, motif sequence, motif length, repeat number, repeat length]

    as\_dict()[](#pytrf.ETR.as_dict "Link to this definition")
    :   convert ETR object to a dict

    as\_gff(*terminator=''*)[](#pytrf.ETR.as_gff "Link to this definition")
    :   convert ETR object to a gff formatted string

    as\_string(*separator='\t'*, *terminator=''*)[](#pytrf.ETR.as_string "Link to this definition")
    :   convert ETR object to a TSV or CSV string by using separator and terminator, columns: sequence or chromosome name, start position, end position, motif sequence, motif length, repeat number, repeat length

        Parameters:
        :   * **separator** (*str*) – a separator between columns
            * **terminator** (*str*) – a terminator added to the end of string

        Returns:
        :   a formatted string

        Return type:
        :   str

## pytrf.ATR[](#pytrf-atr "Link to this heading")

*class* pytrf.ATR[](#pytrf.ATR "Link to this definition")
:   Readonly imperfect or approximate tandem repeat (ATR) object generated by iterating over ATRFinder object

    chrom[](#pytrf.ATR.chrom "Link to this definition")
    :   chromosome or sequence name where ATR located on

    start[](#pytrf.ATR.start "Link to this definition")
    :   ATR one-based start position on sequence

    end[](#pytrf.ATR.end "Link to this definition")
    :   ATR one-based end position on sequence

    seed\_start[](#pytrf.ATR.seed_start "Link to this definition")
    :   start position of seed

    seed\_end[](#pytrf.ATR.seed_end "Link to this definition")
    :   end position of seed

    seed\_repeat[](#pytrf.ATR.seed_repeat "Link to this definition")
    :   repeat number of seed

    motif[](#pytrf.ATR.motif "Link to this definition")
    :   motif sequence

    type[](#pytrf.ATR.type "Link to this definition")
    :   motif length

    repeat[](#pytrf.ATR.repeat "Link to this definition")
    :   repeat number of perfect counterpart

    length[](#pytrf.ATR.length "Link to this definition")
    :   length of ITR

    matches[](#pytrf.ATR.matches "Link to this definition")
    :   number of matches for extend

    substitutions[](#pytrf.ATR.substitutions "Link to this definition")
    :   number of substitutions for extend

    insertions[](#pytrf.ATR.insertions "Link to this definition")
    :   number of insertions for extend

    deletions[](#pytrf.ATR.deletions "Link to this definition")
    :   number of deletions for extend

    identity[](#pytrf.ATR.identity "Link to this definition")
    :   extend identity

    seq[](#pytrf.ATR.seq "Link to this definition")
    :   get the sequence of ATR

    as\_list()[](#pytrf.ATR.as_list "Link to this definition")
    :   convert ATR object to a list, [sequence or chromosome name, start position, end position, motif sequence, motif length, repeat number, repeat length, seed start position, seed end position, seed repeat, seed length, extend matches, extend substitutions, extend insertions, extend deletions, extend identity]

    as\_dict()[](#pytrf.ATR.as_dict "Link to this definition")
    :   convert ATR object to a dict

    as\_gff(*terminator=''*)[](#pytrf.ATR.as_gff "Link to this definition")
    :   convert ATR object to a gff formatted string

    as\_string(*separator='\t'*, *terminator=''*)[](#pytrf.ATR.as_string "Link to this definition")
    :   convert ATR object to a TSV or CSV string by using separator and terminator, columns: sequence or chromosome name, start position, end position, motif sequence, motif length, repeat number, repeat length, seed start position, seed end position, seed repeat, seed length, extend matches, extend substitutions, extend insertions, extend deletions, extend identity

        Parameters:
        :   * **separator** (*str*) – a separator between columns
            * **terminator** (*str*) – a terminator added to the end of string

        Returns:
        :   a formatted string

        Return type:
        :   str

[Previous](changelog.html "Changelog")

---

© Copyright 2023, Lianming Du.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).