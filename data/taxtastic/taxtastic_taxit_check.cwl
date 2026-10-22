cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - check
label: taxtastic_taxit_check
doc: "Validate a reference package (is it a valid input for pplacer)\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: refpkg
    type: Directory
    doc: 'Path to the reference package to check'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_check.out
