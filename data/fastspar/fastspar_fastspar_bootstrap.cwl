cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastspar_bootstrap
label: fastspar_fastspar_bootstrap
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  lack of disk space.\n\nTool homepage: https://github.com/scwatts/fastspar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastspar:1.0.0--h1b620e3_6
stdout: fastspar_fastspar_bootstrap.out
