cwlVersion: v1.2
class: CommandLineTool
baseCommand: dinosaur
label: dinosaur
doc: "Dinosaur is a tool for peptide feature detection (Note: The provided text is
  an error log and does not contain help information or argument definitions).\n\n
  Tool homepage: https://github.com/fickludd/dinosaur"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dinosaur:1.2.0--hdfd78af_1
stdout: dinosaur.out
