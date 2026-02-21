cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - resolve
label: bamtools_resolve
doc: "resolves paired-end reads (marking the IsProperPair flag as needed).\n\nTool
  homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: confidence_interval
    type:
      - 'null'
      - float
    doc: confidence interval. Set min/max fragment lengths such that we capture this
      fraction of pairs
    inputBinding:
      position: 101
      prefix: -ci
  - id: force
    type:
      - 'null'
      - boolean
    doc: forces all read groups to be marked according to their top 2 'orientation
      models', ignoring the ambiguity flag.
    inputBinding:
      position: 101
      prefix: -force
  - id: force_compression
    type:
      - 'null'
      - boolean
    doc: if results are sent to stdout, default behavior is to leave output uncompressed.
      Use this flag to override and force compression. This feature is disabled in
      -makeStats mode.
    inputBinding:
      position: 101
      prefix: -forceCompression
  - id: input_bam
    type:
      - 'null'
      - File
    doc: the input BAM file(s) [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: make_stats
    type:
      - 'null'
      - boolean
    doc: generates a fragment-length stats file from the input BAM. Data is written
      to file specified using the -stats option. MarkPairs Mode Settings are DISABLED.
    inputBinding:
      position: 101
      prefix: -makeStats
  - id: mark_pairs
    type:
      - 'null'
      - boolean
    doc: generates an output BAM with alignments marked with proper-pair status. Stats
      data is read from file specified using the -stats option. MakeStats Mode Settings
      are DISABLED
    inputBinding:
      position: 101
      prefix: -markPairs
  - id: min_mq
    type:
      - 'null'
      - int
    doc: minimum map quality. Used in -makeStats mode as a heuristic for determining
      a mate's uniqueness. Used in -markPairs mode as a filter for marking candidate
      proper pairs.
    inputBinding:
      position: 101
      prefix: -minMQ
  - id: stats_file
    type:
      - 'null'
      - File
    doc: input/output stats file, depending on selected mode. This file is human-readable,
      storing fragment length data generated per read group, as well as the options
      used to configure the -makeStats mode
    inputBinding:
      position: 101
      prefix: -stats
  - id: two_pass
    type:
      - 'null'
      - boolean
    doc: combines the -makeStats & -markPairs modes into a single command. Piping
      BAM data via stdin is DISABLED.
    inputBinding:
      position: 101
      prefix: -twoPass
  - id: unused_model_threshold
    type:
      - 'null'
      - float
    doc: unused model threshold. This value determines the cutoff for marking a read
      group as ambiguous.
    inputBinding:
      position: 101
      prefix: -umt
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: the output BAM file [stdout]
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
