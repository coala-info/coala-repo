cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnaprot
label: rnaprot
doc: "RNAprot: Protein-RNA binding site prediction\n\nTool homepage: https://github.com/BackofenLab/RNAProt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
stdout: rnaprot.out
