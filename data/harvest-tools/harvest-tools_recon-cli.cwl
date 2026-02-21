cwlVersion: v1.2
class: CommandLineTool
baseCommand: harvest-tools_recon-cli
label: harvest-tools_recon-cli
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding disk
  space.\n\nTool homepage: https://github.com/lanmaster53/recon-ng"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/harvest-tools:v1.3-4-deb_cv1
stdout: harvest-tools_recon-cli.out
