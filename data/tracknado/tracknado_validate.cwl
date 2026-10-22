cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tracknado
  - validate
label: tracknado_validate
doc: "Validate a local hub directory or hub.txt file. Performs structural checks and
  uses the UCSC 'hubCheck' tool if available to ensure the hub is correctly formatted
  and accessible.\n\nTool homepage: https://pypi.org/project/tracknado/"
inputs:
  - id: hub_path
    type: Directory
    doc: Path to a hub directory to check for errors (a 'hub.txt' file inside it is checked).
    inputBinding:
      position: 1
  - id: strict
    type:
      - 'null'
      - boolean
    doc: If set, treats all warnings as errors during validation.
    inputBinding:
      position: 102
      prefix: --strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracknado:0.3.1--pyhdfd78af_0
stdout: tracknado_validate.out
