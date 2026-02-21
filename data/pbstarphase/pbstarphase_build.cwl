cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbstarphase
  - build
label: pbstarphase_build
doc: "Download and build the database for StarPhase\n\nTool homepage: https://github.com/PacificBiosciences/pb-StarPhase"
inputs:
  - id: build_options
    type:
      - 'null'
      - File
    doc: User-provided build options (JSON)
    inputBinding:
      position: 101
      prefix: --build-options
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
    dockerPull: quay.io/biocontainers/pbstarphase:2.0.1--h9ee0642_0
