cwlVersion: v1.2
class: CommandLineTool
baseCommand: dwi2response
label: mrtrix3_dwi2response
doc: "Estimate a response function for spherical deconvolution. Note: The provided
  help text contains a system error (no space left on device) and does not list specific
  arguments.\n\nTool homepage: https://www.mrtrix.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrtrix3_dwi2response.out
