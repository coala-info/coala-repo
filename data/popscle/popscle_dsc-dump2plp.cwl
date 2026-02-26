cwlVersion: v1.2
class: CommandLineTool
baseCommand: popscle_dsc-dump2plp
label: popscle_dsc-dump2plp
doc: "Produce a pileup from a dump of dsc-RNAseq\n\nTool homepage: https://github.com/statgen/popscle"
inputs:
  - id: chunk_id
    type:
      - 'null'
      - int
    doc: Chunk ID to focus on. By default, it runs across all chunks
    default: -1
    inputBinding:
      position: 101
      prefix: --chunk-id
  - id: in
    type: string
    doc: Input prefix from cramore/popscle dsc-dump
    inputBinding:
      position: 101
      prefix: --in
  - id: out
    type: string
    doc: Output prefix compatible with cramore/popscle dsc-pileup
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popscle:0.1--ha0d7e29_1
stdout: popscle_dsc-dump2plp.out
