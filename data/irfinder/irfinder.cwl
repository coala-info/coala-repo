cwlVersion: v1.2
class: CommandLineTool
baseCommand: irfinder
label: irfinder
doc: "IRFinder is a tool for the analysis of Intron Retention (IR) events in RNA-seq
  data. (Note: The provided text contains system error logs rather than help documentation;
  no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/williamritchie/IRFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irfinder:1.3.1--h7b50bb2_6
stdout: irfinder.out
