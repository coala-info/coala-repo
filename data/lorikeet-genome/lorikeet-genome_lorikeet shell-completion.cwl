cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorikeet
  - shell-completion
label: lorikeet-genome_lorikeet shell-completion
doc: "Generate a shell completion script for lorikeet\n\nTool homepage: https://github.com/rhysnewell/Lorikeet"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Unless there is an error, do not print logging information
    inputBinding:
      position: 101
      prefix: --quiet
  - id: shell
    type: string
    doc: '[possible values: bash, elvish, fish, powershell, zsh]'
    inputBinding:
      position: 101
      prefix: --shell
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra debug logging information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet-genome:0.8.2--h8e1a5b0_0
