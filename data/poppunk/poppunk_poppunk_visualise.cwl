cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
  - visualise
label: poppunk_poppunk_visualise
doc: "The provided text is a container engine error log and does not contain help
  information for the tool. No arguments could be extracted.\n\nTool homepage: https://github.com/johnlees/PopPUNK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
stdout: poppunk_poppunk_visualise.out
