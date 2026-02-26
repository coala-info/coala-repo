cwlVersion: v1.2
class: CommandLineTool
baseCommand: gappa edit
label: gappa_edit
doc: "Commands for editing and manipulating files like jplace, fasta or newick.\n\n\
  Tool homepage: https://github.com/lczech/gappa"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands are: accumulate, extract, filter,
      merge, multiplicity, split.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
stdout: gappa_edit.out
