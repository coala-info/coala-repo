cwlVersion: v1.2
class: CommandLineTool
baseCommand: analyzeRepeats.pl
label: homer_analyzeRepeats.pl
doc: "The provided help text contains a fatal system error (no space left on device)
  and does not contain the actual usage information or argument definitions for the
  tool. As a result, no arguments can be extracted.\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_analyzeRepeats.pl.out
