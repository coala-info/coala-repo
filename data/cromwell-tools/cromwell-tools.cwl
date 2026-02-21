cwlVersion: v1.2
class: CommandLineTool
baseCommand: cromwell-tools
label: cromwell-tools
doc: "A command-line tool for interacting with the Cromwell workflow engine.\n\nTool
  homepage: http://github.com/broadinstitute/cromwell-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromwell-tools:2.4.1--py_0
stdout: cromwell-tools.out
