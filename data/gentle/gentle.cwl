cwlVersion: v1.2
class: CommandLineTool
baseCommand: gentle
label: gentle
doc: "Gentle is a tool for forced alignment of text to audio. (Note: The provided
  text contains container runtime error logs rather than help documentation, so no
  arguments could be extracted.)\n\nTool homepage: https://github.com/GENtle-persons/gentle-m"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gentle:1.9.5.alpha1--h229bc75_2
stdout: gentle.out
