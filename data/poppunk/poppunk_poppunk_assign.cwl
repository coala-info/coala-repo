cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
  - --assign
label: poppunk_poppunk_assign
doc: "The provided text does not contain help information as it is a container runtime
  error log. No arguments could be extracted.\n\nTool homepage: https://github.com/johnlees/PopPUNK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
stdout: poppunk_poppunk_assign.out
