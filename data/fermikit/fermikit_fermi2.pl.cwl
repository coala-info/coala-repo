cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2.pl
label: fermikit_fermi2.pl
doc: "fermi2.pl is a Perl script for de novo genome assembly using the Fermi assembler.\n\
  \nTool homepage: https://github.com/lh3/fermikit"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., unitig, utglog, mag2fmr)
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_fermi2.pl.out
