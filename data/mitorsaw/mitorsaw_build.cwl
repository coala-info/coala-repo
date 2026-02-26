cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitorsaw_build
label: mitorsaw_build
doc: "Download and build the mitochondria database\n\nTool homepage: https://github.com/PacificBiosciences/mitorsaw"
inputs:
  - id: reference
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_db
    type: File
    doc: Output database location (JSON)
    outputBinding:
      glob: $(inputs.output_db)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitorsaw:0.2.7--h9ee0642_0
