cwlVersion: v1.2
class: CommandLineTool
baseCommand: jass
label: jass
doc: "The provided text does not contain help information or usage instructions for
  the tool 'jass'. It contains system log messages and a fatal error regarding container
  image conversion and disk space.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass.out
