cwlVersion: v1.2
class: CommandLineTool
baseCommand: intervaltree
label: intervaltree
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/chaimleib/intervaltree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intervaltree:2.1.0--py35_0
stdout: intervaltree.out
