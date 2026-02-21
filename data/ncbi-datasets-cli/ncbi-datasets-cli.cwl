cwlVersion: v1.2
class: CommandLineTool
baseCommand: datasets
label: ncbi-datasets-cli
doc: "The provided text is an error message indicating a failure to pull or build
  the container image (no space left on device) and does not contain help documentation
  or argument definitions.\n\nTool homepage: https://github.com/metagenlab/assembly_finder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-datasets-cli:14.26.0
stdout: ncbi-datasets-cli.out
