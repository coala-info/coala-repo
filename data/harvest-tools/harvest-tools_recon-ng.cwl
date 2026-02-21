cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harvest-tools
  - recon-ng
label: harvest-tools_recon-ng
doc: "The provided text does not contain help information for the tool, but rather
  error logs related to a container environment failure (no space left on device).\n
  \nTool homepage: https://github.com/lanmaster53/recon-ng"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/harvest-tools:v1.3-4-deb_cv1
stdout: harvest-tools_recon-ng.out
