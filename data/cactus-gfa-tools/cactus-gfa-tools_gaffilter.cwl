cwlVersion: v1.2
class: CommandLineTool
baseCommand: gaffilter
label: cactus-gfa-tools_gaffilter
doc: "Filter GAF record if its query interval overlaps another query interval based
  on primary/secondary status, MAPQ ratio, or block length ratio.\n\nTool homepage:
  https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools"
inputs:
  - id: input_gaf
    type: File
    doc: Input GAF (or PAF if -p is used) file
    inputBinding:
      position: 1
  - id: min_block_length
    type:
      - 'null'
      - int
    doc: Don't let an interval with block length < N cause something to be filtered
      out
    inputBinding:
      position: 102
      prefix: --min-block-length
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Don't let an interval with identity < N cause something to be filtered out
    inputBinding:
      position: 102
      prefix: --min-identity
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Don't let an interval with MAPQ < N cause something to be filtered out
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: min_overlap
    type:
      - 'null'
      - float
    doc: Ignore overlaps that constitute <N% of the length
    inputBinding:
      position: 102
      prefix: --min-overlap
  - id: min_overlap_length
    type:
      - 'null'
      - int
    doc: If >= 2 query regions with size >= N overlap, ignore the query region. If
      1 query region with size >= N overlaps any regions of size <= N, ignore the
      smaller ones only. Works separate to -r/-m but can be used in conjunction with
      them to combine the two filters (0 = disable)
    inputBinding:
      position: 102
      prefix: --min-overlap-length
  - id: paf
    type:
      - 'null'
      - boolean
    doc: Input is PAF, not GAF
    inputBinding:
      position: 102
      prefix: --paf
  - id: ratio
    type:
      - 'null'
      - float
    doc: If two query blocks overlap, and one is Nx bigger than the other, the bigger
      one is kept (otherwise both deleted)
    inputBinding:
      position: 102
      prefix: --ratio
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
stdout: cactus-gfa-tools_gaffilter.out
