cwlVersion: v1.2
class: CommandLineTool
baseCommand: phame
label: phame
doc: "PhaME (version 1.0.2)\n\nTool homepage: https://github.com/LANL-Bioinformatics/PhaME"
inputs:
  - id: control_file
    type: File
    doc: control file
    inputBinding:
      position: 1
  - id: vcheck
    type:
      - 'null'
      - boolean
    doc: checks if all depenencies are correct and in path.
    inputBinding:
      position: 102
      prefix: --vcheck
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phame:1.0.3--pl5321hdfd78af_3
stdout: phame.out
