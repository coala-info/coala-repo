cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnabloom
label: rnabloom
doc: "RNA-Bloom is a de novo RNA-seq assembler. (Note: The provided text contains
  container build logs and error messages rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/bcgsc/RNA-Bloom"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabloom:2.0.1--hdfd78af_1
stdout: rnabloom.out
