cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplogrep3
label: haplogrep3
doc: "HaploGrep3 is a tool for mtDNA haplogroup classification.\n\nTool homepage:
  https://haplogrep.i-med.ac.at"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep3:3.2.2--hdfd78af_1
stdout: haplogrep3.out
