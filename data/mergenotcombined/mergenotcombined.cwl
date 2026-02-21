cwlVersion: v1.2
class: CommandLineTool
baseCommand: mergenotcombined
label: mergenotcombined
doc: "The provided text is a container runtime error log and does not contain the
  tool's help information or usage instructions.\n\nTool homepage: https://github.com/andvides/mergeNotCombined.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mergenotcombined:1.0--h503566f_4
stdout: mergenotcombined.out
