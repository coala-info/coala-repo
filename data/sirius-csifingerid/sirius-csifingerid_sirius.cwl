cwlVersion: v1.2
class: CommandLineTool
baseCommand: sirius
label: sirius-csifingerid_sirius
doc: "SIRIUS is a software framework for the analysis of LC-MS/MS data of metabolites
  and other small molecules, including CSI:FingerID.\n\nTool homepage: https://bio.informatik.uni-jena.de/software/sirius/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sirius-csifingerid:5.8.6--h3bb291f_0
stdout: sirius-csifingerid_sirius.out
