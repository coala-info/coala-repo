cwlVersion: v1.2
class: CommandLineTool
baseCommand: quasitools
label: quasitools_using
doc: "A command-line tool for manipulating and analyzing quasigenomes.\n\nTool homepage:
  https://github.com/phac-nml/quasitools/"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., 'using', 'build', 'query').
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
stdout: quasitools_using.out
