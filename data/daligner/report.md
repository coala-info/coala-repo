# daligner CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| daligner | PASS |  |
| daligner_HPC.daligner | PASS |  |
| daligner_LA2ONE | PASS |  |
| daligner_LAcat | PASS |  |
| daligner_LAcheck | PASS |  |
| daligner_LAmerge | PASS |  |
| daligner_LAshow | Failed | tool bug: LAshow always aborts at exit (free(): invalid pointer), so the job fails and the last lines of its output are lost; with read ranges it also crashes. |
| daligner_LAsort | PASS |  |
| daligner_LAsplit | PASS |  |
| daligner_ONE2LA | PASS |  |

## Metadata
- **Skill**: generated

## daligner_LAshow

### Tool Description
Display local alignments produced by daligner in a human-readable format.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LAshow [-caroU] [-i<int(4)>] [-w<int(100)>] [-b<int(10)>] 
                  <src1:db|dam> [ <src2:db|dam> ] <align:las> [ <reads:FILE> | <reads:range> ... ]

      -c: Show a cartoon of the LA between reads.
      -a: Show the alignment of each LA.
      -r: Show the alignment of each LA with -w bp's of A in each row.
      -o: Show only proper overlaps.
      -F: Switch the roles of A- and B-reads.

      -U: Show alignments in upper case.
      -i: Indent alignments and cartoons by -i.
      -w: Width of each row of alignment in symbols (-a) or bps (-r).
      -b: # of border bp.s to show on each side of LA.
```

## daligner

### Tool Description
Find all significant local alignments between the reads of a subject DAZZ_DB block and one or more target blocks.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: daligner2.0 [-vaABI] [-k<int(16)>] [-%<int(28)>] [-h<int(50)>] [-w<int(6)>] [-t<int>]
                            [-M<int>] [-e<double(.75)] [-l<int(1500)>] [-s<int(100)>] [-H<int>]
                            [-T<int(4)>] [-P<dir(/tmp)>] [-m<track>]+
                            <subject:db|dam> <target:db|dam> ...

      -k: k-mer size (must be <= 32).
      -%: modimer percentage (take % of the k-mers).
      -w: Look for k-mers in averlapping bands of size 2^-w.
      -h: A seed hit if the k-mers in band cover >= -h bps in the targest read.
      -t: Ignore k-mers that occur >= -t times in a block.
      -M: Use only -M GB of memory by ignoring most frequent k-mers.

      -e: Look for alignments with -e percent similarity.
      -l: Look for alignments of length >= -l.
      -s: The trace point spacing for encoding alignments.
      -B: Bridge consecutive aligned segments into one if possible
      -H: HGAP option: align only target reads of length >= -H.

      -T: Use -T threads.
      -P: Do block level sorts and merges in directory -P.
      -m: Soft mask the blocks with the specified mask.

      -v: Verbose mode, output statistics as proceed.
      -a: sort .las by A-read,A-position pairs for map usecase
          off => sort .las by A,B-read pairs for overlap piles
      -A: Compare subjet to target, but not vice versa.
      -I: Compare reads to themselves
```

## daligner_HPC.daligner

### Tool Description
Write a shell script that runs daligner, LAsort and LAmerge over all blocks of a split DAZZ_DB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HPC.daligner [-vad] [-l<int(1500)>] [-s<int(100)] [-w<int(6)>] [-t<int>] [-M<int>]
                           [-P<dir(/tmp)>] [-B<int(4)>] [-T<int(4)>] [-f<name>]
                         ( [-k<int(16)>] [-%<int(28)>] [-h<int(50)>] [-e<double(.75)>] [-H<int>]
                           [-k<int(20)>] [-%<int(50)>] [-h<int(70)>] [-e<double(.85)>] <ref:db|dam> )
                           [-m<track>]+ <reads:db|dam> [<first:int>[-<last:int>]]

     Passed through to daligner.
      -k: k-mer size (must be <= 32).
      -%: modimer percentage (take % of the k-mers).
      -w: Look for k-mers in averlapping bands of size 2^-w.
      -h: A seed hit if the k-mers in band cover >= -h bps in the targest read.
      -t: Ignore k-mers that occur >= -t times in a block.
      -M: Use only -M GB of memory by ignoring most frequent k-mers.

      -e: Look for alignments with -e percent similarity.
      -l: Look for alignments of length >= -l.
      -s: Use -s as the trace point spacing for encoding alignments.
      -H: HGAP option: align only target reads of length >= -H.

      -T: Use -T threads.
      -P: Do first level sort and merge in directory -P.
      -m: Soft mask the blocks with the specified mask.

     Script control.
      -v: Run all commands in script in verbose mode.
      -a: Instruct LAsort & LAmerge to sort only on (a,ab).
      -d: Put .las files for each target block in a sub-directory
      -B: # of block compares per daligner job
      -f: Place script bundles in separate files with prefix <name>
```

## daligner_LAsort

### Tool Description
Sort .las alignment files (X.las becomes X.S.las).

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LAsort [-va] <align:las> ...

      -v: Verbose mode, output statistics as proceed.
      -a: sort .las by A-read,A-position pairs for map usecase
          off => sort .las by A,B-read pairs for overlap piles
```

## daligner_LAmerge

### Tool Description
Merge sorted .las alignment files into one sorted .las file.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LAmerge [-va] [-P<dir(/tmp)>] <merge:las> <parts:las> ...

      -v: Verbose mode, output statistics as proceed.
      -a: sort .las by A-read,A-position pairs for map usecase
          off => sort .las by A,B-read pairs for overlap piles
      -P: Do any intermediate merging in directory -P.
```

## daligner_LAcat

### Tool Description
Concatenate .las alignment files into one .las file.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LAcat [-v] <source:las> ... > <target>.las

    <source>'s may contain a template that is @-sign optionally
      followed by an integer or integer range
```

## daligner_LAsplit

### Tool Description
Split a .las alignment file into parts, by count or by the blocks of a split database.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LAsplit -v <target:las> (<parts:int> | <path:db|dam>) < <source>.las

    <target> is a template that must have a single @-sign in it
    This symbol is replaced by numbers 1 to n = the number of parts
```

## daligner_LAcheck

### Tool Description
Check the integrity and sort order of .las alignment files against their source database.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LAcheck [-vaS] <src1:db|dam> [ <src2:db|dam> ] <align:las> ...

      -v: Verbose mode, output error messages.
      -S: Check that .las is in sorted order.
      -a: If -S, then check sorted by A-read, A-position pairs
          off => check sorted by A,B-read pairs (LA-piles)
```

## daligner_LA2ONE

### Tool Description
Convert a .las alignment file to ONE-code (.dal) text format.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: LA2ONE [-cto] <src1:db|dam> [<src2:db|dam>] <align:las> [<reads:FILE> | <reads:range> ...]

      Output pile reads, orientation, and chains by default (P, O, C lines)

      -c: Ootput also aligned intervals, read lengths, and diffs (B, E, L, and D lines)
      -t: Output also traces (T and Q lines)

      -o: Output proper overlaps only
```

## daligner_ONE2LA

### Tool Description
Convert a ONE-code .dal alignment file back to a .las file.

### Metadata
- **Docker Image**: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
- **Homepage**: https://github.com/thegenemyers/DALIGNER
- **Package**: https://anaconda.org/channels/bioconda/packages/daligner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ONE2LA <align:dal> > (.las)
```
