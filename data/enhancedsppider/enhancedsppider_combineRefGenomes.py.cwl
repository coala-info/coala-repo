cwlVersion: v1.2
class: CommandLineTool
baseCommand: enhancedsppider_combineRefGenomes.py
label: enhancedsppider_combineRefGenomes.py
doc: "A tool to combine reference genomes (Note: The provided help text contains only
  system error messages and no usage information).\n\nTool homepage: https://github.com/JohnnyChen1113/EnhancedSppIDer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/enhancedsppider:0.2.2--pyhdfd78af_0
stdout: enhancedsppider_combineRefGenomes.py.out
