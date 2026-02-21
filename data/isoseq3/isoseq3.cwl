cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoseq3
label: isoseq3
doc: "IsoSeq3: Scalable De Novo Isoform Discovery (Note: The provided text is a system
  error message and does not contain help documentation or argument definitions).\n
  \nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
stdout: isoseq3.out
