cwlVersion: v1.2
class: CommandLineTool
baseCommand: enhancedsppider
label: enhancedsppider
doc: "The provided text contains container runtime error messages rather than tool
  help documentation. No arguments or descriptions could be extracted from the input.\n
  \nTool homepage: https://github.com/JohnnyChen1113/EnhancedSppIDer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhancedsppider:0.2.2--pyhdfd78af_0
stdout: enhancedsppider.out
