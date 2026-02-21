cwlVersion: v1.2
class: CommandLineTool
baseCommand: enhancedsppider_sppIDer.py
label: enhancedsppider_sppIDer.py
doc: "The provided text contains system error logs and container runtime information
  rather than the tool's help documentation. As a result, no arguments or descriptions
  could be extracted from the input.\n\nTool homepage: https://github.com/JohnnyChen1113/EnhancedSppIDer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhancedsppider:0.2.2--pyhdfd78af_0
stdout: enhancedsppider_sppIDer.py.out
