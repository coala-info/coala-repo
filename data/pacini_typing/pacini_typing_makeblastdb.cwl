cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pacini_typing
  - makeblastdb
label: pacini_typing_makeblastdb
doc: "A tool for creating BLAST databases as part of the pacini_typing suite. (Note:
  The provided help text contains only system error messages regarding container execution
  and does not list specific command-line arguments.)\n\nTool homepage: https://github.com/RIVM-bioinformatics/Pacini-typing"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacini_typing:2.0.2--pyhdfd78af_0
stdout: pacini_typing_makeblastdb.out
