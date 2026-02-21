cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucdiff
label: nucdiff
doc: "NucDiff is a tool for locating and classifying differences between two closely
  related genomes.\n\nTool homepage: https://github.com/uio-cels/NucDiff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucdiff:2.0.3--pyh864c0ab_1
stdout: nucdiff.out
