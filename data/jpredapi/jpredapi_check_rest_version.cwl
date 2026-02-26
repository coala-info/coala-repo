cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jpredapi
  - check_rest_version
label: jpredapi_check_rest_version
doc: "Check the version of the REST API.\n\nTool homepage: https://github.com/MoseleyBioinformaticsLab/jpredapi"
inputs:
  - id: rest_address
    type:
      - 'null'
      - string
    doc: REST address of server
    default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest
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
stdout: jpredapi_check_rest_version.out
