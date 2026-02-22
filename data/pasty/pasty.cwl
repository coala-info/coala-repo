cwlVersion: v1.2
class: CommandLineTool
baseCommand: pasty
label: pasty
doc: "A tool for P-serotyping of Pseudomonas aeruginosa (Note: The provided text contains
  system error logs rather than help documentation, so no arguments could be extracted).\n\
  \nTool homepage: https://github.com/rpetit3/pasty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pasty:2.2.1--hdfd78af_0
stdout: pasty.out
