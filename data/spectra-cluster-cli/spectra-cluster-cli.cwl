cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectra-cluster-cli
label: spectra-cluster-cli
doc: "The provided text does not contain help information for the tool. It is a log
  of a failed container build/fetch process.\n\nTool homepage: https://github.com/spectra-cluster/spectra-cluster-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spectra-cluster-cli:1.1.2--0
stdout: spectra-cluster-cli.out
