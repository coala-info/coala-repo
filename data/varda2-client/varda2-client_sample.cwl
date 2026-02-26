cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - varda2-client
  - sample
label: varda2-client_sample
doc: "Sample management for Varda2\n\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: disease_code
    type:
      - 'null'
      - string
    doc: Disease indication code
    inputBinding:
      position: 101
      prefix: --disease-code
  - id: lab_sample_id
    type:
      - 'null'
      - string
    doc: Local sample id
    inputBinding:
      position: 101
      prefix: --lab-sample-id
  - id: uuid
    type: string
    doc: Sample UUID
    inputBinding:
      position: 101
      prefix: --uuid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client_sample.out
