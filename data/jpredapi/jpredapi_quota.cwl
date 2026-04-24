cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jpredapi
  - quota
label: jpredapi_quota
doc: "Check your JPred API quota\n\nTool homepage: https://github.com/MoseleyBioinformaticsLab/jpredapi"
inputs:
  - id: email
    type: string
    doc: E-mail address where job report will be sent (optional for all but 
      batch submissions).
    inputBinding:
      position: 101
      prefix: --email
  - id: rest
    type:
      - 'null'
      - string
    doc: REST address of server
    inputBinding:
      position: 101
      prefix: --rest
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print messages.
    inputBinding:
      position: 101
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jpredapi:1.5.6--py_0
stdout: jpredapi_quota.out
