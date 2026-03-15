cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - convert
label: harpy_convert
doc: '[deprecated] Convert between linked-read formats. This module of Harpy has been
  deprecated and its function has been moved to the Djinn package.'
inputs:
  - id: command
    type: string
    doc: The subcommand to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
stdout: harpy_convert.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
