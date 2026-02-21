cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmntrimmer
label: hmntrimmer
doc: "The provided text does not contain help or usage information for hmntrimmer;
  it contains system error messages regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/guillaume-gricourt/HmnTrimmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmntrimmer:0.6.5--he93f0d0_1
stdout: hmntrimmer.out
