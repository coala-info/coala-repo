cwlVersion: v1.2
class: CommandLineTool
baseCommand: amide
label: amide
doc: "AMIDE: (Amide's a Medical Imaging Data Examiner) - a tool for viewing, analyzing,
  and registering medical imaging data sets.\n\nTool homepage: https://github.com/fkie-cad/amides"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Medical imaging data files to open
    inputBinding:
      position: 1
  - id: display
    type:
      - 'null'
      - string
    doc: X display to use
    inputBinding:
      position: 102
      prefix: --display
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/amide:v1.0.5-7-deb_cv1
stdout: amide.out
