cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybel
  - post
label: pybel_post
doc: "Upload a graph to BEL Commons.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: File
    doc: "Compiled graph pickle written by pybel compile (a BEL script path also works when its compiled pickle is beside it)"
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: "URL of BEL Commons. Defaults to https://bel-commons.scai.fraunhofer.de"
    inputBinding:
      position: 10
      prefix: --host
outputs:
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_post.out
