cwlVersion: v1.2
class: CommandLineTool
baseCommand: taco
label: taco
doc: "Transcriptome Assembly COmbiner (TACO) is a tool for multi-sample transcriptome
  assembly and analysis.\n\nTool homepage: https://github.com/tacorna/taco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taco:0.7.3--py27_0
stdout: taco.out
