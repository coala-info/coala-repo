# myloasm CWL Generation Report

## myloasm

### Tool Description
high-resolution metagenomic assembly with noisy long reads. See online documentation for full options.

### Metadata
- **Docker Image**: quay.io/biocontainers/myloasm:0.4.0--ha6fb395_0
- **Homepage**: https://github.com/bluenote-1577/myloasm
- **Package**: https://anaconda.org/channels/bioconda/packages/myloasm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/myloasm/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2026-01-29
- **GitHub**: https://github.com/bluenote-1577/myloasm
- **Stars**: N/A
### Original Help Text
```text
myloasm - high-resolution metagenomic assembly with noisy long reads. See online documentation for full options. 

EXAMPLE (Nanopore R10): myloasm nanopore_reads.fq.gz -o output_directory -t 50
EXAMPLE (PacBio HiFi): myloasm pacbio_reads.fq.gz -o output_directory -t 50 --hifi

Usage: myloasm [OPTIONS] <FASTQ/FASTA (.gz)>...

Arguments:
  <FASTQ/FASTA (.gz)>...  Input read file(s) -- multiple files are concatenated

Options:
  -o, --output-dir <OUTPUT_DIR>  Output directory for results; created if it does not exist [default: myloasm-out]
  -t, --threads <THREADS>        Number of threads to use for processing [default: 20]
      --clean-dir                Do not dump large intermediate data to disk (intermediate data is useful for rerunning)
  -l, --log-level <LOG_LEVEL>    Verbosity level. Warning: trace is very verbose [default: debug] [possible values: error, warn, info, debug, trace]
  -h, --help                     Print help
  -V, --version                  Print version

Technology Presets:
      --nano-r10  (DEFAULT) R10 nanopore mode for sup/hac data (> ~97% median accuracy). Specifying this flag does not do anything for now
      --hifi      PacBio HiFi mode -- assumes less chimericism and higher accuracy

Basic Algorithmic Parameters:
  -c, --c <C>
          Compression ratio (1/c k-mers selected). Must be <= 15 [default: 11]
      --quality-value-cutoff <QUALITY_VALUE_CUTOFF>
          Disallow reads with < % identity for graph building (estimated from base qualities) [default: 90]
      --min-ol <MIN_OL>
          Minimum overlap length for graph construction [default: 500]
  -b, --bloom-filter-size <BLOOM_FILTER_SIZE>
          Bloom filter size in GB. Increase for massive datasets if initial k-mer counting is a bottleneck (default: automatic estimation)
      --aggressive-bloom
          More aggressive filtering of low-abundance k-mers. May be non-deterministic
      --new-polish-trimming
          New mode: trim windows during polishing. Takes slightly longer, may incrementally improve polishing for some datasets

Output thresholds:
      --min-reads-contig <MIN_READS_CONTIG>
          Output contigs with >= this number of reads [default: 1]
      --singleton-coverage-threshold <SINGLETON_COVERAGE_THRESHOLD>
          Remove singleton contigs with <= this estimated coverage depth (DP1 coverage; 99% identity coverage) [default: 3]
      --secondary-coverage-threshold <SECONDARY_COVERAGE_THRESHOLD>
          Remove contigs with <= this estimated coverage depth and <= 2 reads (DP1 coverage; 99% identity coverage) [default: 1]
      --absolute-coverage-threshold <ABSOLUTE_COVERAGE_THRESHOLD>
          Remove all contigs with <= this estimated coverage depth (DP1 coverage; 99% identity coverage)
      --dereplication-ani <DEREPLICATION_ANI>
          Mark contigs with >= this average nucleotide identity (ANI) to a larger contig as alternate [default: 99]
      --dereplication-length <DEREPLICATION_LENGTH>
          Mark contigs with > 90% aligned, < this length, and >= --dereplication-ani as alternate [default: 500000]
```


## Metadata
- **Skill**: generated
