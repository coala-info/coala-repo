cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler coarsen
label: cooler_coarsen
doc: "Coarsen a cooler to a lower resolution.\n\nWorks by pooling *k*-by-*k* neighborhoods
  of pixels and aggregating. Each\nchromosomal block is coarsened individually.\n\n\
  Tool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_path
    type: string
    doc: Path to a COOL file or Cooler URI.
    inputBinding:
      position: 1
  - id: append
    type:
      - 'null'
      - boolean
    doc: "Pass this flag to append the output cooler to an\n                     \
      \      existing file instead of overwriting the file."
    inputBinding:
      position: 102
      prefix: --append
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Number of pixels allocated to each process
    inputBinding:
      position: 102
      prefix: --chunksize
  - id: factor
    type:
      - 'null'
      - int
    doc: "Gridding factor. The contact matrix is\n                           coarsegrained
      by grouping each chromosomal contact\n                           block into
      k-by-k element tiles"
    inputBinding:
      position: 102
      prefix: --factor
  - id: field
    type:
      - 'null'
      - type: array
        items: string
    doc: "Specify the names of value columns to merge as\n                       \
      \    '<name>'. Repeat the `--field` option for each one.\n                 \
      \          Use '<name>,dtype=<dtype>' to specify the dtype.\n              \
      \             Include ',agg=<agg>' to specify an aggregation\n             \
      \              function different from 'sum'."
    inputBinding:
      position: 102
      prefix: --field
  - id: nproc
    type:
      - 'null'
      - int
    doc: "Number of processes to use for batch processing\n                      \
      \     chunks of pixels"
    inputBinding:
      position: 102
      prefix: --nproc
outputs:
  - id: out
    type: File
    doc: Output file or URI
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
