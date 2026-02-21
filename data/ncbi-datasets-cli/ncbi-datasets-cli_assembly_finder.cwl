cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbi-datasets-cli
label: ncbi-datasets-cli_assembly_finder
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/metagenlab/assembly_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
stdout: ncbi-datasets-cli_assembly_finder.out
