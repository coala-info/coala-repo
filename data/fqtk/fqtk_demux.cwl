cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtk_demux
label: fqtk_demux
doc: "Performs sample demultiplexing on FASTQs.\n\nTool homepage: https://github.com/fulcrumgenomics/fqtk"
inputs:
  - id: compression_level
    type:
      - 'null'
      - int
    doc: The level of compression to use to compress outputs
    inputBinding:
      position: 101
      prefix: --compression-level
  - id: inputs
    type:
      type: array
      items: File
    doc: One or more input fastq files each corresponding to a sequencing (e.g. 
      R1, I1)
    inputBinding:
      position: 101
      prefix: --inputs
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum mismatches for a barcode to be considered a match
    inputBinding:
      position: 101
      prefix: --max-mismatches
  - id: min_mismatch_delta
    type:
      - 'null'
      - int
    doc: Minimum difference between number of mismatches in the best and second 
      best barcodes for a barcode to be considered a match
    inputBinding:
      position: 101
      prefix: --min-mismatch-delta
  - id: output_types
    type:
      - 'null'
      - type: array
        items: string
    doc: "The read structure types to write to their own files (Must be one of T,
      B, or M for template reads, sample barcode reads, and molecular barcode reads).\n\
      \          \n          Multiple output types may be specified as a space-delimited
      list."
    inputBinding:
      position: 101
      prefix: --output-types
  - id: read_structures
    type:
      type: array
      items: string
    doc: The read structures, one per input FASTQ in the same order
    inputBinding:
      position: 101
      prefix: --read-structures
  - id: sample_metadata
    type: File
    doc: A file containing the metadata about the samples
    inputBinding:
      position: 101
      prefix: --sample-metadata
  - id: skip_reasons
    type:
      - 'null'
      - type: array
        items: string
    doc: "Skip demultiplexing reads for any of the following reasons, otherwise panic.\n\
      \          \n          1. `too-few-bases`: there are too few bases or qualities
      to extract given the read structures.  For example, if a read is 8bp long but
      the read structure is `10B`, or if a read is empty and the read structure is
      `+T`."
    inputBinding:
      position: 101
      prefix: --skip-reasons
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use. Cannot be less than 3
    inputBinding:
      position: 101
      prefix: --threads
  - id: unmatched_prefix
    type:
      - 'null'
      - string
    doc: Output prefix for FASTQ file(s) for reads that cannot be matched to a 
      sample
    inputBinding:
      position: 101
      prefix: --unmatched-prefix
outputs:
  - id: output
    type: Directory
    doc: The output directory into which to write per-sample FASTQs
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtk:0.3.1--ha6fb395_3
