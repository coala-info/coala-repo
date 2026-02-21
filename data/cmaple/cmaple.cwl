cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmaple
label: cmaple
doc: "The provided text contains container build logs and error messages rather than
  the tool's help documentation. As a result, no arguments or tool descriptions could
  be extracted.\n\nTool homepage: https://github.com/iqtree/cmaple"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmaple:1.1.0--h503566f_1
stdout: cmaple.out
