cwlVersion: v1.2
class: CommandLineTool
baseCommand: sga
label: sga
doc: "SGA (String Graph Assembler) is a de novo assembler for DNA sequence data. (Note:
  The provided text is an error log and does not contain help information or argument
  definitions).\n\nTool homepage: https://github.com/jts/sga"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga.out
