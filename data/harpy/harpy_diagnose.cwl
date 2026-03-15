cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - diagnose
label: harpy_diagnose
doc: Attempt to resolve workflow errors
inputs:
  - id: command
    type: string
    doc: The subcommand to run (rule or stall)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
stdout: harpy_diagnose.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
