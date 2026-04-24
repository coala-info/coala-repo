cwlVersion: v1.2
class: CommandLineTool
baseCommand: raw
label: scrappie_raw
doc: "Scrappie basecaller -- basecall from raw signal\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fast5_files
    type:
      type: array
      items: File
    doc: Input FAST5 files
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: Format to output reads (FASTA or SAM)
    inputBinding:
      position: 102
      prefix: --format
  - id: hdf5_chunk
    type:
      - 'null'
      - string
    doc: Chunk size for HDF5 output
    inputBinding:
      position: 102
      prefix: --hdf5-chunk
  - id: hdf5_compression
    type:
      - 'null'
      - int
    doc: 'Gzip compression level for HDF5 output (0:off, 1: quickest, 9: best)'
    inputBinding:
      position: 102
      prefix: --hdf5-compression
  - id: homopolymer
    type:
      - 'null'
      - string
    doc: 'Homopolymer run calc. to use: choose from "nochange" or "mean" (default).
      Not implemented for CRF.'
    inputBinding:
      position: 102
      prefix: --homopolymer
  - id: licence
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --licence
  - id: license
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --license
  - id: limit
    type:
      - 'null'
      - int
    doc: Maximum number of reads to call (0 is unlimited)
    inputBinding:
      position: 102
      prefix: --limit
  - id: local
    type:
      - 'null'
      - string
    doc: Penalty for local basecalling
    inputBinding:
      position: 102
      prefix: --local
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum bound on probability of match
    inputBinding:
      position: 102
      prefix: --min_prob
  - id: model
    type:
      - 'null'
      - string
    doc: 'Raw model to use: "raw_r94", "rgrgr_r94", "rgrgr_r941", "rgrgr_r10", "rnnrf_r94"'
    inputBinding:
      position: 102
      prefix: --model
  - id: no_slip
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-slip
  - id: no_uuid
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --no-uuid
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to append to name of each read
    inputBinding:
      position: 102
      prefix: --prefix
  - id: segmentation
    type:
      - 'null'
      - string
    doc: Chunk size and percentile for variance based segmentation
    inputBinding:
      position: 102
      prefix: --segmentation
  - id: skip
    type:
      - 'null'
      - string
    doc: Penalty for skipping a base
    inputBinding:
      position: 102
      prefix: --skip
  - id: slip
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --slip
  - id: stay
    type:
      - 'null'
      - string
    doc: Penalty for staying
    inputBinding:
      position: 102
      prefix: --stay
  - id: temperature1
    type:
      - 'null'
      - float
    doc: Temperature for softmax weights
    inputBinding:
      position: 102
      prefix: --temperature1
  - id: temperature2
    type:
      - 'null'
      - float
    doc: Temperature for softmax bias
    inputBinding:
      position: 102
      prefix: --temperature2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of reads to call in parallel
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - string
    doc: Number of samples to trim, as start:end
    inputBinding:
      position: 102
      prefix: --trim
  - id: uuid
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --uuid
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write to file rather than stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
