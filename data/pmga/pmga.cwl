cwlVersion: v1.2
class: CommandLineTool
baseCommand: pmga
label: pmga
doc: "Prokaryotic Metagenome Gene Annotation pipeline\n\nTool homepage: https://github.com/CDCgov/BMGAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmga:3.0.2--hdfd78af_0
stdout: pmga.out
