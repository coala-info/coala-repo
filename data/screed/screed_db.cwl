cwlVersion: v1.2
class: CommandLineTool
baseCommand: screed
label: screed_db
doc: "A shell interface to the screed database writing function\n\nTool homepage:
  http://github.com/dib-lab/screed/"
inputs:
  - id: filename
    type: File
    doc: The name of the file to process.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/screed:1.0.4--py_0
stdout: screed_db.out
