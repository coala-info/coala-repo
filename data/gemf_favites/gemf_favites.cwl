cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemf_favites
label: gemf_favites
doc: "GEMF (Generalized Epidemic Modeling Framework) integration for FAVITES. Note:
  The provided text appears to be a container runtime error log rather than a help
  menu, so no arguments could be extracted.\n\nTool homepage: https://github.com/niemasd/GEMF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemf_favites:1.0.3--h7b50bb2_1
stdout: gemf_favites.out
