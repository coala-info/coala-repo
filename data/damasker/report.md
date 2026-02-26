# damasker CWL Generation Report

## damasker_REPmask

### Tool Description
Repeat masking tool

### Metadata
- **Docker Image**: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
- **Homepage**: https://github.com/thegenemyers/DAMASKER
- **Package**: https://anaconda.org/channels/bioconda/packages/damasker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/damasker/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/thegenemyers/DAMASKER
- **Stars**: N/A
### Original Help Text
```text
Usage: REPmask [-v] [-n<track(rep)] -c<int> <source:db> <overlaps:las> ...

      -v: Verbose mode, output statistics as proceed.
      -c: cutoff depth for declaring an interval repetitive.
      -n: use this name as for the repeat mask track
```


## damasker_datander

### Tool Description
Searches for k-mers in overlapping bands and identifies alignments based on specified criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
- **Homepage**: https://github.com/thegenemyers/DAMASKER
- **Package**: https://anaconda.org/channels/bioconda/packages/damasker/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: datander [-v] [-k<int(12)>] [-w<int(4)>] [-h<int(35)>] [-T<int(4)>] [-P<dir(/tmp)>]
                     [-e<double(.70)] [-l<int(500)>] [-s<int(100)>] <subject:db|dam> ...

      -v: Verbose mode, output statistics as proceed.
      -k: k-mer size (must be <= 32).
      -w: Look for k-mers in averlapping bands of size 2^-w.
      -h: A seed hit if the k-mers in band cover >= -h bps in the targest read.

      -e: Look for alignments with -e percent similarity.
      -l: Look for alignments of length >= -l.
      -s: Use -s as the trace point spacing for encoding alignments.

      -T: Use -T threads.
      -P: Do first level sort and merge in directory -P.
```


## damasker_TANmask

### Tool Description
Report tandem repeats

### Metadata
- **Docker Image**: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
- **Homepage**: https://github.com/thegenemyers/DAMASKER
- **Package**: https://anaconda.org/channels/bioconda/packages/damasker/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: TANmask [-v] [-n<track(tan)>] [-l<int(500)>] <source:db> <overlaps:las> ...

      -v: Verbose mode, output statistics as proceed.
      -l: shortest tandem interval to report.
      -n: use this name as for the tandem mask track
```


## damasker_HPC.REPmask

### Tool Description
HPC.REPmask is a script that runs daligner and REPmask.

### Metadata
- **Docker Image**: quay.io/biocontainers/damasker:1.0p1--h7b50bb2_8
- **Homepage**: https://github.com/thegenemyers/DAMASKER
- **Package**: https://anaconda.org/channels/bioconda/packages/damasker/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: HPC.REPmask [-vbd] [-t<int>] [-w<int(6)>] [-l<int(1000)>] [-s<int(100)>] [-M<int>]
                          [-n<name(rep-g)>] [-P<dir(/tmp)>] [-B<int(4)>] [T<int(4)>] [-f<name>]
                          [-k<int(14)>] [-h<int(35)>] [-e<double(.70)>] [-m<track>]+
                          -g<int> -c<int> <reads:db|dam> [<block:int>[-<range:int>]

     Passed through to daligner.
      -k: k-mer size (must be <= 32).
      -w: Look for k-mers in averlapping bands of size 2^-w.
      -h: A seed hit if the k-mers in band cover >= -h bps in the targest read.
      -t: Ignore k-mers that occur >= -t times in a block.
      -M: Use only -M GB of memory by ignoring most frequent k-mers.

      -e: Look for alignments with -e percent similarity.
      -l: Look for alignments of length >= -l.
      -s: Use -s as the trace point spacing for encoding alignments.

      -T: Use -T threads.
      -P: Do first level sort and merge in directory -P.
      -m: Soft mask the blocks with the specified mask.
      -b: For AT/GC biased data, compensate k-mer counts (deprecated).

     Passed through to REPmask.
      -c: coverage threshold for repeat intervals.
      -n: use this name for the repeat mask track.

     Script control.
      -v: Run all commands in script in verbose mode.
      -g: # of blocks per comparison group.
      -d: Put .las files for each target block in a sub-directory
      -B: # of block compares per daligner job
      -f: Place script bundles in separate files with prefix <name>
```

