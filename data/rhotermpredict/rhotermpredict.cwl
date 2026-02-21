cwlVersion: v1.2
class: CommandLineTool
baseCommand: rhotermpredict
label: rhotermpredict
doc: "Rho-independent terminator prediction tool\n\nTool homepage: https://github.com/barricklab/RhoTermPredict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rhotermpredict:3.4--pyh7e72e81_0
stdout: rhotermpredict.out
