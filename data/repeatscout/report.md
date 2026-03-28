# repeatscout CWL Generation Report

## repeatscout_build_lmer_table

### Tool Description
Builds a table of lmers from a sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
- **Homepage**: https://github.com/Dfam-consortium/RepeatScout
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatscout/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repeatscout/overview
- **Total Downloads**: 37.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Dfam-consortium/RepeatScout
- **Stars**: N/A
### Original Help Text
```text
build_lmer_table Version 1.0.7

Usage:
   build_lmer_table -l <l> -sequence <seq> -freq <output> [opts]
       -tandem <d> --- tandem distance window (def: 500)
       -min <#> --- smallest number of required lmers (def: 3)
       -v --- output a small amount of debugging information.
```


## repeatscout_RepeatScout

### Tool Description
RepeatScout Version 1.0.7

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
- **Homepage**: https://github.com/Dfam-consortium/RepeatScout
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatscout/overview
- **Validation**: PASS

### Original Help Text
```text
RepeatScout Version 1.0.7

Usage: 
RepeatScout [opts][-ranges <file>] -sequence <file> -output <file> -freq <file> -l #
     -sequence <file>  # file containing sequence data (FASTA format)
     -output <file>    # file to write identified consensi to (FASTA format)
     -freq <file>      # file containing l-mer frequency table
     -l #              # length of l-mers to use (must be same as frequency file)
     -ranges <file>    # file to save the extended sequence ranges (optional)

     -L # size of region to extend left or right (10000) 
     -match # reward for a match (+1)  
     -mismatch # penalty for a mismatch (-1) 
     -gap  # penalty for a gap (-5)
     -maxgap # maximum number of gaps allowed (5) 
     -maxoccurrences # cap on the number of sequences to align (10,000) 
     -maxrepeats # stop work after reporting this number of repeats (10000)
     -cappenalty # cap on penalty for exiting alignment of a sequence (-20)
     -tandemdist # of bases that must intervene between two l-mers for both to be counted (500)
     -minthresh # stop if fewer than this number of l-mers are found in the seeding phase (3)
     -minimprovement # amount that a the alignment needs to improve each step to be considered progress (3)
     -stopafter # stop the alignment after this number of no-progress columns (100)
     -goodlength # minimum required length for a sequence to be reported (50)
     -maxentropy # entropy (complexity) threshold for an l-mer to be considered (-.7)
     -v[v[v[v]]] How verbose do you want it to be?  -vvvv is super-verbose.
```


## repeatscout_filter-stage-1.prl

### Tool Description
a first stage post-processing tool for RepeatScout output.

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
- **Homepage**: https://github.com/Dfam-consortium/RepeatScout
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatscout/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    filter-stage-1.prl -- a first stage post-processing tool for RepeatScout
    output.

SYNOPSIS
    cat repeats.fa | filter-stage-1.prl > repeats-filtered.prl

OPTIONS
    none other than "-h" (the output of which you're reading), but you will
    either want trf and dustmasker in your PATH, or you will want to set the
    environment variables TRF_COMMAND and DUSTMASKER_COMMAND to provide the
    executable.

DESCRIPTION
    This tool takes a repeat library, which is a Fasta-formatted sequence
    file, and filters out any sequence that is deemed to be more than 50%
    low-complexity by either TRF or dustmasker or both. Note that one
    algorithm needs to make the determination; we don't check the total
    number of unique bases masked out by TRF and dustmasker individually.

ENVIRONMENT VARIABLES
    In order for this program to find TRF and dustmasker, you need to either
    place said programs in your PATH, or you need to add the environment
    variables TRF_COMMAND and DUSTMASKER_COMMAND. The value of those
    variables should be the path at which the respective program can be
    found.
```


## repeatscout_filter-stage-2.prl

### Tool Description
Filter a repeat library by number of occurrences

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
- **Homepage**: https://github.com/Dfam-consortium/RepeatScout
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatscout/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    filter-stage-2.prl --- Filter a repeat library by number of occurrences

SYNOPSIS
    cat repeats.lib | ./filter-stage-2.prl --cat=repeats.out --thresh=20

DESCRIPTION
    It is necessary to filter a library of repeats based on the number of
    times each type of repeat element occurs in RepeatMasker output.

OPTIONS
   --cat
    The RepeatMasker output file. It can either be a .cat file or a .out
    file, but a .out file is preferred.

   --thresh
    The number of times a sequence must appear for it to be reported.

NOTES
    The Fasta-formatted repeat library must be sent to this program from
    standard input.

    Each entry in the repeat library should be named like so: >name then put
    whatever you want here ATAATG...

    In the RepeatMasker output, a given repeat will be listed with "name"
    next to it. Please do not make a repeat library where two sequences have
    the same first word in the ">" header line.
```


## repeatscout_compare-out-to-gff.prl

### Tool Description
Compares RepeatMasker output to a set of GFF feature files.

### Metadata
- **Docker Image**: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
- **Homepage**: https://github.com/Dfam-consortium/RepeatScout
- **Package**: https://anaconda.org/channels/bioconda/packages/repeatscout/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    compare-out-to-gff.prl --- Compares RepeatMasker output to a set of GFF
    feature files.

SYNOPSIS
    compare-out-to-gff.prl --gff=file1.gff --gff=file2.gff
    --cat=repeatmasker.out --f=file.fa > lib.ref

DESCRIPTION
    When discovering repeat families with a de novo method, it is sometimes
    useful to take the masked instances from RepeatMasker and deterine to
    what extent they overlap other features. For example, you might want to
    see if the repeat instances predominantly overlap exons, or segmental
    duplications. Or, for that matter, instances of known repeats from
    human-curated libraries. This program does that.

OPTIONS
    There are two required options: --cat and one or more --gff.

   --cat
    RepeatMasker instances in either .cat format or .out format (prefer
    .out)

   --gff
    A GFF-formatted file of features. More than one file may be specified
    with multiple --gff options.

   --f
    A fasta formatted file. If this is given, then sequences that are under
    (over) the overlap threshold will be in the output. This is a sequence
    filter.

   --threshold
    The maximum (minimum) amount of overlap tolerated by any one type of
    repeat.

   --over
    Determines if the threshold is a minimum or a maximum (defaults to
    maximum; including --over makes it a minimum)

   --instances
    Determines how the overlap calculation is done. If this is not
    specified, the overlap is calculated by bases: if 40 bases of a repeat
    element overlaps a feature in one of the GFF files, it is counted as 40
    bases. The sum is taken over all features and all repeats of a given
    type and divided by the total length of the repeat. If --instances is
    specified, the "overlap" is considered to be the number of instances of
    a given type that overlap any feature, divided by the total number of
    instances of that type.

  BUGS
    None known. This program is remarkably slow, though, and could be sped
    up significantly with a very easy fix.
```


## Metadata
- **Skill**: generated
