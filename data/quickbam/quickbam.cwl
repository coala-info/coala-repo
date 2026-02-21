cwlVersion: v1.2
class: CommandLineTool
baseCommand: quickbam
label: quickbam
doc: "The provided text is a container build/fetch error log and does not contain
  help information or argument definitions for the quickbam tool.\n\nTool homepage:
  https://gitlab.com/yiq/quickbam/-/tree/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quickbam:1.0.0--h4f9202f_1
stdout: quickbam.out
