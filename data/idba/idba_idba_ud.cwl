cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_ud
label: idba_idba_ud
doc: "Iterative de Bruijn graph assembler for short reads with highly uneven sequencing
  depth. (Note: The provided text contains system error messages regarding container
  execution and does not list command-line arguments.)\n\nTool homepage: https://github.com/loneknightpy/idba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
stdout: idba_idba_ud.out
