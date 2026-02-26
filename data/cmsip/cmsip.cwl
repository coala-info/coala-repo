cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmsip
label: cmsip
doc: "CMS-IP sequencing analysis\n\nTool homepage: https://github.com/lijinbio/cmsip"
inputs:
  - id: config
    type: File
    doc: Configuration file in YAML format.
    inputBinding:
      position: 101
      prefix: --config
  - id: define_variable
    type:
      - 'null'
      - type: array
        items: string
    doc: Define variable=value to suppress configuration file. e.g. "-D 
      dhmrinfo.verbose=False"
    inputBinding:
      position: 101
      prefix: -D
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmsip:0.0.3.0--py_0
stdout: cmsip.out
