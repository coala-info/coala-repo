cwlVersion: v1.2
class: CommandLineTool
baseCommand: monsda
label: monsda
doc: "Multi-Omics Network-based Single-cell Data Analysis. (Note: The provided text
  contains container runtime error logs rather than the tool's help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/jfallmann/MONSDA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monsda:1.2.8--pyhdfd78af_0
stdout: monsda.out
