cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rosella
  - shell-completion
label: rosella_shell-completion
doc: "Generate a shell completion script for lorikeet\n\nTool homepage: https://github.com/rhysnewell/rosella.git"
inputs:
  - id: quiet
    type:
      - 'null'
      - boolean
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
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rosella:0.5.7--hfa530fd_0
