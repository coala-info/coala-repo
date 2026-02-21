cwlVersion: v1.2
class: CommandLineTool
baseCommand: idba_tran
label: idba_idba_tran
doc: "Iterative de novo assembler for transcriptomes. Note: The provided help text
  contains only system error messages regarding container execution and disk space;
  no command-line arguments could be parsed from the input.\n\nTool homepage: https://github.com/loneknightpy/idba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/idba:v1.1.3-3-deb_cv1
stdout: idba_idba_tran.out
