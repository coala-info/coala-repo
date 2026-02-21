cwlVersion: v1.2
class: CommandLineTool
baseCommand: evidencemodeler
label: evidencemodeler
doc: "EvidenceModeler (EVM) automated eukaryotic gene structure annotation tool.\n
  \nTool homepage: https://github.com/EVidenceModeler/EVidenceModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evidencemodeler:2.1.0--h9948957_5
stdout: evidencemodeler.out
