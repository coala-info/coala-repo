cwlVersion: v1.2
class: CommandLineTool
baseCommand: pg_ovlp
label: peregrine-2021_pg_ovlp
doc: "Generate haplotype specific overlaps between the reads (Peregrine-2021 assembler stage).\n\nTool homepage: https://github.com/cschin/peregrine-2021"
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
  - id: out_prefix
    type: string
    doc: The prefix of the output ovelap files
    inputBinding:
      position: 203
  - id: nthreads
    type: int
    doc: Number of threads
    inputBinding:
      position: 204
  - id: nchunks
    type: int
    doc: Number of partition
    inputBinding:
      position: 205
  - id: shimmer_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Shimmer index files made by pg_build_idx; they are staged in the working directory so the prefix resolves.
  - id: tol
    type:
      - 'null'
      - float
    doc: Alignment tolerance (default 0.01)
    inputBinding:
      position: 110
      prefix: --tol
  - id: log
    type:
      - 'null'
      - string
    doc: "log level: DBBUG or INFO (default)"
    inputBinding:
      position: 110
      prefix: --log
outputs:
  - id: overlaps
    type:
      type: array
      items: File
    doc: Overlap files
    outputBinding:
      glob: $(inputs.out_prefix).*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.shimmer_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peregrine-2021:0.4.13--ha6fb395_6
