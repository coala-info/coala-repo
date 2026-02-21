cwlVersion: v1.2
class: CommandLineTool
baseCommand: haplogrep
label: haplogrep
doc: "HaploGrep - a tool for mtDNA haplogroup classification (Note: The provided help
  text contains only system error messages and no usage information).\n\nTool homepage:
  https://haplogrep.i-med.ac.at"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haplogrep:2.4.0--hdfd78af_0
stdout: haplogrep.out
