cwlVersion: v1.2
class: CommandLineTool
baseCommand: sirius-csifingerid
label: sirius-csifingerid
doc: "CSI:FingerID is a tool for metabolite identification from tandem mass spectrometry
  data, part of the SIRIUS software suite.\n\nTool homepage: https://bio.informatik.uni-jena.de/software/sirius/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
stdout: sirius-csifingerid.out
