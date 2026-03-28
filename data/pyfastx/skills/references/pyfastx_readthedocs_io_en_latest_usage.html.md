[pyfastx](index.html)

Contents:

* [Installation](installation.html)
* FASTX
  + [Iterate over sequences in FASTA](#iterate-over-sequences-in-fasta)
  + [Iterate over reads in FASTQ](#iterate-over-reads-in-fastq)
* [FASTA](#fasta)
  + [Read FASTA file](#read-fasta-file)
  + [FASTA records iteration](#fasta-records-iteration)
  + [Get FASTA information](#get-fasta-information)
  + [Get longest and shortest sequence](#get-longest-and-shortest-sequence)
  + [Calculate N50 and L50](#calculate-n50-and-l50)
  + [Get sequence mean and median length](#get-sequence-mean-and-median-length)
  + [Get sequence counts](#get-sequence-counts)
  + [Get subsequences](#get-subsequences)
  + [Get flank sequences](#get-flank-sequences)
  + [Key function](#key-function)
* [Sequence](#sequence)
  + [Get a sequence from FASTA](#get-a-sequence-from-fasta)
  + [Get sequence information](#get-sequence-information)
  + [Sequence slice](#sequence-slice)
  + [Reverse and complement sequence](#reverse-and-complement-sequence)
  + [Read sequence line by line](#read-sequence-line-by-line)
  + [Search for subsequence](#search-for-subsequence)
* [FASTQ](#fastq)
  + [Read FASTQ file](#read-fastq-file)
  + [FASTQ records iteration](#fastq-records-iteration)
  + [Get FASTQ information](#get-fastq-information)
* [Read](#read)
  + [Get read from FASTQ](#get-read-from-fastq)
  + [Get read information](#get-read-information)
* [FastaKeys](#fastakeys)
  + [Get fasta keys](#get-fasta-keys)
  + [Sort keys](#sort-keys)
  + [Filter keys](#filter-keys)
  + [Clear filter and sort order](#clear-filter-and-sort-order)
* [FastqKeys](#fastqkeys)
  + [Get fastq keys](#get-fastq-keys)
* [Command line interface](commandline.html)
* [Multiple processes](advance.html)
* [Drawbacks](drawbacks.html)
* [Changelog](changelog.html)
* [API Reference](api_reference.html)
* [Acknowledgements](acknowledgements.html)

[pyfastx](index.html)

* FASTX
* [View page source](_sources/usage.rst.txt)

---

# FASTX[](#fastx "Link to this heading")

New in `pyfastx` 0.8.0.

## Iterate over sequences in FASTA[](#iterate-over-sequences-in-fasta "Link to this heading")

When iterating over sequences on FASTX object, a tuple `(name, seq)` will be returned.

```
>>> fa = pyfastx.Fastx('tests/data/test.fa')
>>> for name,seq in fa:
>>>     print(name)
>>>     print(seq)

>>> #always output uppercase sequence
>>> for item in pyfastx.Fastx('tests/data/test.fa', uppercase=True):
>>>     print(item)

>>> #Manually specify sequence format
>>> for item in pyfastx.Fastx('tests/data/test.fa', format="fasta"):
>>>     print(item)
```

If you want the sequence comment, you can set comment to True, New in `pyfastx` 0.9.0.

```
>>> fa = pyfastx.Fastx('tests/data/test.fa.gz', comment=True)
>>> for name,seq,comment in fa:
>>>     print(name)
>>>     print(seq)
>>>     print(comment)
```

Note

The comment is the content of header line after the first white space or tab character.

## Iterate over reads in FASTQ[](#iterate-over-reads-in-fastq "Link to this heading")

When iterating over reads on FASTX object, a tuple `(name, seq, qual)` will be returned.

```
>>> fq = pyfastx.Fastx('tests/data/test.fq')
>>> for name,seq,qual in fq:
>>>     print(name)
>>>     print(seq)
>>>     print(qual)
```

If you want the read comment, you can set comment to True, New in `pyfastx` 0.9.0.

```
>>> fq = pyfastx.Fastx('tests/data/test.fq.gz', comment=True)
>>> for name,seq,qual,comment in fq:
>>>     print(name)
>>>     print(seq)
>>>     print(qual)
>>>     print(comment)
```

Note

The comment is the content of header line after the first white space or tab character.

# FASTA[](#fasta "Link to this heading")

## Read FASTA file[](#read-fasta-file "Link to this heading")

Read plain or gzipped FASTA file and build index, support for random access to FASTA.

```
>>> import pyfastx
>>> fa = pyfastx.Fasta('test/data/test.fa.gz')
>>> fa
<Fasta> test/data/test.fa.gz contains 211 seqs
```

Note

Building index may take some time. The time required to build index depends on the size of FASTA file. If index built, you can randomly access to any sequences in FASTA file. The index file can be reused to save time when you read sequences from FASTA file next time.

## FASTA records iteration[](#fasta-records-iteration "Link to this heading")

The fastest way to iterate plain or gzipped FASTA file without building index, the iteration will return a tuple contains name and sequence.

```
>>> import pyfastx
>>> for name, seq in pyfastx.Fasta('test/data/test.fa.gz', build_index=False):
>>>     print(name, seq)
```

If you want to use full header line as sequence identifier without building index, you can do like this:

```
>>> import pyfastx
>>> for name, seq in pyfastx.Fasta('test/data/test.fa', build_index=False, full_name=True):
>>>     print(name, seq)
```

You can also iterate sequence object from FASTA object like this:

```
>>> import pyfastx
>>> for seq in pyfastx.Fasta('test/data/test.fa.gz'):
>>>     print(seq.name)
>>>     print(seq.seq)
>>>     print(seq.description)
```

Iteration with `build_index=True` (default) return sequence object which allows you to access attributes of sequence. New in pyfastx 0.6.3.

## Get FASTA information[](#get-fasta-information "Link to this heading")

```
>>> # get sequence counts in FASTA
>>> len(fa)
211

>>> # get total sequence length of FASTA
>>> fa.size
86262

>>> # get GC content of DNA sequences in FASTA
>>> fa.gc_content
43.529014587402344

>>> # get GC skew of DNA sequences in FASTA
>>> # New in pyfastx 0.3.8
>>> fa.gc_skews
0.004287730902433395

>>> # get composition of nucleotides in FASTA
>>> fa.composition
{'A': 24534, 'C': 18694, 'G': 18855, 'T': 24179}

>>> # get fasta type (DNA, RNA, or protein)
>>> # New in pyfastx 0.5.4
>>> fa.type
'DNA'

>>> # check fasta file is gzip compressed
>>> # New in pyfastx 0.5.4
>>> fa.is_gzip
True
```

## Get longest and shortest sequence[](#get-longest-and-shortest-sequence "Link to this heading")

New in `pyfastx` 0.3.0

```
>>> # get longest sequence
>>> s = fa.longest
>>> s
<Sequence> JZ822609.1 with length of 821

>>> s.name
'JZ822609.1'

>>> len(s)
821

>>> # get shortest sequence
>>> s = fa.shortest
>>> s
<Sequence> JZ822617.1 with length of 118

>>> s.name
'JZ822617.1'

>>> len(s)
118
```

## Calculate N50 and L50[](#calculate-n50-and-l50 "Link to this heading")

New in `pyfastx` 0.3.0

Calculate assembly N50 and L50, return (N50, L50), learn more about [N50,L50](https://www.molecularecologist.com/2017/03/whats-n50/)

```
>>> # get FASTA N50 and L50
>>> fa.nl(50)
(516, 66)

>>> # get FASTA N90 and L90
>>> fa.nl(90)
(231, 161)

>>> # get FASTA N75 and L75
>>> fa.nl(75)
(365, 117)
```

## Get sequence mean and median length[](#get-sequence-mean-and-median-length "Link to this heading")

New in `pyfastx` 0.3.0

```
>>> # get sequence average length
>>> fa.mean
408

>>> # get sequence median length
>>> fa.median
430
```

## Get sequence counts[](#get-sequence-counts "Link to this heading")

New in `pyfastx` 0.3.0

Get counts of sequences whose length >= specified length

```
>>> # get counts of sequences with length >= 200 bp
>>> fa.count(200)
173

>>> # get counts of sequences with length >= 500 bp
>>> fa.count(500)
70
```

## Get subsequences[](#get-subsequences "Link to this heading")

Subsequences can be retrieved from FASTA file by using a list of [start, end] coordinates

```
>>> # get subsequence with start and end position
>>> interval = (1, 10)
>>> fa.fetch('JZ822577.1', interval)
'CTCTAGAGAT'

>>> # get subsequences with a list of start and end position
>>> intervals = [(1, 10), (50, 60)]
>>> fa.fetch('JZ822577.1', intervals)
'CTCTAGAGATTTTAGTTTGAC'

>>> # get subsequences with reverse strand
>>> fa.fetch('JZ822577.1', (1, 10), strand='-')
'ATCTCTAGAG'
```

## Get flank sequences[](#get-flank-sequences "Link to this heading")

New in `pyfastx` 0.7.0

Get flank sequences for the given subsequence, return a tuple with left and right flank sequence

```
>>> # get flank sequences with length of 20 for subsequence JZ822577:50-60
>>> fa.flank('JZ822577.1', 50, 60, 20)
('TCACTCAGGCTCTTTGTCAT', 'TAGGATATCGAGTATTCAAG')

>>> # get flank sequences for a single base or SNP at position 100
>>> fa.flank('JZ822577.1', 100, 100, 20)
('GCTCATCGCTTTTGGTAATC', 'TTGCGGTGCATGCCTTTGCA')

>>> # get flank sequences by buffer cache
>>> fa.flank('JZ822577.1', 70, 90, flank_length=20, use_cache=True)
('TTTAGTTTGACTAGGATATC', 'TTGGTAATCTTTGCGGTGCA')
```

Note

The start and end position of subsequence were 1-based. When extracting flank for large numbers of subsequences from the same sequence, `use_cache=True` was recommended to improve speed.

## Key function[](#key-function "Link to this heading")

New in `pyfastx` 0.5.1

Sometimes your fasta will have a long header which contains multiple identifiers and description, for example:

`>JZ822577.1 contig1 cDNA library of flower petals in tree peony by suppression subtractive hybridization Paeonia suffruticosa cDNA, mRNA sequence`

In this case, either “JZ822577.1” or “contig1” could be used as the identifier.
You can specify the key function to select one as identifier.

```
>>> #default use JZ822577.1 as identifier
>>> #specify key_func to select contig1 as identifer
>>> fa = pyfastx.Fasta('tests/data/test.fa.gz', key_func=lambda x: x.split()[1])
>>> fa
<Fasta> tests/data/test.fa.gz contains 211 seqs
```

Note

If the index file already existed, you should delete the previous index file, and then use key\_func to create a new index file

# Sequence[](#sequence "Link to this heading")

## Get a sequence from FASTA[](#get-a-sequence-from-fasta "Link to this heading")

```
>>> # get sequence like dictionary
>>> s1 = fa['JZ822577.1']
>>> s1
<Sequence> JZ822577.1 with length of 333

>>> # get sequence like list
>>> s2 = fa[2]
>>> s2
<Sequence> JZ822579.1 with length of 176

>>> # get last sequence
>>> s3 = fa[-1]
>>> s3
<Sequence> JZ840318.1 with length of 134

>>> # check name weather in FASTA file
>>> 'JZ822577.1' in fa
True
```

## Get sequence information[](#get-sequence-information "Link to this heading")

```
>>> s = fa[-1]
>>> s
<Sequence> JZ840318.1 with length of 134

>>> # get sequence order number in FASTA file
>>> # New in pyfastx 0.3.7
>>> s.id
211

>>> # get sequence name
>>> s.name
'JZ840318.1'

>>> # get sequence description, New in pyfastx 0.3.1
>>> s.description
'R283 cDNA library of flower petals in tree peony by suppression subtractive hybridization Paeonia suffruticosa cDNA, mRNA sequence'

>>> # get sequence string
>>> s.seq
'ACTGGAGGTTCTTCTTCCTGTGGAAAGTAACTTGTTTTGCCTTCACCTGCCTGTTCTTCACATCAACCTTGTTCCCACACAAAACAATGGGAATGTTCTCACACACCCTGCAGAGATCACGATGCCATGTTGGT'

>>> # get sequence raw string, New in pyfastx 0.6.3
>>> print(s.raw)
>JZ840318.1 R283 cDNA library of flower petals in tree peony by suppression subtractive hybridization Paeonia suffruticosa cDNA, mRNA sequence
ACTGGAGGTTCTTCTTCCTGTGGAAAGTAACTTGTTTTGCCTTCACCTGCCTGTTCTTCACATCAACCTT
GTTCCCACACAAAACAATGGGAATGTTCTCACACACCCTGCAGAGATCACGATGCCATGTTGGT

>>> # get sequence length
>>> len(s)
134

>>> # get GC content if dna sequence
>>> s.gc_content
46.26865768432617

>>> # get nucleotide composition if dna sequence
>>> s.composition
{'A': 31, 'C': 37, 'G': 25, 'T': 41, 'N': 0}
```

## Sequence slice[](#sequence-slice "Link to this heading")

Sequence object can be sliced like a python string

```
>>> # get a sub seq from sequence
>>> s = fa[-1]
>>> ss = s[10:30]
>>> ss
<Sequence> JZ840318.1 from 11 to 30

>>> ss.name
'JZ840318.1:11-30'

>>> ss.seq
'CTTCTTCCTGTGGAAAGTAA'

>>> ss = s[-10:]
>>> ss
<Sequence> JZ840318.1 from 125 to 134

>>> ss.name
'JZ840318.1:125-134'

>>> ss.seq
'CCATGTTGGT'
```

Note

Slicing start and end coordinates are 0-based. Currently, pyfastx does not support an optional third `step` or `stride` argument. For example `ss[::-1]`

## Reverse and complement sequence[](#reverse-and-complement-sequence "Link to this heading")

```
>>> # get sliced sequence
>>> fa[0][10:20].seq
'GTCAATTTCC'

>>> # get reverse of sliced sequence
>>> fa[0][10:20].reverse
'CCTTTAACTG'

>>> # get complement of sliced sequence
>>> fa[0][10:20].complement
'CAGTTAAAGG'

>>> # get reversed complement sequence, corresponding to sequence in antisense strand
>>> fa[0][10:20].antisense
'GGAAATTGAC'
```

## Read sequence line by line[](#read-sequence-line-by-line "Link to this heading")

New in `pyfastx` 0.3.0

The sequence object can be iterated line by line as they appear in FASTA file.

```
>>> for line in fa[0]:
...     print(line)
...
CTCTAGAGATTACTTCTTCACATTCCAGATCACTCAGGCTCTTTGTCATTTTAGTTTGACTAGGATATCG
AGTATTCAAGCTCATCGCTTTTGGTAATCTTTGCGGTGCATGCCTTTGCATGCTGTATTGCTGCTTCATC
ATCCCCTTTGACTTGTGTGGCGGTGGCAAGACATCCGAAGAGTTAAGCGATGCTTGTCTAGTCAATTTCC
CCATGTACAGAATCATTGTTGTCAATTGGTTGTTTCCTTGATGGTGAAGGGGCTTCAATACATGAGTTCC
AAACTAACATTTCTTGACTAACACTTGAGGAAGAAGGACAAGGGTCCCCATGT
```

Note

Sliced sequence (e.g. fa[0][10:50]) cannot be read line by line

## Search for subsequence[](#search-for-subsequence "Link to this heading")

New in `pyfastx` 0.3.6

Search for subsequence from given sequence and get one-based start position of the first occurrence

```
>>> # search subsequence in sense strand
>>> fa[0].search('GCTTCAATACA')
262

>>> # check subsequence weather in sequence
>>> 'GCTTCAATACA' in fa[0]
True

>>> # search subsequence in antisense strand
>>> fa[0].search('CCTCAAGT', '-')
301
```

# FASTQ[](#fastq "Link to this heading")

## Read FASTQ file[](#read-fastq-file "Link to this heading")

Read plain or gzipped file and build index, support for random access to reads from FASTQ.

```
>>> import pyfastx
>>> fq = pyfastx.Fastq('tests/data/test.fq.gz')
>>> fq
<Fastq> tests/data/test.fq.gz contains 100 reads
```

## FASTQ records iteration[](#fastq-records-iteration "Link to this heading")

The fastest way to parse plain or gzipped FASTQ file without building index, the iteration will return a tuple contains read name, seq and quality.

```
>>> import pyfastx
>>> for name,seq,qual in pyfastx.Fastq('tests/data/test.fq.gz', build_index=False):
>>>     print(name)
>>>     print(seq)
>>>     print(qual)
```

If you want to use full header line as read identifier without building index, you can do like this:

New in `pyfastx` 0.8.0

```
>>> import pyfastx
>>> for name,seq,qual in pyfastx.Fastq('test/data/test.fq', build_index=False, full_name=True):
>>>     print(name, seq, qual)
```

You can also iterate read object from FASTQ object like this:

```
>>> import pyfastx
>>> for read in pyfastx.Fastq('test/data/test.fq.gz'):
>>>     print(read.name)
>>>     print(read.seq)
>>>     print(read.qual)
>>>     print(read.quali)
```

Iteration with `build_index=True` (default) return read object which allows you to access attribution of read. New in pyfastx 0.6.3.

## Get FASTQ information[](#get-fastq-information "Link to this heading")

```
>>> # get read counts in FASTQ
>>> len(fq)
800

>>> # get total bases
>>> fq.size
120000

>>> # get GC content