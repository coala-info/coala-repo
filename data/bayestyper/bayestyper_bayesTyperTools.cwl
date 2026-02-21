cwlVersion: v1.2
class: CommandLineTool
baseCommand: bayesTyperTools
label: bayestyper_bayesTyperTools
doc: "The provided text does not contain help information for bayesTyperTools; it
  contains system logs and an error message regarding a container build failure (no
  space left on device).\n\nTool homepage: https://github.com/bioinformatics-centre/BayesTyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bayestyper:1.5--hdcf5f25_3
stdout: bayestyper_bayesTyperTools.out
