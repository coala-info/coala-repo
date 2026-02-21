cwlVersion: v1.2
class: CommandLineTool
baseCommand: pseudo-it
label: pseudo-it
doc: "Pseudo-it: A tool for generating pseudo-reference genomes.\n\nTool homepage:
  https://github.com/goodest-goodlab/pseudo-it"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pseudo-it:3.1.1--pyhdfd78af_0
stdout: pseudo-it.out
