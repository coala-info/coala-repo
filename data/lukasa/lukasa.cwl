cwlVersion: v1.2
class: CommandLineTool
baseCommand: lukasa
label: lukasa
doc: "Lukasa is a tool for RNA-seq analysis and genomic data processing (Note: The
  provided text is an error log and does not contain usage information).\n\nTool homepage:
  https://github.com/pvanheus/lukasa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lukasa:0.15.0--py310hdfd78af_0
stdout: lukasa.out
