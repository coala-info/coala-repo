cwlVersion: v1.2
class: CommandLineTool
baseCommand: bubblefinder
label: bubblefinder
doc: "A tool for finding bubbles in de Bruijn graphs (Note: The provided text contains
  system error messages regarding disk space and container extraction rather than
  the tool's help documentation).\n\nTool homepage: https://github.com/algbio/BubbleFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bubblefinder:1.0.3--h503566f_0
stdout: bubblefinder.out
