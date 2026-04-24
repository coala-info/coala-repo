cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cooler
  - info
label: cooler_info
doc: "Display a cooler's info and metadata.\n\nTool homepage: https://github.com/open2c/cooler"
inputs:
  - id: cool_path
    type: File
    doc: Path to a COOL file or cooler URI.
    inputBinding:
      position: 1
  - id: field
    type:
      - 'null'
      - string
    doc: Print the value of a specific info field.
    inputBinding:
      position: 102
      prefix: --field
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: Print the user metadata in JSON format.
    inputBinding:
      position: 102
      prefix: --metadata
  - id: out
    type:
      - 'null'
      - string
    doc: Output file (defaults to stdout)
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler_info.out
