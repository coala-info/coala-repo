cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemf_favites_GEMF
label: gemf_favites_GEMF
doc: "Generalized Epidemic Modeling Framework (GEMF) within the FAVITES framework.
  Note: The provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://github.com/niemasd/GEMF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemf_favites:1.0.3--h7b50bb2_1
stdout: gemf_favites_GEMF.out
