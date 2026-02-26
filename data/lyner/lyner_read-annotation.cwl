cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - read-annotation
label: lyner_read-annotation
doc: "Reads annotation from given file and stores it in `annotation`.\n\nTool homepage:
  https://github.com/tedil/lyner"
inputs:
  - id: file
    type: File
    doc: Input file for annotation
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
stdout: lyner_read-annotation.out
