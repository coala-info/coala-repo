[pyfastx](index.html)

Contents:

* [Installation](installation.html)
* [FASTX](usage.html)
* [FASTA](usage.html#fasta)
* [Sequence](usage.html#sequence)
* [FASTQ](usage.html#fastq)
* [Read](usage.html#read)
* [FastaKeys](usage.html#fastakeys)
* [FastqKeys](usage.html#fastqkeys)
* [Command line interface](commandline.html)
* [Multiple processes](advance.html)
* [Drawbacks](drawbacks.html)
* [Changelog](changelog.html)
* API Reference
  + [pyfastx.version](#pyfastx-version)
    - [`pyfastx.version()`](#pyfastx.version)
    - [`pyfastx.gzip_check()`](#pyfastx.gzip_check)
    - [`pyfastx.reverse_complement()`](#pyfastx.reverse_complement)
  + [pyfastx.Fasta](#pyfastx-fasta)
    - [`pyfastx.Fasta`](#pyfastx.Fasta)
      * [`pyfastx.Fasta.file_name`](#pyfastx.Fasta.file_name)
      * [`pyfastx.Fasta.size`](#pyfastx.Fasta.size)
      * [`pyfastx.Fasta.type`](#pyfastx.Fasta.type)
      * [`pyfastx.Fasta.is_gzip`](#pyfastx.Fasta.is_gzip)
      * [`pyfastx.Fasta.gc_content`](#pyfastx.Fasta.gc_content)
      * [`pyfastx.Fasta.gc_skew`](#pyfastx.Fasta.gc_skew)
      * [`pyfastx.Fasta.composition`](#pyfastx.Fasta.composition)
      * [`pyfastx.Fasta.longest`](#pyfastx.Fasta.longest)
      * [`pyfastx.Fasta.shortest`](#pyfastx.Fasta.shortest)
      * [`pyfastx.Fasta.mean`](#pyfastx.Fasta.mean)
      * [`pyfastx.Fasta.median`](#pyfastx.Fasta.median)
      * [`pyfastx.Fasta.fetch()`](#pyfastx.Fasta.fetch)
      * [`pyfastx.Fasta.flank()`](#pyfastx.Fasta.flank)
      * [`pyfastx.Fasta.build_index()`](#pyfastx.Fasta.build_index)
      * [`pyfastx.Fasta.keys()`](#pyfastx.Fasta.keys)
      * [`pyfastx.Fasta.count()`](#pyfastx.Fasta.count)
      * [`pyfastx.Fasta.nl()`](#pyfastx.Fasta.nl)
  + [pyfastx.Sequence](#pyfastx-sequence)
    - [`pyfastx.Sequence`](#pyfastx.Sequence)
      * [`pyfastx.Sequence.id`](#pyfastx.Sequence.id)
      * [`pyfastx.Sequence.name`](#pyfastx.Sequence.name)
      * [`pyfastx.Sequence.description`](#pyfastx.Sequence.description)
      * [`pyfastx.Sequence.start`](#pyfastx.Sequence.start)
      * [`pyfastx.Sequence.end`](#pyfastx.Sequence.end)
      * [`pyfastx.Sequence.gc_content`](#pyfastx.Sequence.gc_content)
      * [`pyfastx.Sequence.gc_skew`](#pyfastx.Sequence.gc_skew)
      * [`pyfastx.Sequence.composition`](#pyfastx.Sequence.composition)
      * [`pyfastx.Sequence.raw`](#pyfastx.Sequence.raw)
      * [`pyfastx.Sequence.seq`](#pyfastx.Sequence.seq)
      * [`pyfastx.Sequence.reverse`](#pyfastx.Sequence.reverse)
      * [`pyfastx.Sequence.complement`](#pyfastx.Sequence.complement)
      * [`pyfastx.Sequence.antisense`](#pyfastx.Sequence.antisense)
      * [`pyfastx.Sequence.search()`](#pyfastx.Sequence.search)
  + [pyfastx.Fastq](#pyfastx-fastq)
    - [`pyfastx.Fastq`](#pyfastx.Fastq)
      * [`pyfastx.Fastq.file_name`](#pyfastx.Fastq.file_name)
      * [`pyfastx.Fastq.size`](#pyfastx.Fastq.size)
      * [`pyfastx.Fastq.is_gzip`](#pyfastx.Fastq.is_gzip)
      * [`pyfastx.Fastq.gc_content`](#pyfastx.Fastq.gc_content)
      * [`pyfastx.Fastq.avglen`](#pyfastx.Fastq.avglen)
      * [`pyfastx.Fastq.maxlen`](#pyfastx.Fastq.maxlen)
      * [`pyfastx.Fastq.minlen`](#pyfastx.Fastq.minlen)
      * [`pyfastx.Fastq.maxqual`](#pyfastx.Fastq.maxqual)
      * [`pyfastx.Fastq.minqual`](#pyfastx.Fastq.minqual)
      * [`pyfastx.Fastq.composition`](#pyfastx.Fastq.composition)
      * [`pyfastx.Fastq.phred`](#pyfastx.Fastq.phred)
      * [`pyfastx.Fastq.encoding_type`](#pyfastx.Fastq.encoding_type)
      * [`pyfastx.Fastq.build_index()`](#pyfastx.Fastq.build_index)
      * [`pyfastx.Fastq.keys()`](#pyfastx.Fastq.keys)
  + [pyfastx.Read](#pyfastx-read)
    - [`pyfastx.Read`](#pyfastx.Read)
      * [`pyfastx.Read.id`](#pyfastx.Read.id)
      * [`pyfastx.Read.name`](#pyfastx.Read.name)
      * [`pyfastx.Read.description`](#pyfastx.Read.description)
      * [`pyfastx.Read.raw`](#pyfastx.Read.raw)
      * [`pyfastx.Read.seq`](#pyfastx.Read.seq)
      * [`pyfastx.Read.qual`](#pyfastx.Read.qual)
      * [`pyfastx.Read.quali`](#pyfastx.Read.quali)
  + [pyfastx.Fastx](#pyfastx-fastx)
    - [`pyfastx.Fastx`](#pyfastx.Fastx)
  + [pyfastx.FastaKeys](#pyfastx-fastakeys)
    - [`pyfastx.FastaKeys`](#pyfastx.FastaKeys)
      * [`pyfastx.FastaKeys.sort()`](#pyfastx.FastaKeys.sort)
      * [`pyfastx.FastaKeys.filter()`](#pyfastx.FastaKeys.filter)
      * [`pyfastx.FastaKeys.reset()`](#pyfastx.FastaKeys.reset)
  + [pyfastx.FastqKeys](#pyfastx-fastqkeys)
    - [`pyfastx.FastqKeys`](#pyfastx.FastqKeys)
* [Acknowledgements](acknowledgements.html)

[pyfastx](index.html)

* API Reference
* [View page source](_sources/api_reference.rst.txt)

---

# API Reference[](#api-reference "Link to this heading")

## pyfastx.version[](#pyfastx-version "Link to this heading")

pyfastx.version(*debug=False*)[](#pyfastx.version "Link to this definition")
:   Get current version of pyfastx

    Parameters:
    :   **debug** (*bool*) – if true, return versions of pyfastx, zlib, sqlite3 and zran.

    Returns:
    :   version of pyfastx

    Return type:
    :   str

pyfastx.gzip\_check(*file\_name*)[](#pyfastx.gzip_check "Link to this definition")
:   New in pyfastx 0.5.4

    Check file is gzip compressed or not

    Parameters:
    :   **file\_name** (*str*) – the path of input file

    Returns:
    :   Ture if file is gzip compressed else False

    Return type:
    :   bool

pyfastx.reverse\_complement(*seq*)[](#pyfastx.reverse_complement "Link to this definition")
:   New in pyfastx 2.0.0

    get reverse complement sequence of given DNA sequence

    Parameters:
    :   **seq** (*str*) – DNA sequence

    Returns:
    :   reverse complement sequence

    Return type:
    :   str

## pyfastx.Fasta[](#pyfastx-fasta "Link to this heading")

class pyfastx.Fasta(*file\_name*, *index\_file=None*, *uppercase=True*, *build\_index=True*, *full\_index=False*, *full\_name=False*, *memory\_index=False*, *key\_func=None*)[](#pyfastx.Fasta "Link to this definition")
:   Read and parse fasta files. Fasta can be used as dict or list, you can use index or sequence name to get a sequence object, e.g. `fasta[0]`, `fasta['seq1']`

    Parameters:
    :   * **file\_name** (*str*) – the file path of input FASTA file
        * **index\_file** (*str*) – the index file of FASTA file, default using index file with extension of .fxi in the same directory of FASTA file, New in 2.0.0
        * **uppercase** (*bool*) – always output uppercase sequence, default: `True`
        * **build\_index** (*bool*) – build index for random access to FASTA sequence, default: `True`. If build\_index is False, iteration will return a tuple (name, seq); If build\_index is True, iteration will return a sequence object.
        * **full\_index** (*bool*) – calculate character (e.g. A, T, G, C) composition when building index, this will improve the speed of GC content extracting. However, it will take more time to build index, default: `False`
        * **full\_name** (*bool*) – use the full header line instead of the part before first whitespace as the identifier of sequence, even in mode without building index. New in 0.6.14, default: `False`
        * **memory\_index** (*bool*) – if memory\_index is True, the fasta index will be kept in memory and do not generate a index file, default: `False`
        * **key\_func** (*function*) – new in 0.5.1, key function is generally a lambda expression to split header and obtain a shortened identifer, default: `None`

    Returns:
    :   Fasta object

    file\_name[](#pyfastx.Fasta.file_name "Link to this definition")
    :   FASTA file path

    size[](#pyfastx.Fasta.size "Link to this definition")
    :   total length of sequences in FASTA file

    type[](#pyfastx.Fasta.type "Link to this definition")
    :   New in `pyfastx` 0.5.4

        get fasta type, return DNA, RNA, protein, or unknown

    is\_gzip[](#pyfastx.Fasta.is_gzip "Link to this definition")
    :   New in pyfastx 0.5.0

        return True if fasta is gzip compressed else return False

    gc\_content[](#pyfastx.Fasta.gc_content "Link to this definition")
    :   GC content of whole sequences in FASTA file, return a float value

    gc\_skew[](#pyfastx.Fasta.gc_skew "Link to this definition")
    :   GC skew of whole sequences in FASTA file, learn more about [GC skew](https://en.wikipedia.org/wiki/GC_skew)

        New in `pyfastx` 0.3.8

    composition[](#pyfastx.Fasta.composition "Link to this definition")
    :   nucleotide composition in FASTA file, a dict contains counts of A, T, G, C and N (unkown nucleotide base)

    longest[](#pyfastx.Fasta.longest "Link to this definition")
    :   get longest sequence in FASTA file, return a Sequence object

        New in `pyfastx` 0.3.0

    shortest[](#pyfastx.Fasta.shortest "Link to this definition")
    :   get shortest sequence in FASTA file, return a Sequence object

        New in `pyfastx` 0.3.0

    mean[](#pyfastx.Fasta.mean "Link to this definition")
    :   get average length of sequences in FASTA file

        New in `pyfastx` 0.3.0

    median[](#pyfastx.Fasta.median "Link to this definition")
    :   get median length of sequences in FASTA file

        New in `pyfastx` 0.3.0

    fetch(*chrom*, *intervals*, *strand='+'*)[](#pyfastx.Fasta.fetch "Link to this definition")
    :   truncate subsequences from a given sequence by a start and end coordinate or a list of coordinates. This function will cache the full sequence into memory, and is suitable for extracting large numbers of subsequences from specified sequence.

        Parameters:
        :   * **chrom** (*str*) – chromosome name or sequence name
            * **intervals** (*list/tuple*) – list of [start, end] coordinates
            * **strand** (*str*) – sequence strand, `+` indicates sense strand, `-` indicates antisense strand, default: ‘+’

        Note

        intervals can be a list or tuple with start and end position e.g. (10, 20).
        intervals also can be a list or tuple with multiple coordinates e.g. [(10, 20), (50,70)]

        Returns:
        :   sliced subsequences

        Return type:
        :   str

    flank(*chrom*, *start*, *end*, *flank\_length=50*, *use\_cache=False*)[](#pyfastx.Fasta.flank "Link to this definition")
    :   Get the flank sequence of given subsequence with start and end. New in 0.7.0

        Parameters:
        :   * **chrom** (*str*) – chromosome name or sequence name
            * **start** (*int*) – 1-based start position of subsequence on chrom
            * **end** (*int*) – 1-based end position of subsequence on chrom
            * **flank\_length** (*int*) – length of flank sequence, default 50
            * **use\_cache** (*bool*) – cache the whole sequence

        Note

        If you want to extract flank sequence for large numbers of subsequences from the same sequence. Use `use_cache=True` will greatly improve the speed

        Returns:
        :   left flank and right flank sequence

        Return type:
        :   tuple

    build\_index()[](#pyfastx.Fasta.build_index "Link to this definition")
    :   build index for FASTA file

    keys()[](#pyfastx.Fasta.keys "Link to this definition")
    :   get all names of sequences

        Returns:
        :   an FastaKeys object

    count(*n*)[](#pyfastx.Fasta.count "Link to this definition")
    :   get counts of sequences whose length >= n bp

        New in `pyfastx` 0.3.0

        Parameters:
        :   **n** (*int*) – number of bases

        Returns:
        :   sequence counts

        Return type:
        :   int

    nl(*quantile*)[](#pyfastx.Fasta.nl "Link to this definition")
    :   calculate assembly N50 and L50, learn more about [N50,L50](https://www.molecularecologist.com/2017/03/whats-n50/)

        New in `pyfastx` 0.3.0

        Parameters:
        :   **quantile** (*int*) – a number between 0 and 100, default 50

        Returns:
        :   (N50, L50)

        Return type:
        :   tuple

## pyfastx.Sequence[](#pyfastx-sequence "Link to this heading")

class pyfastx.Sequence[](#pyfastx.Sequence "Link to this definition")
:   Readonly sequence object generated by fasta object, Sequence can be treated as a list and support slicing e.g. `seq[10:20]`

    id[](#pyfastx.Sequence.id "Link to this definition")
    :   sequence id or order number in FASTA file

    name[](#pyfastx.Sequence.name "Link to this definition")
    :   sequence name

    description[](#pyfastx.Sequence.description "Link to this definition")
    :   Get sequence description after name in sequence header

        New in `pyfastx` 0.3.1

    start[](#pyfastx.Sequence.start "Link to this definition")
    :   start position of sequence

    end[](#pyfastx.Sequence.end "Link to this definition")
    :   end position of sequence

    gc\_content[](#pyfastx.Sequence.gc_content "Link to this definition")
    :   GC content of current sequence, return a float value

    gc\_skew[](#pyfastx.Sequence.gc_skew "Link to this definition")
    :   GC skew of current sequence, learn more about [GC skew](https://en.wikipedia.org/wiki/GC_skew)

    composition[](#pyfastx.Sequence.composition "Link to this definition")
    :   nucleotide composition of sequence, a dict contains counts of A, T, G, C and N (unkown nucleotide base)

    raw[](#pyfastx.Sequence.raw "Link to this definition")
    :   get the raw string (with header line and sequence lines) of sequence as it appeared in file

        New in `pyfastx` 0.6.3

    seq[](#pyfastx.Sequence.seq "Link to this definition")
    :   get the string of sequence in sense strand

    reverse[](#pyfastx.Sequence.reverse "Link to this definition")
    :   get the string of reversed sequence

    complement[](#pyfastx.Sequence.complement "Link to this definition")
    :   get the string of complement sequence

    antisense[](#pyfastx.Sequence.antisense "Link to this definition")
    :   get the string of sequence in antisense strand, corresponding to reversed and complement sequence

    search(*subseq*, *strand='+'*)[](#pyfastx.Sequence.search "Link to this definition")
    :   Search for subsequence from given sequence and get the start position of the first occurrence

        New in `pyfastx` 0.3.6

        Parameters:
        :   * **subseq** (*str*) – a subsequence for search
            * **strand** (*str*) – sequence strand + or -, default +

        Returns:
        :   if found subsequence return one-based start position, if not return None

        Return type:
        :   int or None

## pyfastx.Fastq[](#pyfastx-fastq "Link to this heading")

New in `pyfastx` 0.4.0

class pyfastx.Fastq(*file\_name*, *index\_file=None*, *phred=0*, *build\_index=True*, *full\_index=False*)[](#pyfastx.Fastq "Link to this definition")
:   Read and parse fastq file

    Parameters:
    :   * **file\_name** (*str*) – input FASTQ file path
        * **index\_file** (*str*) – the index file of FASTQ file, default using the index file with extension of .fxi in the same directory of FASTQ file. New in 2.0.0
        