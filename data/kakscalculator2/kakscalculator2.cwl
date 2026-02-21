cwlVersion: v1.2
class: CommandLineTool
baseCommand: kakscalculator2
label: kakscalculator2
doc: "KaKs_Calculator2 calculates non-synonymous (Ka) and synonymous (Ks) substitution
  rates for gene pairs.\n\nTool homepage: https://github.com/kullrich/kakscalculator2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kakscalculator2:2.0.1--h9948957_6
stdout: kakscalculator2.out
