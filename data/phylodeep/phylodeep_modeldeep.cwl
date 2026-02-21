cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylodeep
  - modeldeep
label: phylodeep_modeldeep
doc: "Phylogenetic inference using deep learning. (Note: The provided text contains
  system logs and error messages rather than help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/evolbioinfo/phylodeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylodeep:0.9--pyhdfd78af_0
stdout: phylodeep_modeldeep.out
