cwlVersion: v1.2
class: CommandLineTool
baseCommand: cleaverna
label: cleaverna
doc: "A tool for cleavage of RNA sequences (description not available in provided
  text)\n\nTool homepage: https://github.com/reyhaneh-tavakoli/CleaveRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cleaverna:1.0.0--pyhdfd78af_0
stdout: cleaverna.out
