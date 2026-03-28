# src/abimerge

Theme:

🌗 Match OS
🌑 Dark
🌕 Light

* [Index](theindex.html)

Search:

Group by:
Section
Type

* [Imports](#6)
* [Types](#7)
  + [Config](#Config "Config = object
      inputFileF*: string
      inputFileR*: string
      outputFile*: string
      minOverlap*: int
      scoreMatch*: int
      scoreMismatch*: int
      scoreGap*: int
      minScore*: int
      pctId*: float
      joinGap*: int
      verbose*: bool
      windowSize*: int
      qualityThreshold*: int
      noTrim*: bool
      showVersion*: bool
      fasta*: bool")
  + [swAlignment](#swAlignment "swAlignment = object
      top*: string               ## The first sequence in the alignment
      bottom*: string            ## The second sequence in the alignment
      middle*: string            ## The alignment representation (|, ., or space)
      score*: int                ## The alignment score
      length*: int               ## The length of the alignment
      pctid*: float
      queryStart*, queryEnd*, targetStart*, targetEnd*: int")
  + [swWeights](#swWeights "swWeights = object
      match*: int                ## Score for matching bases
      mismatch*: int             ## Penalty for mismatched bases
      gap*: int                  ## Penalty for gap extension
      gapopening*: int           ## Penalty for opening a gap
      minscore*: int             ## Minimum score for accepting an alignment")
* [Lets](#9)
  + [swDefaults](#swDefaults "swDefaults = swWeights(match: 6, mismatch: -4, gap: -6, gapopening: -6,
                           minscore: 1)")
* [Procs](#12)

  makeMatrix- [makeMatrix[T](rows, cols: int; initValue: T): seq[seq[T]]](#makeMatrix%2Cint%2Cint%2CT "makeMatrix[T](rows, cols: int; initValue: T): seq[seq[T]]")
  matchIUPAC- [matchIUPAC(a, b: char): bool](#matchIUPAC%2Cchar%2Cchar "matchIUPAC(a, b: char): bool")
  mergeSequences- [mergeSequences(forwardSeq: string; forwardQual: seq[int]; reverseSeq: string;
    reverseQual: seq[int]; config: Config): tuple[seq: string,
    qual: seq[int]]](#mergeSequences%2Cstring%2Cseq%5Bint%5D%2Cstring%2Cseq%5Bint%5D%2CConfig "mergeSequences(forwardSeq: string; forwardQual: seq[int]; reverseSeq: string;
                   reverseQual: seq[int]; config: Config): tuple[seq: string,
        qual: seq[int]]")
  revcompl- [revcompl(s: string): string](#revcompl%2Cstring "revcompl(s: string): string")
  reverseString- [reverseString(str: string): string](#reverseString%2Cstring "reverseString(str: string): string")
  simpleSmithWaterman- [simpleSmithWaterman(alpha, beta: string; weights: swWeights): swAlignment](#simpleSmithWaterman%2Cstring%2Cstring%2CswWeights "simpleSmithWaterman(alpha, beta: string; weights: swWeights): swAlignment")
  translateIUPAC- [translateIUPAC(c: char): char](#translateIUPAC%2Cchar "translateIUPAC(c: char): char")

[Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L1)
[Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L1)

This module provides a command-line tool for merging two ABI trace files (forward and reverse) into a single sequence.

The abimerge tool uses Smith-Waterman local alignment to find the overlapping region between forward and reverse sequences, then merges them to create a consensus sequence with improved accuracy.

Command-line usage:

```
abimerge [options] <input_F.ab1> <input_R.ab1> [output.fastq]
```

Options:

-h, --help

Show help message

-m, --min-overlap INT

Minimum overlap length for merging (default: 20)

-o, --output STRING

Output file name (default: STDOUT)

-j, --join INT

Join with gap of INT Ns if no overlap detected

--fasta

Output in FASTA format instead of FASTQ

--score-match INT

Score for a match (default: 10)

--score-mismatch INT

Score for a mismatch (default: -8)

--score-gap INT

Score for a gap (default: -10)

--min-score INT

Minimum alignment score (default: 80)

--pct-id FLOAT

Minimum percentage identity (default: 85)

Examples:

```
# Merge two ABIF files with default settings
abimerge forward.ab1 reverse.ab1 merged.fastq

# Merge with custom alignment parameters
abimerge --min-overlap 30 --score-match 12 forward.ab1 reverse.ab1 merged.fastq

# Join sequences with N gap if no overlap
abimerge -j 10 forward.ab1 reverse.ab1 merged.fastq

# Output in FASTA format instead of FASTQ
abimerge --fasta forward.ab1 reverse.ab1 merged.fasta
```

# [Imports](#6)

[abif](abif.html)

# [Types](#7)

``` Config = object inputFileF*: string inputFileR*: string outputFile*: string minOverlap*: int scoreMatch*: int scoreMismatch*: int scoreGap*: int minScore*: int pctId*: float joinGap*: int verbose*: bool windowSize*: int qualityThreshold*: int noTrim*: bool showVersion*: bool fasta*: bool ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L261)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L261)

``` swAlignment = object top*: string ## The first sequence in the alignment bottom*: string ## The second sequence in the alignment middle*: string ## The alignment representation (|, ., or space) score*: int ## The alignment score length*: int ## The length of the alignment pctid*: float queryStart*, queryEnd*, targetStart*, targetEnd*: int ```
:   Represents a Smith-Waterman alignment between two sequences.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L44)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L44)

``` swWeights = object match*: int ## Score for matching bases mismatch*: int ## Penalty for mismatched bases gap*: int ## Penalty for gap extension gapopening*: int ## Penalty for opening a gap minscore*: int ## Minimum score for accepting an alignment ```
:   Scoring parameters for Smith-Waterman alignment.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L55)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L55)

# [Lets](#9)

``` swDefaults = swWeights(match: 6, mismatch: -4, gap: -6, gapopening: -6, minscore: 1) ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L64)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L64)

# [Procs](#12)

``` proc makeMatrix[T](rows, cols: int; initValue: T): seq[seq[T]] ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L75)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L75)

``` proc matchIUPAC(a, b: char): bool {....raises: [], tags: [], forbids: [].} ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L220)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L220)

``` proc mergeSequences(forwardSeq: string; forwardQual: seq[int]; reverseSeq: string; reverseQual: seq[int]; config: Config): tuple[ seq: string, qual: seq[int]] {....raises: [], tags: [], forbids: [].} ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L443)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L443)

``` proc revcompl(s: string): string {....raises: [], tags: [], forbids: [].} ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L254)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L254)

``` proc reverseString(str: string): string {....raises: [], tags: [], forbids: [].} ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L73)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L73)

``` proc simpleSmithWaterman(alpha, beta: string; weights: swWeights): swAlignment {. ...raises: [], tags: [], forbids: [].} ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L89)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L89)

``` proc translateIUPAC(c: char): char {....raises: [], tags: [], forbids: [].} ```
:   [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abimerge.nim#L208)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abimerge.nim#L208)

Made with Nim. Generated: 2025-07-23 15:08:17 UTC