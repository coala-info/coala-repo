cwlVersion: v1.2
class: CommandLineTool
baseCommand: shasta_savebinarydata
label: shasta_savebinarydata
doc: "Saves binary data from a Shasta run.\n\nTool homepage: https://github.com/chanzuckerberg/shasta"
inputs:
  - id: savebinarydata
    type: string
    doc: This argument is not allowed and indicates an error in usage.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shasta:0.14.0--h9948957_0
stdout: shasta_savebinarydata.out
