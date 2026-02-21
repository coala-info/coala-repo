cwlVersion: v1.2
class: CommandLineTool
baseCommand: reactome-cli
label: reactome-cli
doc: "Reactome Command Line Interface (Note: The provided text is a container execution
  log and does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://github.com/reactome/reactome_galaxy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reactome-cli:1.0.0--hdfd78af_0
stdout: reactome-cli.out
