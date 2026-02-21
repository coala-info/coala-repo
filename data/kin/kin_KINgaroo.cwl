cwlVersion: v1.2
class: CommandLineTool
baseCommand: kin
label: kin_KINgaroo
doc: "A tool for kinship estimation (Note: The provided text contains container execution
  errors and does not include help documentation or argument details).\n\nTool homepage:
  https://github.com/DivyaratanPopli/Kinship_Inference"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kin:3.1.4--pyhdfd78af_0
stdout: kin_KINgaroo.out
