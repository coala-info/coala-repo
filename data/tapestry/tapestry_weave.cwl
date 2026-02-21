cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tapestry
  - weave
label: tapestry_weave
doc: "Tapestry is a tool for de novo assembly and visualization of complex genomes.
  The 'weave' subcommand is used for the assembly process.\n\nTool homepage: https://github.com/johnomics/tapestry"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tapestry:1.0.1--pyhdfd78af_0
stdout: tapestry_weave.out
