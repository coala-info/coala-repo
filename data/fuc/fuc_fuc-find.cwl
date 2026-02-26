cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - fuc-find
label: fuc_fuc-find
doc: "Retrieve absolute paths of files whose name matches a specified pattern, optionally
  recursively.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: pattern
    type: string
    doc: Filename pattern.
    inputBinding:
      position: 1
  - id: directory
    type:
      - 'null'
      - Directory
    doc: 'Directory to search in (default: current directory).'
    default: .
    inputBinding:
      position: 102
      prefix: --directory
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Turn on recursive retrieving.
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_fuc-find.out
