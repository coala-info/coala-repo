cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - poppunk
  - info
label: poppunk_poppunk_info
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution log showing a fatal error during the image build process.\n
  \nTool homepage: https://github.com/johnlees/PopPUNK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
stdout: poppunk_poppunk_info.out
