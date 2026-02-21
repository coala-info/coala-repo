cwlVersion: v1.2
class: CommandLineTool
baseCommand: k8
label: k8
doc: "A Javascript runtime (V8 wrapper) often used in bioinformatics. Note: The provided
  text is an error log regarding container image creation and does not contain usage
  information or argument definitions.\n\nTool homepage: https://github.com/attractivechaos/k8"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k8:1.2--he8db53b_6
stdout: k8.out
