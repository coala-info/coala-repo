cwlVersion: v1.2
class: CommandLineTool
baseCommand: ensemblcov
label: ensemblcov
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log regarding a container execution failure (no space left
  on device).\n\nTool homepage: https://github.com/IBCHgenomic/ensemlcov"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ensemblcov:0.1.0--h4349ce8_0
stdout: ensemblcov.out
