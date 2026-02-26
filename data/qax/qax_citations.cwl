cwlVersion: v1.2
class: CommandLineTool
baseCommand: citations
label: qax_citations
doc: "Retrieve BibTeX citations from input files.\n\nTool homepage: https://github.com/telatin/qax"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to process
    inputBinding:
      position: 1
  - id: force_artifacts
    type:
      - 'null'
      - boolean
    doc: Try to parse artifacts with non canonical extensions
    inputBinding:
      position: 102
      prefix: --force-artifacts
  - id: recurse_parents
    type:
      - 'null'
      - boolean
    doc: Retrieve BibTeX citations also from parents
    inputBinding:
      position: 102
      prefix: --recurse-parents
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Save BibTeX citation to FILE
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qax:0.9.8--h515fd9b_0
