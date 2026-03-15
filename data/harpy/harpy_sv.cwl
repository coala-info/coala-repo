cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - sv
label: harpy_sv
doc: Call inversions, deletions, and duplications from alignments using 
  LEVIATHAN or NAIBR.
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (leviathan or naibr)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the selected subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
stdout: harpy_sv.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
