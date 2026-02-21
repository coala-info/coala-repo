cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reactome-cli
  - reactome-gsa
label: reactome-cli_reactome-gsa
doc: "Reactome Gene Set Analysis (GSA) command-line interface. Note: The provided
  help text contains only system logs and a fatal error regarding container image
  retrieval, so no arguments could be extracted.\n\nTool homepage: https://github.com/reactome/reactome_galaxy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reactome-cli:1.0.0--hdfd78af_0
stdout: reactome-cli_reactome-gsa.out
