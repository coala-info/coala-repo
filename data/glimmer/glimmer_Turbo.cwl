cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmer_Turbo
label: glimmer_Turbo
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log regarding a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/glimmerjs/glimmer-vm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimmer:3.02--2
stdout: glimmer_Turbo.out
