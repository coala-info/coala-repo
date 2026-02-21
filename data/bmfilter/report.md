# bmfilter CWL Generation Report

## bmfilter

### Tool Description
Filter reads based on word bitmask matches

### Metadata
- **Docker Image**: quay.io/biocontainers/bmfilter:3.101--hfc679d8_2
- **Homepage**: https://github.com/Ikyy593/BMFilter_ikyy
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bmfilter/overview
- **Total Downloads**: 38.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Ikyy593/BMFilter_ikyy
- **Stars**: N/A
### Original Help Text
```text
/usr/local/bin/bmfilter
Filter reads based on word bitmask matches
where options are:
[general]
  --help                        -h             Print help
  --version                     -V             Print version
[input]
  --quality-channels=0          -q 0           Number of quality channers for reads (0|1)
  --read-1=''                   -1 ''          Fasta or fastq (for -q1) file with reads, may be repeated
  --read-2=''                   -2 ''          Fasta or fastq (for -q1) file with read pair mates, if used should be repeated as many times as -1 is
  --word-bitmask=''             -b ''          Word bitmask file (may be repeated)
  --use-mmap                    -M             Use mmap for word bitmask (slow unless used for few reads; intended for debug) [off]
[input-filters]
  --max-ambiguities=0           -a 0           Maximal number of ambiguities per word
  --clip-lowercase              -l             Should lowercase head and tail of each read be clipped [off]
  --clip-N-win=0                -N 0           Clip sequence head or tail as long as it has at least one N per this long window
  --clip-quality=0              -Q 0           Clip sequence head or tail with quality lower then this (for fastq input)
[output]
  --output=''                   -o ''          Output base name (suffixes will be added to it)
  --tag                         -T             Produce .tag file [off]
  --post                        -P             Produce .short?.fa and .long?.fa files [off]
  --report                      -R             Produce .report file [off]
  --post-clipped                -z             Put clipped versions of sequences to output .fa files [off]
  --complexity=2                -F 2           Set complexity filter cutoff
  --short-seq=1073741823        -L 1073741823  Set sequence length to consider it as short for postprocessing
  --no-post-len=25              -n 25          Set longest sequence length to ignore postprocessing
  --chop-length=32              -c 32          Set length to chop short sequences to
  --chop-step=4                 -s 4           Set step by which to chop short sequences
  --mask-early=0                -m 0           Set mask low complexity before applying heuristics
  --post-low-complexity=0       -Z 0           Should 'unknown' low complexity reads be sent to post processing
[heuristics]
  --heur-min-words=10                          Set minimal word count to apply heuristics
  --heur-many-words=200                        Set number of good words which switches watermarks (long/short)
  --heur-count-long-pct=20:60                  Set watermarks for matched word count for long sequences, int % of good words
  --heur-count-short-pct=20:80                 Set watermarks for matched word count for short sequences, int % of good words
  --heur-run-long-pct=10:20                    Set watermarks for longest match run for long sequences, int % of good words
  --heur-run-short-pct=10:40                   Set watermarks for longest match run for short sequences, int % of good words
  --heur-negligible-length=15                  Set cutoff for sequences to consider - these and shorter (after clipping) will be marked as foreign
```


## Metadata
- **Skill**: not generated
