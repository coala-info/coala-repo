cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtyper
label: svtyper-python3
doc: "A Bayesian genotyper for structural variants\n\nTool homepage: https://github.com/hall-lab/svtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtyper-python3:0.7.1--pyhdfd78af_0
stdout: svtyper-python3.out
