cwlVersion: v1.2
class: CommandLineTool
baseCommand: svtyper
label: svtyper_svtyper-sso
doc: "Bayesian genotyper for structural variants\n\nTool homepage: https://github.com/hall-lab/svtyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtyper:0.7.1--py_0
stdout: svtyper_svtyper-sso.out
