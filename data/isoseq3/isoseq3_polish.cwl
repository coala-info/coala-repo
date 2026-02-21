cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isoseq3
  - polish
label: isoseq3_polish
doc: "No description available: The provided text contains system error messages rather
  than tool help text.\n\nTool homepage: https://github.com/PacificBiosciences/IsoSeq3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoseq3:4.0.0--h9ee0642_0
stdout: isoseq3_polish.out
