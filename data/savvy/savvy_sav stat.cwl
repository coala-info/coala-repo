cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sav
  - stat
label: savvy_sav stat
doc: "Too few arguments\n\nTool homepage: https://github.com/statgen/savvy"
inputs:
  - id: input_sav
    type: File
    doc: Input .sav file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savvy:2.1.0--h5b0a936_4
stdout: savvy_sav stat.out
