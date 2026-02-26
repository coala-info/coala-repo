# oarfish CWL Generation Report

## oarfish

### Tool Description
A fast, accurate and versatile tool for long-read transcript quantification.

### Metadata
- **Docker Image**: quay.io/biocontainers/oarfish:0.9.3--h5ca1c30_0
- **Homepage**: https://github.com/COMBINE-lab/oarfish
- **Package**: https://anaconda.org/channels/bioconda/packages/oarfish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oarfish/overview
- **Total Downloads**: 14.0K
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/COMBINE-lab/oarfish
- **Stars**: N/A
### Original Help Text
```text
A fast, accurate and versatile tool for long-read transcript quantification.

Usage: oarfish [OPTIONS] <--alignments <ALIGNMENTS>|--reads <READS>|--only-index>

Options:
      --quiet
          be quiet (i.e. don't output log messages that aren't at least warnings)
      --verbose
          be verbose (i.e. output all non-developer logging messages)
  -o, --output <OUTPUT>
          location where output quantification file should be written
      --single-cell
          input is assumed to be a single-cell BAM and to have the `CB:z` tag for all read records
  -j, --threads <THREADS>
          number of cores that oarfish will use during different phases of quantification. Note: This value will be at least 2 for bulk quantification and at least 3 for single-cell quantification due to the use of dedicated parsing threads [default: 3]
      --num-bootstraps <NUM_BOOTSTRAPS>
          number of bootstrap replicates to produce to assess quantification uncertainty [default: 0]
  -h, --help
          Print help
  -V, --version
          Print version

alignment mode:
  -a, --alignments <ALIGNMENTS>  path to the file containing the input alignments

raw read mode:
      --reads <READS>
          path to the file containing the input reads; these can be in FASTA/Q format (possibly gzipped), or provided in uBAM (unaligned BAM) format. The format will be inferred from the file suffixes, and if a format cannot be inferred, it will be assumed to be (possibly gzipped) FASTA/Q
      --annotated <ANNOTATED>
          path to the file containing the annotated transcriptome (e.g. GENCODE) against which to map
      --novel <NOVEL>
          path to the file containing novel (de novo, or reference-guided assembled) transcripts against which to map. These are ultimately indexed together with reference transcripts, but passed in separately for the purposes of provenance tracking
      --index <INDEX>
          path to an existing minimap2 index (either created with oarfish, which is preferred, or with minimap2 itself)
      --seq-tech <SEQ_TECH>
          sequencing technology in which to expect reads if using mapping based mode [possible values: ont-cdna, ont-drna, pac-bio, pac-bio-hifi]
      --best-n <BEST_N>
          maximum number of secondary mappings to consider when mapping reads to the transcriptome [default: 100]
      --thread-buff-size <THREAD_BUFF_SIZE>
          total memory to allow for thread-local alignment buffers (each buffer will get this value / # of alignment threads) [default: 1GB]

indexing:
      --only-index             If this flag is passed, oarfish only performs indexing and not quantification. Designed primarily for workflow management systems. Note: A prebuilt index is not needed to quantify with oarfish; an index can be written concurrently with quantification using the `--index-out` parameter
      --index-out <INDEX_OUT>  path where minimap2 index will be written (if provided)

filters:
      --filter-group <FILTER_GROUP>
          [possible values: no-filters, nanocount-filters]
  -t, --three-prime-clip <THREE_PRIME_CLIP>
          maximum allowable distance of the right-most end of an alignment from the 3' transcript end [default: *4294967295]
  -f, --five-prime-clip <FIVE_PRIME_CLIP>
          maximum allowable distance of the left-most end of an alignment from the 5' transcript end [default: *4294967295]
  -s, --score-threshold <SCORE_THRESHOLD>
          fraction of the best possible alignment score that a secondary alignment must have for consideration [default: *0.95]
  -m, --min-aligned-fraction <MIN_ALIGNED_FRACTION>
          fraction of a query that must be mapped within an alignemnt to consider the alignemnt valid [default: *0.5]
  -l, --min-aligned-len <MIN_ALIGNED_LEN>
          minimum number of nucleotides in the aligned portion of a read [default: *50]
  -d, --strand-filter <STRAND_FILTER>
          only alignments to this strand will be allowed; options are (fw /+, rc/-, or both/.) [default: .]

coverage model:
      --model-coverage             apply the coverage model
  -k, --growth-rate <GROWTH_RATE>  if using the coverage model, use this as the value of `k` in the logistic equation [default: 2]
  -b, --bin-width <BIN_WIDTH>      width of the bins used in the coverage model [default: 100]

output read-txps probabilities:
      --write-assignment-probs[=<WRITE_ASSIGNMENT_PROBS>]
          write output alignment probabilites (optionally compressed) for each mapped read. If <WRITE_ASSIGNMENT_PROBS> is present, it must be one of `uncompressed` (default) or `compressed`, which will cause the output file to be lz4 compressed
      --display-thresh <DISPLAY_THRESH>
          minimum posterior probability threshold for a read-transcript assignment to be written to the .prob file. Accepts a float value between 0.0 and 1.0, or the sentinel value 'none' to use the minimum machine precision (f64::MIN_POSITIVE) [default: 0.000001]

EM:
      --max-em-iter <MAX_EM_ITER>
          maximum number of iterations for which to run the EM algorithm [default: 1000]
      --convergence-thresh <CONVERGENCE_THRESH>
          maximum number of iterations for which to run the EM algorithm [default: 0.001]
  -q, --short-quant <SHORT_QUANT>
          location of short read quantification (if provided)
```

