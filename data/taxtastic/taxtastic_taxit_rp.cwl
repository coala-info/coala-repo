cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - rp
label: taxtastic_taxit_rp
doc: "Resolve path; get the path to a file in the reference package\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: refpkg
    type: Directory
    doc: "the reference package to operate on"
    inputBinding:
      position: 101
  - id: key
    type: string
    doc: "show the path for file identified by KEY"
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_rp.out
