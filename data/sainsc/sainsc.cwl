cwlVersion: v1.2
class: CommandLineTool
baseCommand: sainsc
label: sainsc
doc: "The provided text is a log of a failed container build process and does not
  contain the help documentation or usage instructions for the 'sainsc' tool.\n\n
  Tool homepage: https://github.com/HiDiHlabs/sainsc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sainsc:0.3.1--py311h5e00ca1_0
stdout: sainsc.out
