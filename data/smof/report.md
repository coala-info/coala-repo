# smof CWL Generation Report

## smof_cut

### Tool Description
Cut fields from SMOF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Total Downloads**: 26.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/incertae-sedis/smof
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/smof", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/smof/ui.py", line 1914, in main
    args.func(args, gen, out=sys.stdout)
  File "/usr/local/lib/python3.12/site-packages/smof/ui.py", line 148, in write
    for output in self.generator(args, gen):
                  ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/smof/ui.py", line 1299, in generator
    fields = args.fields.split(",")
             ^^^^^^^^^^^^^^^^^
AttributeError: 'NoneType' object has no attribute 'split'
```


## smof_clean

### Tool Description
Remove all space within the sequences and write them in even columns (default width of 80 characters). Case and all characters (except whitespace) are preserved by default.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof clean <options>

Remove all space within the sequences and write them in even columns (default
width of 80 characters). Case and all characters (except whitespace) are
preserved by default.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -t n|p, --type n|p    sequence type
  -u, --toupper         convert to uppercase
  -l, --tolower         convert to lowercase
  -x, --toseq           removes all non-letter characters (gaps, stops, etc.)
  -s, --reduce-header   Remove all text from header that follows the first
                        word (delimited by the value of the --delimiter
                        argument, '[ |]' by default)
  --delimiter DELIMITER
                        The regex delimiter used by --reduce-header
  -r, --mask-irregular  converts irregular letters to unknown
  -m, --mask-lowercase  convert lower-case to unknown
  -w W, --col_width W   width of the sequence output (0 indicates no wrapping)
  -d, --standardize     Convert 'X' in DNA to 'N' and '[._]' to '-' (for gaps)
```


## smof_consensus

### Tool Description
Calculates the consensus sequence from a set of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/smof", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/smof/ui.py", line 1914, in main
    args.func(args, gen, out=sys.stdout)
  File "/usr/local/lib/python3.12/site-packages/smof/ui.py", line 1261, in write
    result = consensus(gen)
             ^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/smof/functions.py", line 197, in consensus
    (_, transpose) = _consensus(gen)
                     ^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/smof/functions.py", line 186, in _consensus
    imax = max([len(s.seq) for s in seqs])
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
ValueError: max() iterable argument is empty
```


## smof_filter

### Tool Description
Prints every entry by default. You may add one or more criteria to filter the
results (e.g. `smof filter -s 200 -l 100 -c 'GC > .5'` will print only
sequences between 100 and 200 resides in length and greater than 50% GC
content).

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof filter <options>

Prints every entry by default. You may add one or more criteria to filter the
results (e.g. `smof filter -s 200 -l 100 -c 'GC > .5'` will print only
sequences between 100 and 200 resides in length and greater than 50% GC
content).

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -s LEN, --shorter-than LEN
                        keep only if length is less than or equal to LEN
  -l LEN, --longer-than LEN
                        keep only if length is greater than or equal to LEN
  -c EXPR, --composition EXPR
                        keep only if composition meets the condition (e.g. 'GC
                        > .5')
```


## smof_grep

### Tool Description
Smof grep is based on GNU grep but operates on fasta entries. It allows you to extract entries where either the header or the sequence match the search term. For sequence searches, it can produce GFF formatted output, which specifies the location of each match.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof grep <options>

Smof grep is based on GNU grep but operates on fasta entries.
It allows you to extract entries where either the header or the
sequence match the search term. For sequence searches, it can
produce GFF formatted output, which specifies the location of
each match.

The --wrap option limits search space to expressions captured
by a Perl regular expression. This, coupled with the --file
option, allows thousands of sequences to be rapidly extracted
based on terms from a file.

Smof grep can also take a fasta file as a search term input
(--fastain) and return sequences containing exact matches to
the sequences in the search fasta file. See the documentation
for examples.

positional arguments:
  PATTERN               pattern to match
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -q, --match-sequence  match sequence rather than header
  -f FILE, --file FILE  obtain patterns from FILE, one per line
  -L, --files-without-match
                        print names files with no matches
  -l, --files-with-matches
                        print names input files with matches
  -w REG, --wrap REG    a regular expression to capture patterns
  -P, --perl-regexp     treat patterns as perl regular expressions
  -G, --ambiguous-nucl  parse extended nucleotide alphabet
  -I, --case-sensitive  DO NOT ignore case distinctions (ignore by default)
  -v, --invert-match    print non-matching entries
  -o, --only-matching   show only the part that matches
  -B N, --before-context N
                        Include N characters before match
  -A N, --after-context N
                        Include N characters after match
  -C N, --context N     Include N characters before and after match
  -c, --count           print number of entries with matches
  -m, --count-matches   print number of non-overlapping matches
  -x, --line-regexp     force PATTERN to match the whole text (regex allowed)
  -X, --exact           force PATTERN to literally equal the text (fast)
  -g, --gapped          match across gaps when searching aligned sequences
  -b, --both-strands    search both strands
  -r, --reverse-only    only search the reverse strand
  -y, --no-color        do not print in color
  -Y, --force-color     print in color even to non-tty (DANGEROUS)
  -S, --preserve-color  Preserve incoming color
  --color STR           Choose a highlight color
  --gff                 output matches in gff format
  --gff-type STR        name of searched feature
  --fastain FASTA       Search for exact sequence matches against FASTA
