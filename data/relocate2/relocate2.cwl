cwlVersion: v1.2
class: CommandLineTool
baseCommand: relocate2
label: relocate2
doc: "RelocaTE2 is a tool for identifying transposable element insertions from next-generation
  sequencing data.\n\nTool homepage: https://www.gnu.org/software/coreutils/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relocate2:2.0.1--py27_0
stdout: relocate2.out
