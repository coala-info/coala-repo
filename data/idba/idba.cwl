cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba
label: idba
doc: "Iterative De Bruijn Graph Assembler (Note: The provided text is an error log
  and does not contain help information or argument definitions).\n\nTool homepage:
  https://github.com/loneknightpy/idba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
stdout: idba.out
