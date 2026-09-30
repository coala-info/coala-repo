cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - artic
  - export
label: artic_export
doc: "Export artic results to various formats.\n\nTool homepage: https://github.com/artic-network/fieldbioinformatics"
inputs:
  - id: prefix
    type: string
    inputBinding:
      position: 1
  - id: bamfile
    type: File
    inputBinding:
      position: 2
  - id: sequencing_summary
    type: File
    inputBinding:
      position: 3
  - id: fast5_directory
    type: Directory
    inputBinding:
      position: 4
  - id: output_directory
    type: string
    doc: output_directory (output path)
    inputBinding:
      position: 5
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 105
      prefix: --quiet
outputs:
  - id: out_output_directory
    type: Directory
    outputBinding:
      glob: '$(inputs.output_directory)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
