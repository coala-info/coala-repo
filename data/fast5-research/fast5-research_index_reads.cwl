cwlVersion: v1.2
class: CommandLineTool
baseCommand: index_reads
label: fast5-research_index_reads
doc: "Build index of reads within .fast5s. Output to stdout.\n\nTool homepage: https://github.com/nanoporetech/fast5_research"
inputs:
  - id: input
    type: Directory
    doc: .fast5 directory
    inputBinding:
      position: 101
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search recursively under `input` for source files.
    inputBinding:
      position: 1
      prefix: --recursive
  - id: workers
    type:
      - 'null'
      - int
    doc: Number of worker processes.
    inputBinding:
      position: 1
      prefix: --workers
outputs:
  - id: read_index
    type: stdout
    doc: Tab separated table of read id and fast5 file path.
stdout: fast5-research_index_reads.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast5-research:1.2.22--pyh864c0ab_0
