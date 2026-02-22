cwlVersion: v1.2
class: CommandLineTool
baseCommand: cloci
label: cloci
doc: "Identify common loci across multiple genomic files (BED, GFF, etc.).\n\nTool
  homepage: https://github.com/xonq/cloci"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input genomic files (e.g., BED, GFF)
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output file (default: stdout)'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cloci:0.4.0--pyhdfd78af_0
