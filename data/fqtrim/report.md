# fqtrim CWL Generation Report

## fqtrim

### Tool Description
Trim low quality bases at the 3' end and can trim adapter sequence(s), filter for low complexity and collapse duplicate reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtrim:0.9.7--h077b44d_7
- **Homepage**: https://ccb.jhu.edu/software/fqtrim/
- **Package**: https://anaconda.org/channels/bioconda/packages/fqtrim/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fqtrim/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
fqtrim v0.9.7. Usage:
fqtrim [{-5 <5adapter> -3 <3adapter>|-f <adapters_file>}] [-a <min_match>]\
   [-R] [-q <minq> [-t <trim_max_len>]] [-p <numcpus>] [-P {64|33}] \
   [-m <max_percN>] [--ntrimdist=<max_Ntrim_dist>] [-l <minlen>] [-C]\
   [-o <outsuffix> [--outdir <outdir>]] [-D][-Q][-O] [-n <rename_prefix>]\
   [-r <trim_report.txt>] [-y <min_poly>] [-A|-B] <input.fq>[,<input_mates.fq>\
 
 Trim low quality bases at the 3' end and can trim adapter sequence(s), filter
 for low complexity and collapse duplicate reads.
 If read pairs should be trimmed and kept together (i.e. never discarding
 only one read in a pair), the two file names should be given delimited by a comma
 or a colon character.

Options:
-n  rename the reads using the <prefix> followed by a read counter;
    if -C option was also provided, the suffix "_x<N>" is appended
    (where <N> is the read duplication count)
-o  write the trimmed/filtered reads to file(s) named <input>.<outsuffix>
    which will be created in the current (working) directory (unless --outdir
    is used); this suffix should include the file extension; if this extension
    is .gz, .gzip or .bz2 then the output will be compressed accordingly.
    NOTE: if the input file is '-' (stdin) then this is the full name of the
    output file, not just the suffix.
--outdir for -o option, write the output file(s) to <outdir> directory instead
-f  file with adapter sequences to trim, each line having this format:
    [<5_adapter_sequence>][ <3_adapter_sequence>]
-5  trim the given adapter or primer sequence at the 5' end of each read
    (e.g. -5 CGACAGGTTCAGAGTTCTACAGTCCGACGATC)
-3  trim the given adapter sequence at the 3' end of each read
    (e.g. -3 TCGTATGCCGTCTTCTGCTTG)
-A  disable polyA/T trimming (enabled by default)
-B  trim polyA/T at both ends (default: only poly-A at 3' end, poly-T at 5')
-O  output only reads affected by trimming (discard clean reads!)
-y  minimum length of poly-A/T run to remove (6)
-q  trim read ends where the quality value drops below <minq>
-w  for -q, sliding window size for calculating avg. quality (default 6)
-t  for -q, limit maximum trimming at either end to <trim_max_len>
-m  maximum percentage of Ns allowed in a read after trimming (default 5)
-l  minimum read length after trimming (if the remaining sequence is shorter
    than this, the read will be discarded (trashed)(default: 16)
-r  write a "trimming report" file listing the affected reads with a list
    of trimming operations
-s1/-s2:  for paired reads, one of the reads (1 or 2) is not being processed
    (no attempt to trim it) but the pair is discarded if the other read is
    trashed by the trimming process
--aidx option can only be given with -r and -f options and it makes all the 
    vector/adapter trimming operations encoded as a,b,c,.. instead of V,
    corresponding to the order of adapter sequences in the -f file
-T  write the number of bases trimmed at 5' and 3' ends after the read names
    in the FASTA/FASTQ output file(s)
-D  pass reads through a low-complexity (dust) filter and discard any read
    that has over 50754161425f its length masked as low complexity
--dmask option is the same with -D but fqtrim will actually mask the low 
    complexity regions with Ns in the output sequence
-C  collapse duplicate reads and append a _x<N>count suffix to the read
    name (where <N> is the duplication count)
-p  use <numcpus> CPUs (threads) on the local machine
-P  input is phred64/phred33 (use -P64 or -P33)
-Q  convert quality values to the other Phred qv type
-M  disable read name consistency check for paired reads
-V  show verbose trimming summary
Advanced adapter/primer match options (for -f or -5 , -3 options):
  -a      minimum length of exact suffix-prefix match with adapter sequence that
          can be trimmed at either end of the read (default: 6)
  --pid5  minimum percent identity for adapter match at 5' end (default 96.0)
  --pid3  minimum percent identity for adapter match at 3' end (default 94.0)
  --mism  mismatch penalty for scoring the adapter alignment (default 3)
  --match match reward for scoring the adapter alignment (default 1)
  -R      also look for terminal alignments with the reverse complement
          of the adapter sequence(s)
```

