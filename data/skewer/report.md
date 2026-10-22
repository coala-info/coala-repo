# skewer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| skewer | Failed | image problem: --compress silently writes empty output files because the image's busybox gzip has no --rsyncable; plain trimming of real paired reads is correct. |

## skewer

### Tool Description
Skewer is a fast and accurate adapter trimmer for single-end and paired-end NGS reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/skewer:0.2.2--h2d50403_2
- **Homepage**: https://github.com/relipmoc/skewer
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/skewer/overview
- **Total Downloads**: 27.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/relipmoc/skewer
- **Stars**: N/A
### Original Help Text
```text
Skewer (A fast and accurate adapter trimmer for paired-end reads)
Version 0.2.2 (updated in April 4, 2016), Author: Hongshan Jiang

USAGE: skewer [options] <reads.fastq> [paired-reads.fastq]
    or skewer [options] - (for input from STDIN)

OPTIONS (ranges in brackets, defaults in parentheses):
 Adapter:
          -x <str> Adapter sequence/file (AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC)
          -y <str> Adapter sequence/file for pair-end reads (AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTA),
                   implied by -x if -x is the only one specified explicitly.
          -M, --matrix <str> File indicates valid adapter pairing (all-ones matrix).
          -j <str> Junction adapter sequence/file for Nextera Mate Pair reads (CTGTCTCTTATACACATCTAGATGTGTATAAGAGACAG)
          -m, --mode <str> trimming mode; 1) single-end -- head: 5' end; tail: 3' end; any: anywhere (tail)
                           2) paired-end -- pe: paired-end; mp: mate-pair; ap: amplicon (pe)
          -b, --barcode    Demultiplex reads according to adapters/primers (no)
 Tolerance:
          -r <num> Maximum allowed error rate (normalized #errors / length of aligned region) [0, 0.5], (0.1)
          -d <num> Maximum allowed indel error rate [0, r], (0.03)
                   reciprocal is used for -r, -e and -d when num > or = 2
          -k <int> Minimum overlap length for adapter detection [1, inf);
                   (max(1, int(4-10*r)) for single-end; (<junction length>/2) for mate-pair)
 Clipping:
          -c, --cut <int>,<int> Hard clip off the 5' leading bases as the barcodes in amplicon mode; (no)
          -e, --cut3            Hard clip off the 3' tailing bases if the read length is greater than
                                the maximum read length specified by -L; (no)
 Filtering:
          -q, --end-quality  <int> Trim 3' end until specified or higher quality reached; (0)
          -Q, --mean-quality <int> The lowest mean quality value allowed before trimming; (0)
          -l, --min <int> The minimum read length allowed after trimming; (18)
          -L, --max <int> The maximum read length allowed after trimming; (no limit)
          -n  Whether to filter out highly degenerative (many Ns) reads; (no)
          -u  Whether to filter out undetermined mate-pair reads; (no)
          -N, --fillNs Whether to replace trimmed bases with Ns (has no effect with 'b' or '-m mp'); (no)
 Input/Output:
          -f, --format <str>   Format of FASTQ quality value: sanger|solexa|auto; (auto)
          -o, --output <str>   Base name of output file; ('<reads>.trimmed')
          -z, --compress       Compress output in GZIP format (no)
          -1, --stdout         Redirect output to STDOUT, suppressing -b, -o, and -z options (no)
          --qiime              Prepare the "barcodes.fastq" and "mapping_file.txt" for processing with QIIME; (default: no)
          --quiet              No progress update (not quiet)
          -A, --masked-output  Write output file(s) for trimmed reads (trimmed bases converted to lower case) (no)
          -X, --excluded-output Write output file(s) for excluded reads (no)
 Miscellaneous:
          -i, --intelligent     For mate-pair mode, whether to redistribute reads based on junction information; (no)
          -t, --threads <int>   Number of concurrent threads [1, 32]; (1)

EXAMPLES:
          skewer -Q 9 -t 2 -x adapters.fa sample.fastq -o trimmed
          skewer -x AGATCGGAAGAGC -q 3 sample-pair1.fq.gz sample-pair2.fq.gz
          skewer -x TCGTATGCCGTCTTCTGCTTGT -l 16 -L 30 -d 0 srna.fastq
          skewer -m mp -i lmp-pair1.fastq lmp-pair2.fastq
          skewer -m ap --cut 0,6 --qiime -x forward-primers.fa -y reverse-primers.fa mix-pair1.fastq mix-pair2.fastq
```

