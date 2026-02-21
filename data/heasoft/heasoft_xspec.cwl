cwlVersion: v1.2
class: CommandLineTool
baseCommand: xspec
label: heasoft_xspec
doc: "X-ray Spectral Fitting Package. (Note: The provided text appears to be a container
  runtime error log rather than tool help text, so no arguments could be extracted.)\n
  \nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
stdout: heasoft_xspec.out
