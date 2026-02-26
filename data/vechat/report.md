# vechat CWL Generation Report

## vechat

### Tool Description
Haplotype-aware Error Correction for Noisy Long Reads Using Variation Graphs

### Metadata
- **Docker Image**: quay.io/biocontainers/vechat:1.1.1--hdcf5f25_1
- **Homepage**: https://github.com/HaploKit/vechat
- **Package**: https://anaconda.org/channels/bioconda/packages/vechat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vechat/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HaploKit/vechat
- **Stars**: N/A
### Original Help Text
```text
usage: vechat [-h] [-o OUTFILE] [--platform PLATFORM] [--split]
              [--split-size SPLIT_SIZE] [--scrub] [-u] [--base]
              [--min-identity MIN_IDENTITY] [--linear] [-d MIN_CONFIDENCE]
              [-s MIN_SUPPORT] [--min-ovlplen-cns MIN_OVLPLEN_CNS]
              [--min-identity-cns MIN_IDENTITY_CNS] [-w WINDOW_LENGTH]
              [-q QUALITY_THRESHOLD] [-e ERROR_THRESHOLD] [-t THREADS]
              [-m MATCH] [-x MISMATCH] [-g GAP]
              [--cudaaligner-batches CUDAALIGNER_BATCHES] [-c CUDAPOA_BATCHES]
              [-b]
              sequences

Haplotype-aware Error Correction for Noisy Long Reads Using Variation Graphs

positional arguments:
  sequences             input file in FASTA/FASTQ format (can be compressed
                        with gzip) containing sequences used for correction

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        output file (default: reads.corrected.fa)
  --platform PLATFORM   sequencing platform: pb/ont (default: pb)
  --split               split target sequences into chunks (recommend for
                        FASTQ > 20G or FASTA > 10G) (default: False)
  --split-size SPLIT_SIZE
                        split target sequences into chunks of desired size in
                        lines, only valid when using --split (default:
                        1000000)
  --scrub               scrub chimeric reads (default: False)
  -u, --include-unpolished
                        output unpolished target sequences (default: False)
  --base                perform base level alignment when computing read
                        overlaps in the first iteration (default: False)
  --min-identity MIN_IDENTITY
                        minimum identity used for filtering overlaps, only
                        works combined with --base (default: 0.8)
  --linear              perform linear based fragment correction rather than
                        variation graph based fragment correction (default:
                        False)
  -d MIN_CONFIDENCE, --min-confidence MIN_CONFIDENCE
                        minimum confidence for keeping edges in the graph
                        (default: 0.2)
  -s MIN_SUPPORT, --min-support MIN_SUPPORT
                        minimum support for keeping edges in the graph
                        (default: 0.2)
  --min-ovlplen-cns MIN_OVLPLEN_CNS
                        minimum read overlap length in the consensus round
                        (default: 1000)
  --min-identity-cns MIN_IDENTITY_CNS
                        minimum sequence identity between read overlaps in the
                        consensus round (default: 0.99)
  -w WINDOW_LENGTH, --window-length WINDOW_LENGTH
                        size of window on which POA is performed (default:
                        500)
  -q QUALITY_THRESHOLD, --quality-threshold QUALITY_THRESHOLD
                        threshold for average base quality of windows used in
                        POA (default: 10.0)
  -e ERROR_THRESHOLD, --error-threshold ERROR_THRESHOLD
                        maximum allowed error rate used for filtering overlaps
                        (default: 0.3)
  -t THREADS, --threads THREADS
                        number of threads (default: 1)
  -m MATCH, --match MATCH
                        score for matching bases (default: 5)
  -x MISMATCH, --mismatch MISMATCH
                        score for mismatching bases (default: -4)
  -g GAP, --gap GAP     gap penalty (must be negative) (default: -8)
  --cudaaligner-batches CUDAALIGNER_BATCHES
                        number of batches for CUDA accelerated alignment
                        (default: 0)
  -c CUDAPOA_BATCHES, --cudapoa-batches CUDAPOA_BATCHES
                        number of batches for CUDA accelerated polishing
                        (default: 0)
  -b, --cuda-banded-alignment
                        use banding approximation for polishing on GPU. Only
                        applicable when -c is used. (default: False)
```

