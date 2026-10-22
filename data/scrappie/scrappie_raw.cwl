cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scrappie, raw]
label: scrappie_raw
doc: "Scrappie basecaller -- basecall from raw signal\n\nTool homepage: https://github.com/nanoporetech/scrappie"
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
  - id: homopolymer
    type: ['null', string]
    doc: "Homopolymer run calc. to use: choose from \"nochange\" or \"mean\" (default). Not implemented for CRF."
    inputBinding:
      prefix: --homopolymer
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
  - id: model
    type: ['null', string]
    doc: "Raw model to use: \"raw_r94\", \"rgrgr_r94\", \"rgrgr_r941\", \"rgrgr_r10\", \"rnnrf_r94\""
    inputBinding:
      prefix: --model
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
    doc: "Number of samples to trim, as start:end"
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
stdout: scrappie_raw.out
