cwlVersion: v1.2
class: CommandLineTool
baseCommand: freyja
label: freyja
doc: "Freyja is a tool for recovering relative lineage abundances from mixed SARS-CoV-2
  samples.\n\nTool homepage: https://github.com/andersen-lab/Freyja"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/freyja:2.0.3--pyhdfd78af_0
stdout: freyja.out
