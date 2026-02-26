cwlVersion: v1.2
class: CommandLineTool
baseCommand: proda
label: proda
doc: "Aligning all pairs of sequences. This may take several minutes\n\nTool homepage:
  http://proda.stanford.edu/"
inputs:
  - id: minimal_block_length
    type:
      - 'null'
      - int
    doc: Minimal block length
    default: 30
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proda:1.0--hdbdd923_5
stdout: proda.out
