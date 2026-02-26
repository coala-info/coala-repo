# fqtk CWL Generation Report

## fqtk_demux

### Tool Description
Performs sample demultiplexing on FASTQs.

### Metadata
- **Docker Image**: quay.io/biocontainers/fqtk:0.3.1--ha6fb395_3
- **Homepage**: https://github.com/fulcrumgenomics/fqtk
- **Package**: https://anaconda.org/channels/bioconda/packages/fqtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fqtk/overview
- **Total Downloads**: 12.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/fulcrumgenomics/fqtk
- **Stars**: N/A
### Original Help Text
```text
Performs sample demultiplexing on FASTQs.

The sample barcode for each sample in the metadata TSV will be compared against the sample barcode bases extracted from the FASTQs, to assign each read to a sample.  Reads that do not match any sample within the given error tolerance will be placed in the ``unmatched_prefix`` file.

FASTQs and associated read structures for each sub-read should be given:

- a single fragment read (with inline index) should have one FASTQ and one read structure - paired end reads should have two FASTQs and two read structures - a dual-index sample with paired end reads should have four FASTQs and four read structures given: two for the two index reads, and two for the template reads.

If multiple FASTQs are present for each sub-read, then the FASTQs for each sub-read should be concatenated together prior to running this tool (e.g. `zcat s_R1_L001.fq.gz s_R1_L002.fq.gz | bgzip -c > s_R1.fq.gz`).

(Read structures)[<https://github.com/fulcrumgenomics/fgbio/wiki/Read-Structures>] are made up of `<number><operator>` pairs much like the `CIGAR` string in BAM files. Four kinds of operators are recognized:

1. `T` identifies a template read 2. `B` identifies a sample barcode read 3. `M` identifies a unique molecular index read 4. `S` identifies a set of bases that should be skipped or ignored

The last `<number><operator>` pair may be specified using a `+` sign instead of number to denote "all remaining bases". This is useful if, e.g., fastqs have been trimmed and contain reads of varying length. Both reads must have template bases.  Any molecular identifiers will be concatenated using the `-` delimiter and placed in the given SAM record tag (`RX` by default).  Similarly, the sample barcode bases from the given read will be placed in the `BC` tag.

Metadata about the samples should be given as a headered metadata TSV file with two columns 1. `sample_id` - the id of the sample or library. 2. `barcode` - the expected barcode sequence associated with the `sample_id`.

The read structures will be used to extract the observed sample barcode, template bases, and molecular identifiers from each read.  The observed sample barcode will be matched to the sample barcodes extracted from the bases in the sample metadata and associated read structures.

An observed barcode matches an expected barcocde if all the following are true: 1. The number of mismatches (edits/substitutions) is less than or equal to the maximum mismatches (see `--max-mismatches`). 2. The difference between number of mismatches in the best and second best barcodes is greater than or equal to the minimum mismatch delta (`--min-mismatch-delta`). The expected barcode sequence may contains Ns, which are not counted as mismatches regardless of the observed base (e.g. the expected barcode `AAN` will have zero mismatches relative to both the observed barcodes `AAA` and `AAN`).

## Outputs

All outputs are generated in the provided `--output` directory.  For each sample plus the unmatched reads, FASTQ files are written for each read segment (specified in the read structures) of one of the types supplied to `--output-types`.  FASTQ files have names of the format:

``` {sample_id}.{segment_type}{read_num}.fq.gz ```

where `segment_type` is one of `R`, `I`, and `U` (for template, barcode/index and molecular barcode/UMI reads respectively) and `read_num` is a number starting at 1 for each segment type.

In addition a `demux-metrics.txt` file is written that is a tab-delimited file with counts of how many reads were assigned to each sample and derived metrics.

## Example Command Line

As an example, if the sequencing run was 2x100bp (paired end) with two 8bp index reads both reading a sample barcode, as well as an in-line 8bp sample barcode in read one, the command line would be:

``` fqtk demux \ --inputs r1.fq.gz i1.fq.gz i2.fq.gz r2.fq.gz \ --read-structures 8B92T 8B 8B 100T \ --sample-metadata metadata.tsv \ --output output_folder ```

Usage: fqtk demux [OPTIONS] --inputs <INPUTS>... --read-structures <READ_STRUCTURES>... --sample-metadata <SAMPLE_METADATA> --output <OUTPUT>

Options:
  -i, --inputs <INPUTS>...
          One or more input fastq files each corresponding to a sequencing (e.g. R1, I1)

  -r, --read-structures <READ_STRUCTURES>...
          The read structures, one per input FASTQ in the same order

  -b, --output-types <OUTPUT_TYPES>...
          The read structure types to write to their own files (Must be one of T, B, or M for template reads, sample barcode reads, and molecular barcode reads).
          
          Multiple output types may be specified as a space-delimited list.
          
          [default: T]

  -s, --sample-metadata <SAMPLE_METADATA>
          A file containing the metadata about the samples

  -o, --output <OUTPUT>
          The output directory into which to write per-sample FASTQs

  -u, --unmatched-prefix <UNMATCHED_PREFIX>
          Output prefix for FASTQ file(s) for reads that cannot be matched to a sample
          
          [default: unmatched]

      --max-mismatches <MAX_MISMATCHES>
          Maximum mismatches for a barcode to be considered a match
          
          [default: 1]

  -d, --min-mismatch-delta <MIN_MISMATCH_DELTA>
          Minimum difference between number of mismatches in the best and second best barcodes for a barcode to be considered a match
          
          [default: 2]

  -t, --threads <THREADS>
          The number of threads to use. Cannot be less than 3
          
          [default: 8]

  -c, --compression-level <COMPRESSION_LEVEL>
          The level of compression to use to compress outputs
          
          [default: 5]

  -S, --skip-reasons <SKIP_REASONS>
          Skip demultiplexing reads for any of the following reasons, otherwise panic.
          
          1. `too-few-bases`: there are too few bases or qualities to extract given the read structures.  For example, if a read is 8bp long but the read structure is `10B`, or if a read is empty and the read structure is `+T`.

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

