cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayesase
label: bayesase
doc: "Bayesian Allelic Specific Expression (Note: The provided text is a container
  build error log and does not contain CLI help information.)\n\nTool homepage: https://github.com/McIntyre-Lab/BayesASE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayesase:21.1.13.1--py_0
stdout: bayesase.out