```


## smof_md5sum

### Tool Description
Concatenates all headers and sequences and calculates the md5sum for the resulting string.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof md5sum <options>

By default, `smof md5sum` concantenates all headers and sequences and
calculates the md5sum for the resulting string. This is identical to `tr -d
'\n>' < a.fa | md5sum`.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -i, --ignore-case     convert all to uppercase, before hashing
  -q, --each-sequence   calculate md5sum for each sequence (TAB delimited)
  -s, --all-sequences   calculate one md5sum for all concatenated sequences
  -d, --all-headers     calculate one md5sum for all concatenated headers
  -r, --replace-header  replace the header of each entry with the checksum of
                        the sequence
```


## smof_head

### Tool Description
`smof head` is modeled after GNU tail and follows the same basic conventions except it is entry-based rather than line-based. By default, `smof head` outputs ONE sequence (rather than the 10 line default for `head`)

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof head <options>

`smof head` is modeled after GNU tail and follows the same basic conventions
except it is entry-based rather than line-based. By default, `smof head`
outputs ONE sequence (rather than the 10 line default for `head`)

positional arguments:
  K                  -K print first K entries
  INPUT              input fasta sequence (default = stdin)

options:
  -h, --help         show this help message and exit
  -n K, --entries K  print first K entries; or use -n -K to print all but the
                     last K entries
  -f K, --first K    print first K letters of each sequence
  -l K, --last K     print last K letters of each sequence
```


## smof_permute

### Tool Description
Randomly order letters in each sequence. The --word-size option allows random ordering of words of the given size. The --start-offset and --end-offset options are useful if, for example, you want to rearrange the letters within a coding sequence but want to preserve the start and stop codons.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof permute <options>

Randomly order letters in each sequence. The --word-size option allows random
ordering of words of the given size. The --start-offset and --end-offset
options are useful if, for example, you want to rearrange the letters within a
coding sequence but want to preserve the start and stop codons.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -w INT, --word-size INT
                        size of each word (default=1)
  -s INT, --start-offset INT
                        number of letters to ignore at beginning (default=0)
  -e INT, --end-offset INT
                        number of letters to ignore at end (default=0)
  --seed SEED           set random seed (for reproducibility/debugging)
```


## smof_reverse

### Tool Description
Reverse the letters in each sequence. The complement is NOT taken unless the -c flag is set. The extended nucleotide alphabet is supported.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof reverse <options>

Reverse the letters in each sequence. The complement is NOT taken unless the
-c flag is set. The extended nucleotide alphabet is supported.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -c, --complement      take the reverse complement of the sequence
  -V, --no-validate     do not check whether the sequence is DNA before
                        reverse complement
  -S, --preserve-color  Preserve incoming color
  -Y, --force-color     print in color even to non-tty (DANGEROUS)
```


## smof_sample

### Tool Description
Randomly sample entries. `sample` reads the entire file into memory, so should not be used for extremely large files.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof sample <options>

Randomly sample entries. `sample` reads the entire file into memory, so should
not be used for extremely large files.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -n NUMBER, --number NUMBER
                        sample size (default=1)
  --seed SEED           set random seed (for reproducibility/debugging)
```


## smof_sniff

### Tool Description
Identifies the sequence type and aids in diagnostics.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof sniff <options>

Identifies the sequence type and aids in diagnostics.

positional arguments:
  INPUT       input fasta sequence (default = stdin)

options:
  -h, --help  show this help message and exit

The output can be divided into 6 sections

1. Overview and warnings

  smof sniff counts the number of unique sequences and the number
  of total sequences. It warns if there are any sequences with
  illegal characters or if there are any duplicate headers. Example:

  > 23 uniq sequences (24 total)
  > WARNING: headers are not unique (23/24)
  > WARNING: illegal characters found

  Illegal characters include any character that is neither
  standard, ambiguous, a gap [_-.], or a stop [*].

