cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jannovar-cli
  - filter
label: jannovar-cli_jannovar-filter
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime failure (no space left on device).\n\n
  Tool homepage: https://github.com/charite/jannovar"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jannovar-cli:0.36--hdfd78af_0
stdout: jannovar-cli_jannovar-filter.out
