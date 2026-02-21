cwlVersion: v1.2
class: CommandLineTool
baseCommand: rosella
label: rosella
doc: "Rosella is a tool for metagenomic binning (Note: The provided text contains
  container build logs rather than help documentation; no arguments could be extracted).\n
  \nTool homepage: https://github.com/rhysnewell/rosella.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rosella:0.5.7--hfa530fd_0
stdout: rosella.out
