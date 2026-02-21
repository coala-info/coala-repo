cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimet
label: dimet
doc: "DIMET: Differential Analysis of Metabolic Tracing data. (Note: The provided
  help text contains only container runtime error messages and does not list specific
  tool arguments.)\n\nTool homepage: https://github.com/cbib/DIMet.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimet:0.2.4--pyhdfd78af_1
stdout: dimet.out
