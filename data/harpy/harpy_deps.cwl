cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - harpy
  - deps
label: harpy_deps
doc: Locally install workflow dependencies. These commands are intended only for
  situations on HPCs where conda cannot be installed or the worker nodes do not 
  have internet access to download conda/apptainer workflow dependencies.
inputs:
  - id: command
    type: string
    doc: The subcommand to execute (conda or container)
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
stdout: harpy_deps.out
s:url: https://github.com/pdimens/harpy/
$namespaces:
  s: https://schema.org/