2. Sequence types

  For each entry, it predicts whether it is protein, DNA, RNA, or
  illegal. Example:

  > Sequence types:
  >   prot:                20         83.3333%
  >   dna:                 2          8.3333%
  >   illegal:             1          4.1667%
  >   rna:                 1          4.1667%

  The 2nd column is the count, 3rd percentage

3. Sequence cases

  Reports the case of the sequences, example:

  > Sequences cases:
  >   uppercase:           21         87.5000%
  >   lowercase:           2          8.3333%
  >   mixedcase:           1          4.1667%

4. Nucleotide features

  Reports a summary nucleotide features

  The nucleotide features entry is comprised of four flags
  which will all equal 1 for a proper nucleotide coding sequence
  (0 otherwise). A sequence will be counted as 1111 if it:

    1) starts with a start codon (ATG)
    2) ends with a stop codon (TAG, TAA, or TGA)
    3) has a length that is a multiple of three
    4) has no internal stop codon. If a sequence lacks a
       start codon, but otherwise looks like a coding sequence,
       it will have the value 0111.

  For example:

  > Nucleotide Features
  >   0000:                2          66.6667%
  >   1100:                1          33.3333%

5. Protein features

  1) terminal-stop - does the sequence end with '*'?
  2) initial-Met - does the sequence start with 'M'?
  3) internal-stop - does '*' appear within the sequence?
  4) selenocysteine - does the sequence include 'U'?

  Example:

  > Protein Features:
  >   terminal-stop:       20         100.0000%
  >   initial-Met:         19         95.0000%
  >   internal-stop:       0          0.0000%
  >   selenocysteine:      0          0.0000%

6. Universal features

  Example:

  > Universal Features:
  >   ambiguous:           1          4.1667%
  >   unknown:             0          0.0000%
  >   gapped:              0          0.0000%

Ambiguous characters are RYSWKMDBHV for nucleotides and BJZ
for proteins.

Unknown characters are X for proteins and N for nucleotides

Gaps are '-_.'
```


## smof_sort

### Tool Description
Sorts the entries in a fasta file. By default, it sorts by the header strings.
`sort` reads the entire file into memory, so should not be used for extremely
large files.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof sort <options>

Sorts the entries in a fasta file. By default, it sorts by the header strings.
`sort` reads the entire file into memory, so should not be used for extremely
large files.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -x REG, --regex REG   sort by single regex capture
  -r, --reverse         reverse sort
  -n, --numeric-sort    numeric sort
  -l, --length-sort     sort by sequence length
  -R, --random-sort     randomly sort sequences
  -k KEY, --key KEY     Key to sort on (column number or tag)
  -t FIELD_SEPARATOR, --field-separator FIELD_SEPARATOR
                        The field separator (default: '|')
  -p PAIR_SEPARATOR, --pair-separator PAIR_SEPARATOR
                        The separator between a tag and value (default: '=')
```


## smof_split

### Tool Description
Breaks a multiple sequence fasta file into several smaller files.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof split <options>

Breaks a multiple sequence fasta file into several smaller files.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -n NUMBER, --number NUMBER
                        Number of output files or sequences per file
  -q, --seqs            split by maximum sequences per file
  -p PREFIX, --prefix PREFIX
                        prefix for output files (default="xxx")
```


## smof_stat

### Tool Description
The default action is to count the lengths of all sequences and output summary statistics including: 1) the number of sequences, 2) the number of characters, 3) the five-number summary of sequence lengths (minimum, 25th quantile, median, 75th quantile, and maximum), 4) the mean and standard deviation of lengths, and 5) the N50 (if you don't know what that is, you don't need to know).

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof stat <options>

The default action is to count the lengths of all sequences and output summary
statistics including: 1) the number of sequences, 2) the number of characters,
3) the five-number summary of sequence lengths (minimum, 25th quantile,
median, 75th quantile, and maximum), 4) the mean and standard deviation of
lengths, and 5) the N50 (if you don't know what that is, you don't need to
know).

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -d DELIMITER, --delimiter DELIMITER
                        output delimiter
  -q, --byseq           write a line for each sequence
  -I, --case-sensitive  match case
  -m, --count-lower     count the number of lowercase characters
  -c, --counts          write counts of all characters
  -t, --type            guess sequence type
  -l, --length          write sequence length
  -p, --proportion      write proportion of each character
  -C, --aa-profile      display protein profile
  -g, --hist            write ascii histogram of sequence lengths
  -G, --log-hist        write ascii histogram of sequence log2 lengths
```


## smof_subseq

### Tool Description
Extract subsequences from FASTA files, optionally with reverse complement, GFF input, or coloring.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof subseq <options>

