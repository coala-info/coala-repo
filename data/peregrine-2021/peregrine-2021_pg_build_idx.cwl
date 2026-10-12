cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_build_idx
label: peregrine-2021_pg_build_idx
doc: "Build the SHIMMER index from the reads for overlapping (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
inputs:
  - id: seqdb
    type: File
    doc: Path to the seqdb file
    inputBinding:
      position: 200
  - id: seqidx
    type: File
    doc: Path to the seqdb index file
    inputBinding:
      position: 201
  - id: shmr_index_prefix
    type: string
    doc: The prefix to the output shimmer index database
    inputBinding:
      position: 202
  - id: nthreads
    type: int
    doc: Number of threads
    inputBinding:
      position: 203
  - id: nchunks
    type: int
    doc: Number of partition
    inputBinding:
      position: 204
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size (default 56)
    inputBinding:
      position: 110
      prefix: -k
  - id: reduction_factor
    type:
      - 'null'
      - int
    doc: Reduction factor (default 6)
    inputBinding:
      position: 110
      prefix: -r
  - id: window_size
    type:
      - 'null'
      - int
    doc: Window size (default 80)
    inputBinding:
      position: 110
      prefix: -w
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: shimmer_index
    type:
      type: array
      items: File
    doc: Shimmer index files
    outputBinding:
      glob: $(inputs.shmr_index_prefix)-*.dat
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
