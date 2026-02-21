cwlVersion: v1.2
class: CommandLineTool
baseCommand: instanovo
label: instanovo
doc: "InstaNovo: De novo peptide sequencing with transformer models.\n\nTool homepage:
  https://github.com/instadeepai/instanovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instanovo:1.2.2--pyhdfd78af_1
stdout: instanovo.out