The current default action is unfortunately excruciating death. The simplest
usage is `smof subseq -b START STOP`, where START and STOP are two integers.
If START is greater than STOP, and if the sequence appears to be nucleic,
`subseq` will write the reverse complement. Subseq can also read start and
stop positions from a GFF file, where column 1 in the GFF is checked against
the sequence id (the first word in the fasta header). In addition to sequence
subsetting, `subseq` can color the matched regions.

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -b N N, --bounds N N  from and to values (indexed from 1)
  -f FILE, --gff FILE   get bounds from this gff3 file
  -k, --keep            With --gff, keep sequences with no matches
  -c STR, --color STR   color subsequence (do not extract)
  -a, --annotate        Append the subsequence interval to the defline
  -Y, --force-color     print in color even to non-tty (DANGEROUS)
```


## smof_tail

### Tool Description
`smof tail` is modeled after GNU tail and follows the same basic conventions except it is entry-based rather than line-based. `smof tail` will output ONE sequence (rather than the 10 line default for `tail`)

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof tail <options>

`smof tail` is modeled after GNU tail and follows the same basic conventions
except it is entry-based rather than line-based. `smof tail` will output ONE
sequence (rather than the 10 line default for `tail`)

positional arguments:
  K                  -K print last K entries
  INPUT              input fasta sequence (default = stdin)

options:
  -h, --help         show this help message and exit
  -n K, --entries K  print last K entries; or use -n +K to output starting
                     with the Kth
  -f K, --first K    print first K letters of each sequence
  -l K, --last K     print last K letters of each sequence
```


## smof_translate

### Tool Description
Translate DNA sequences to protein sequences using the standard genetic code. Ambiguous codons are translated as 'X'. Trailing characters are ignored. Gaps are removed. If --all-frames is true, the longest product is kept, with ties broken by position and then frame. Translation starts at the first nucleotide by default.

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof translate <options>

Only the standard gene code table is supported. Any codons with ambiguous
characters will be translated as X. Trailing characters will be ignored. All
gaps [_.-] will be removed. When -f is True, then the longest product will be
found. Ties are resolved by comparing position (earlier positions are
preferred) and then frame (first frame is preferred). By default, translation
starts at the first nucleotide.

positional arguments:
  INPUT             input fasta sequence (default = stdin)

options:
  -h, --help        show this help message and exit
  -s, --from-start  Require each product begin with a start codon
  -f, --all-frames  Translate in all frames, keep longest
  -c, --cds         Write the DNA coding sequence
```


## smof_uniq

### Tool Description
Emulates the GNU uniq command. Two entries are considered equivalent only if their sequences AND headers are exactly equal. Newlines are ignored but all comparisons are case-sensitive. The pack/unpack option is designed to be compatible with the conventions used in the NCBI-BLAST non-redundant databases: entries with identical sequences are merged and their headers are joined with SOH (0x01) as a delimiter (by default).

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof uniq <options>

Emulates the GNU uniq command. Two entries are considered equivalent only if
their sequences AND headers are exactly equal. Newlines are ignored but all
comparisons are case-sensitive. The pack/unpack option is designed to be
compatible with the conventions used in the NCBI-BLAST non-redundant
databases: entries with identical sequences are merged and their headers are
joined with SOH (0x01) as a delimiter (by default).

positional arguments:
  INPUT                 input fasta sequence (default = stdin)

options:
  -h, --help            show this help message and exit
  -c, --count           writes (count|header) in tab-delimited format
  -d, --repeated        print only repeated entries
  -u, --uniq            print only unique entries
  -p, --pack            combine redundant sequences by concatenating the
                        headers
  -P, --unpack          reverse the pack operation
  -z PACK_SEP, --pack-sep PACK_SEP
                        set delimiting string for pack/unpack operations (SOH,
                        0x01, by default)
  -f, --first-header    remove entries with duplicate headers (keep only the
                        first)
  --removed FILE        With -f, store removed sequences in FILE
```


## smof_wc

### Tool Description
Outputs the total number of entries and the total sequence length (TAB
 delimited).

### Metadata
- **Docker Image**: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
- **Homepage**: https://github.com/incertae-sedis/smof
- **Package**: https://anaconda.org/channels/bioconda/packages/smof/overview
- **Validation**: PASS

### Original Help Text
```text
usage: <fastafile> | smof wc <options>

Outputs the total number of entries and the total sequence length (TAB
delimited).

positional arguments:
  INPUT        input fasta sequence (default = stdin)

options:
  -h, --help   show this help message and exit
  -m, --chars  writes the summed length of all sequences
  -l, --lines  writes the total number of sequences
```


## Metadata
- **Skill**: generated
