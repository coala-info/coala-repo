cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucdiff_nucdiff.py
label: nucdiff_nucdiff.py
doc: "NucDiff is a tool for locating and classifying differences between two closely
  related genomes. (Note: The provided help text contains system error messages and
  does not list tool arguments.)\n\nTool homepage: https://github.com/uio-cels/NucDiff"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nucdiff:2.0.3--pyh864c0ab_1
stdout: nucdiff_nucdiff.py.out
