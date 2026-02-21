cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoquant
label: isoquant
doc: "IsoQuant is a tool for the genome-independent analysis of long-read transcriptomes.
  (Note: The provided text is a container runtime error log and does not contain help
  documentation or argument definitions).\n\nTool homepage: https://github.com/ablab/IsoQuant"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoquant:3.10.0--hdfd78af_0
stdout: isoquant.out
