cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - oakvar
  - ov
  - module
  - info
label: oakvar_ov module info
doc: "returns information of the queried module\n\nTool homepage: http://www.oakvar.com"
inputs:
  - id: module_name
    type: string
    doc: Module to get info about
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: format of module information data. json or yaml
    inputBinding:
      position: 102
      prefix: --fmt
  - id: include_local_info
    type:
      - 'null'
      - boolean
    doc: Include local info
    inputBinding:
      position: 102
      prefix: --local
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oakvar:2.12.25--pyhdfd78af_0
stdout: oakvar_ov module info.out
