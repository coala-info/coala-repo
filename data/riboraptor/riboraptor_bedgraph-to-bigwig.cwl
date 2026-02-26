cwlVersion: v1.2
class: CommandLineTool
baseCommand: riboraptor bedgraph-to-bigwig
label: riboraptor_bedgraph-to-bigwig
doc: "Convert bedgraph to bigwig\n\nTool homepage: https://github.com/saketkc/riboraptor"
inputs:
  - id: bedgraph
    type:
      - 'null'
      - File
    doc: Path to bedgraph file
    inputBinding:
      position: 101
      prefix: --bedgraph
  - id: sizes
    type: File
    doc: Path to genome chrom.sizes file
    inputBinding:
      position: 101
      prefix: --sizes
outputs:
  - id: saveto
    type: File
    doc: Path to write bigwig output
    outputBinding:
      glob: $(inputs.saveto)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboraptor:0.2.2--py36_0
