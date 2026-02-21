cwlVersion: v1.2
class: CommandLineTool
baseCommand: kin
label: kin
doc: "A tool for kinship analysis (Note: The provided text is a system error message
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/DivyaratanPopli/Kinship_Inference"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kin:3.1.4--pyhdfd78af_0
stdout: kin.out
