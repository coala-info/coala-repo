cwlVersion: v1.2
class: CommandLineTool
baseCommand: jass_preprocessing
label: jass_preprocessing
doc: "Joint Analysis of Summary Statistics (JASS) preprocessing tool\n\nTool homepage:
  http://statistical-genetics.pages.pasteur.fr/jass_preprocessing/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass_preprocessing.out
