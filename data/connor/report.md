# connor CWL Generation Report

## connor

### Tool Description
Deduplicates BAM file based on custom inline DNA barcodes. Emits a new BAM file reduced to a single consensus read for each family of original reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/connor:0.6.1--py_0
- **Homepage**: https://github.com/umich-brcf-bioinf/Connor
- **Package**: https://anaconda.org/channels/bioconda/packages/connor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/connor/overview
- **Total Downloads**: 17.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/umich-brcf-bioinf/Connor
- **Stars**: N/A
### Original Help Text
```text
usage: connor input_bam output_bam

Deduplicates BAM file based on custom inline DNA barcodes.
Emits a new BAM file reduced to a single consensus read for each family of
original reads.

positional arguments:
  input_bam             path to input BAM
  output_bam            path to deduplicated output BAM

optional arguments:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -v, --verbose         print all log messages to console
  --force               =False. Override validation warnings
  --log_file LOG_FILE   ={output_filename}.log. Path to verbose log file
  --annotated_output_bam ANNOTATED_OUTPUT_BAM
                        path to output BAM containing all original aligns annotated with BAM tags
  -f CONSENSUS_FREQ_THRESHOLD, --consensus_freq_threshold CONSENSUS_FREQ_THRESHOLD
                        =0.6 (0..1.0): Ambiguous base calls at a specific position in a family are
                         transformed to either majority base call, or N if the majority percentage
                         is below this threshold. (Higher threshold results in more Ns in
                         consensus.)
  -s MIN_FAMILY_SIZE_THRESHOLD, --min_family_size_threshold MIN_FAMILY_SIZE_THRESHOLD
                        =3 (>=0): families with count of original reads < threshold are excluded
                         from the deduplicated output. (Higher threshold is more
                         stringent.)
  -d UMT_DISTANCE_THRESHOLD, --umt_distance_threshold UMT_DISTANCE_THRESHOLD
                        =1 (>=0); UMTs equal to or closer than this Hamming distance will be
                         combined into a single family. Lower threshold make more families with more
                         consistent UMTs; 0 implies UMI must match
                         exactly.
  --filter_order {count,name}
                        =count; determines how filters will be ordered in the log
                         results
  --umt_length UMT_LENGTH
                        =6 (>=1); length of UMT

v0.6.1
```

