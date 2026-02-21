cwlVersion: v1.2
class: CommandLineTool
baseCommand: poppunk
label: poppunk
doc: "The provided text is a container execution error log and does not contain help
  information or argument definitions for the tool 'poppunk'.\n\nTool homepage: https://github.com/johnlees/PopPUNK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
stdout: poppunk.out
