cwlVersion: v1.2
class: CommandLineTool
baseCommand: analyzeHiC
label: homer_analyzeHiC
doc: "Analyze Hi-C data. (Note: The provided text contains only system error messages
  regarding container image creation and does not include tool-specific help or usage
  information.)\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_analyzeHiC.out
