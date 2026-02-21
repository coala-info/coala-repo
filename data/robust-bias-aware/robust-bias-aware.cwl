cwlVersion: v1.2
class: CommandLineTool
baseCommand: robust-bias-aware
label: robust-bias-aware
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and a fatal error message related to a container
  build process.\n\nTool homepage: https://github.com/bionetslab/robust_bias_aware_pip_package"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/robust-bias-aware:0.0.1--pyh7cba7a3_1
stdout: robust-bias-aware.out
