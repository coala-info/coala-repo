cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - Dinosaur.jar
label: dinosaur_Dinosaur.jar
doc: "Dinosaur is a peptide feature detector for LC-MS data. (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list command-line arguments.)\n\nTool homepage: https://github.com/fickludd/dinosaur"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinosaur:1.2.0--hdfd78af_1
stdout: dinosaur_Dinosaur.jar.out
