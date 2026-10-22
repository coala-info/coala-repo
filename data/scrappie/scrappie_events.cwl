cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scrappie, events]
label: scrappie_events
doc: "Scrappie basecaller -- basecall via events\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fast5_files
    type:
      type: array
      items: File
    doc: "Input fast5 files"
    inputBinding:
      position: 200
  - id: threads
    type: ['null', int]
    doc: "Number of reads to call in parallel"
    inputBinding:
      prefix: --threads
  - id: dump
    type: ['null', string]
    doc: "Dump annotated events to HDF5 file"
    inputBinding:
      prefix: --dump
  - id: dwell
    type: ['null', boolean]
    doc: "Perform dwell correction of homopolymer lengths"
    inputBinding:
      prefix: --dwell
  - id: no_dwell
    type: ['null', boolean]
    doc: "Do not perform dwell correction"
    inputBinding:
      prefix: --no-dwell
  - id: format
    type: ['null', string]
    doc: "Format to output reads (FASTA or SAM)"
    inputBinding:
      prefix: --format
  - id: hdf5_chunk
    type: ['null', int]
    doc: "Chunk size for HDF5 output"
    inputBinding:
      prefix: --hdf5-chunk
  - id: hdf5_compression
    type: ['null', int]
    doc: "Gzip compression level for HDF5 output (0:off, 1: quickest, 9: best)"
    inputBinding:
      prefix: --hdf5-compression
  - id: local
    type: ['null', double]
    doc: "Penalty for local basecalling"
    inputBinding:
      prefix: --local
  - id: limit
    type: ['null', int]
    doc: "Maximum number of reads to call (0 is unlimited)"
    inputBinding:
      prefix: --limit
  - id: min_prob
    type: ['null', double]
    doc: "Minimum bound on probability of match"
    inputBinding:
      prefix: --min_prob
  - id: output
    type: ['null', string]
    doc: "Write to file rather than stdout"
    inputBinding:
      prefix: --output
  - id: prefix
    type: ['null', string]
    doc: "Prefix to append to name of each read"
    inputBinding:
      prefix: --prefix
  - id: segmentation
    type: ['null', string]
    doc: "Chunk size and percentile for variance based segmentation (chunk:percentile)"
    inputBinding:
      prefix: --segmentation
  - id: slip
    type: ['null', boolean]
    doc: "Use slipping"
    inputBinding:
      prefix: --slip
  - id: no_slip
    type: ['null', boolean]
    doc: "Do not use slipping"
    inputBinding:
      prefix: --no-slip
  - id: skip
    type: ['null', double]
    doc: "Penalty for skipping a base"
    inputBinding:
      prefix: --skip
  - id: temperature1
    type: ['null', double]
    doc: "Temperature for softmax weights"
    inputBinding:
      prefix: --temperature1
  - id: temperature2
    type: ['null', double]
    doc: "Temperature for softmax bias"
    inputBinding:
      prefix: --temperature2
  - id: trim
    type: ['null', string]
    doc: "Number of events to trim, as start:end"
    inputBinding:
      prefix: --trim
  - id: uuid
    type: ['null', boolean]
    doc: "Output UUID"
    inputBinding:
      prefix: --uuid
  - id: no_uuid
    type: ['null', boolean]
    doc: "Do not output UUID"
    inputBinding:
      prefix: --no-uuid
  - id: stay
    type: ['null', double]
    doc: "Penalty for staying"
    inputBinding:
      prefix: --stay
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (used when --output is not set)
  - id: output_file
    type: ['null', File]
    doc: Output file written with --output
    outputBinding:
      glob: $(inputs.output)
  - id: dump_file
    type: ['null', File]
    doc: Annotated events written with --dump
    outputBinding:
      glob: $(inputs.dump)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
stdout: scrappie_events.out
