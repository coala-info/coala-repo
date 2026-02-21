cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadarida-c
label: tadarida-c
doc: "The provided text is a container build log and does not contain help information
  or usage instructions for the tool.\n\nTool homepage: https://github.com/YvesBas/Tadarida-C"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadarida-c:1.2--r3.4.1_0
stdout: tadarida-c.out
