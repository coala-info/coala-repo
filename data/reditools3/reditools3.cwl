cwlVersion: v1.2
class: CommandLineTool
baseCommand: reditools3
label: reditools3
doc: "The provided text contains container engine logs and error messages rather than
  the tool's help documentation. As a result, no arguments or descriptions could be
  extracted.\n\nTool homepage: https://github.com/BioinfoUNIBA/REDItools3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reditools3:3.5--pyhdfd78af_0
stdout: reditools3.out
