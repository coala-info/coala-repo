cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybel post
label: pybel_post
doc: "Upload a graph to BEL Commons.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: path
    type: string
    doc: Path to the graph to upload
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: URL of BEL Commons.
    default: https://bel-commons.scai.fraunhofer.de
    inputBinding:
      position: 102
      prefix: --host
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_post.out
