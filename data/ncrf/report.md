# ncrf CWL Generation Report

## ncrf_NCRF

### Tool Description
Noise Cancelling Repeat Finder, to find tandem repeats in noisy reads

### Metadata
- **Docker Image**: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
- **Homepage**: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/ncrf/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ncrf/overview
- **Total Downloads**: 16.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
- **Stars**: N/A
### Original Help Text
```text
NCRF-- Noise Cancelling Repeat Finder, to find tandem repeats in noisy reads
  (version 1.01.02 20190429)
usage: cat <fasta> | NCRF [options]

  <fasta>               fasta file containing sequences; read from stdin
  [<name>:]<motif>      dna repeat motif to search for
                        (there can be more than one motif)
  --minmratio=<ratio>   discard alignments with a low frequency of matches;
                        ratio can be between 0 and 1 (e.g. "0.85"), or can be
                        expressed as a percentage (e.g. "85%")
  --maxnoise=<ratio>    (same as --minmratio but with 1-ratio)
  --minlength=<bp>      discard alignments that don't have long enough repeat
                        (default is 500)
  --minscore=<score>    discard alignments that don't score high enough
                        (default is zero)
  --stats=events        show match/mismatch/insert/delete counts
  --positionalevents    show match/mismatch/insert/delete counts by motif
                        position (independent of --stats=events); this may be
                        useful for detecting error non-uniformity, to separate
                        perfect repeats from imperfect
  --help=scoring        show options relating to alignment scoring
  --help=allocation     show options relating to memory allocation
  --help=other          show other, less frequently used options

  The output is usually passed through a series of the ncrf_* post-processing
  scripts.
```


## ncrf_ncrf_cat.py

### Tool Description
Concatenate several output files from Noise Cancelling Repeat Finder. This is little more than copying the files and adding a blank line between the files.

It can also be used to verify that the input files contain end-of-file markers i.e. that they were not truncated when created.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
- **Homepage**: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/ncrf/overview
- **Validation**: PASS

### Original Help Text
```text
you have to give me at least one file

usage: ncrf_cat <file1> [<file2> ...] [--markend]
  <file1>    an output file from Noise Cancelling Repeat Finder
  <file2>    another output file from Noise Cancelling Repeat Finder
  --markend  assume end-of-file markers are absent in the input, and add an
             end-of-file marker to the output
             (by default we require inputs to have proper end-of-file markers)

Concatenate several output files from Noise Cancelling Repeat Finder.  This
is little more than copying the files and adding a blank line between the
files.

It can also be used to verify that the input files contain end-of-file markers
i.e. that they were not truncated when created.
```


## ncrf_ncrf_consensus_filter.py

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
- **Homepage**: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/ncrf/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
ncrf_consensus_filter.py: alignment input may have been truncated (end marker is absent)
```


## ncrf_ncrf_resolve_overlaps.py

### Tool Description
Resolves overlaps in alignment summaries.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
- **Homepage**: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/ncrf/overview
- **Validation**: PASS

### Original Help Text
```text
you have to give me at least one summary file

usage: ncrf_resolve_overlaps <alignment_summary..> [options]
  <alignment_summary>    (cumulative) file(s) containing aligment summaries
                         for which overlaps are to be resolved
  --head=<number>        limit the number of input aligment summaries
  --out=<name_template>  file to write overlap groups to; see discussion of
                         name template below; if this option is absent, all
                         output is written to the console

The name template either names a single file or a collection of files.  If
if includes the substring "{motif}", this substring is replaced by a motif name
and any un-overlapped alignments to that motif are written to that file. If
the template name doesn't include "{motif}", all un-overlapped alignments and
overlapping groups are written to one file.

Overlapping groups are either written to the console (if no name template is
given), to the same file with alignments (if the name template doesn't contain
"{motif}"), or to a a file separate from the alignments (with "{motif}"
replaced by "overlaps").

The alignment summaries are usually the output from ncrf_summary. Any file may
contain alignments for more than one motif.

A typical input file is shown below. However, we do not interpret any columns
other than motif, seq, start, and end. This allows, for example, the output
from ncrf_summary_with_consensus.

  #line motif seq        start end  strand seqLen querybp mRatio m    mm  i  d
  1     GGAAT FAB41174_6 1568  3021 -      3352   1461    82.6%  1242 169 42 50
  11    GGAAT FAB41174_2 3908  5077 -      7347   1189    82.4%  1009 125 35 55
  21    GGAAT FAB41174_0 2312  3334 -      4223   1060    81.1%  881  115 26 64
   ...
```


## ncrf_ncrf_to_bed.py

### Tool Description
Converts NCRF output to BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ncrf:1.01.02--h7b50bb2_6
- **Homepage**: https://github.com/makovalab-psu/NoiseCancellingRepeatFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/ncrf/overview
- **Validation**: PASS

### Original Help Text
```text
unrecognized option: --help

usage: ncrf_cat <output_from_NCRF> | ncrf_to_bed [options]
  --minmratio=<ratio>  discard alignments with a low frequency of matches;
                       ratio can be between 0 and 1 (e.g. "0.85"), or can be
                       expressed as a percentage (e.g. "85%")
  --maxnoise=<ratio>   (same as --minmratio but with 1-ratio)

Typical output is shown below.  The 6th column ("score" in the bed spec) is
the match ratio times 1000 (e.g. 826 is 82.6%).
  FAB41174_065680 1568 3021 . - 826
  FAB41174_029197 3908 5077 . - 824
  FAB41174_005950 2312 3334 . - 811
   ...
```


## Metadata
- **Skill**: generated
