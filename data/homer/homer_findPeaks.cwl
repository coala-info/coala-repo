cwlVersion: v1.2
class: CommandLineTool
baseCommand: findPeaks
label: homer_findPeaks
doc: "The provided text is a system error log regarding a container environment failure
  (no space left on device) and does not contain the help text or usage information
  for the tool.\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_findPeaks.out
