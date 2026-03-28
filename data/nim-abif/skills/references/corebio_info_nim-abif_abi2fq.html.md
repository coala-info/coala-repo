# src/abi2fq

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
      inFile*: string            ## Path to the input ABIF file
      outFile*: string           ## Path to the output FASTQ file (or empty for stdout)
      windowSize*: int           ## Window size for quality trimming (default: 10)
      qualityThreshold*: int     ## Quality threshold 0-60 (default: 20)
      noTrim*: bool              ## Whether to disable quality trimming
      verbose*: bool             ## Whether to show verbose output
      showVersion*: bool         ## Whether to show version information
      fasta*: bool               ## Whether to output in FASTA format instead of FASTQ
      split*: bool               ## Whether to split ambiguous bases into two sequences")
* [Procs](#12)

  main- [main()](#main "main()")
  parseCommandLine- [parseCommandLine(): Config](#parseCommandLine "parseCommandLine(): Config")
  printHelp- [printHelp()](#printHelp "printHelp()")
  splitAmbiguousBases- [splitAmbiguousBases(sequence: string): tuple[seq1: string, seq2: string]](#splitAmbiguousBases%2Cstring "splitAmbiguousBases(sequence: string): tuple[seq1: string, seq2: string]")
  trimSequence- [trimSequence(sequence: string; qualities: seq[int]; windowSize: int;
    threshold: int): tuple[seq: string, qual: seq[int]]](#trimSequence%2Cstring%2Cseq%5Bint%5D%2Cint%2Cint "trimSequence(sequence: string; qualities: seq[int]; windowSize: int;
                 threshold: int): tuple[seq: string, qual: seq[int]]")
  writeFastq- [writeFastq(sequence: string; qualities: seq[int]; name: string;
    outFile: string = ""; fasta: bool = false; splitSeq1: string = "";
    splitSeq2: string = "")](#writeFastq%2Cstring%2Cseq%5Bint%5D%2Cstring%2Cstring%2Cbool%2Cstring%2Cstring "writeFastq(sequence: string; qualities: seq[int]; name: string;
               outFile: string = \"\"; fasta: bool = false; splitSeq1: string = \"\";
               splitSeq2: string = \"\")")

[Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L1)
[Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L1)

This module provides a command-line tool for converting ABIF files to FASTQ or FASTA format with optional quality trimming.

The abi2fq tool extracts sequence and quality data from ABIF files, applies quality trimming to remove low-quality regions, and outputs in the standard FASTQ format or FASTA format (if --fasta is specified).

Command-line usage:

```
abi2fq [options] <input.ab1> [output.fq]
```

Options:

-h, --help

Show help message

-w, --window=INT

Window size for quality trimming (default: 10)

-q, --quality=INT

Quality threshold 0-60 (default: 20)

-n, --no-trim

Disable quality trimming

-v, --verbose

Print additional information

--version

Show version information

--fasta

Output in FASTA format instead of FASTQ

-s, --split

Split ambiguous bases into two sequences

Examples:

```
# Convert with default quality trimming
abi2fq input.ab1 output.fastq

# Convert without quality trimming
abi2fq -n input.ab1 output.fastq

# Convert with custom quality parameters
abi2fq -w 20 -q 30 input.ab1 output.fastq

# Convert to FASTA format
abi2fq --fasta input.ab1 output.fasta

# Split ambiguous bases into two sequences
abi2fq -s input.ab1 output.fastq
```

# [Imports](#6)

[abif](abif.html)

# [Types](#7)

``` Config = object inFile*: string ## Path to the input ABIF file outFile*: string ## Path to the output FASTQ file (or empty for stdout) windowSize*: int ## Window size for quality trimming (default: 10) qualityThreshold*: int ## Quality threshold 0-60 (default: 20) noTrim*: bool ## Whether to disable quality trimming verbose*: bool ## Whether to show verbose output showVersion*: bool ## Whether to show version information fasta*: bool ## Whether to output in FASTA format instead of FASTQ split*: bool ## Whether to split ambiguous bases into two sequences ```
:   Configuration for the abi2fq tool. Contains command-line options and settings.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L45)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L45)

# [Procs](#12)

``` proc main() {....raises: [ValueError], tags: [ReadIOEffect, WriteIOEffect], forbids: [].} ```
:   Main entry point for the abi2fq program.

    Handles command-line parsing, reads the input ABIF file, performs quality trimming if enabled, and outputs the result in FASTQ or FASTA format (depending on the --fasta option).

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L290)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L290)

``` proc parseCommandLine(): Config {....raises: [ValueError], tags: [ReadIOEffect], forbids: [].} ```
:   Parses command-line arguments and returns a Config object.

    This procedure:

    * Initializes Config with default values
    * Processes command-line arguments
    * Validates parameter values
    * Handles special flags like --version and --help

    Returns: A Config object with settings based on command-line arguments

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L81)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L81)

``` proc printHelp() {....raises: [], tags: [], forbids: [].} ```
:   Displays the help message for the abi2fq tool. Exits the program after displaying the message.
    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L58)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L58)

``` proc splitAmbiguousBases(sequence: string): tuple[seq1: string, seq2: string] {. ...raises: [KeyError], tags: [], forbids: [].} ```
:   Splits ambiguous bases into two sequences.

    Splits sequence at every ambiguous base that represents exactly 2 alternatives. IUPAC ambiguity codes:

    * R = A or G
    * Y = C or T
    * S = G or C
    * W = A or T
    * K = G or T
    * M = A or C

    Parameters: sequence: The DNA sequence to split

    Returns: A tuple containing the two split sequences

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L247)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L247)

``` proc trimSequence(sequence: string; qualities: seq[int]; windowSize: int; threshold: int): tuple[seq: string, qual: seq[int]] {. ...raises: [], tags: [], forbids: [].} ```
:   Trims low-quality regions from the beginning and end of a sequence.

    Uses a sliding window approach to identify regions where the average quality score is below the threshold.

    Parameters: sequence: The DNA sequence to trim qualities: Quality scores for each base in the sequence windowSize: Size of the sliding window for quality assessment threshold: Quality threshold (bases with qualities below this are trimmed)

    Returns: A tuple containing the trimmed sequence and its quality values

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L154)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L154)

``` proc writeFastq(sequence: string; qualities: seq[int]; name: string; outFile: string = ""; fasta: bool = false; splitSeq1: string = ""; splitSeq2: string = "") {. ...raises: [IOError], tags: [WriteIOEffect], forbids: [].} ```
:   Writes sequence and quality data to a FASTQ or FASTA file.

    If outFile is empty, the data is written to stdout. If fasta is true, the output will be in FASTA format instead of FASTQ. If splitSeq1 and splitSeq2 are not empty, writes them as two separate records.

    Parameters: sequence: The DNA sequence to write (used when not splitting) qualities: Quality scores for each base in the sequence name: The sample name for the header outFile: Path to the output file (empty string for stdout) fasta: Whether to output in FASTA format instead of FASTQ splitSeq1: First sequence when splitting ambiguous bases splitSeq2: Second sequence when splitting ambiguous bases

    [Source](https://github.com/quadram-institute-bioscience/nim-abif//tree/main/src/abi2fq.nim#L204)
    [Edit](https://github.com/quadram-institute-bioscience/nim-abif//edit/devel/src/abi2fq.nim#L204)

Made with Nim. Generated: 2025-07-23 15:08:17 UTC