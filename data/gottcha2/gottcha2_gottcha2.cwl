cwlVersion: v1.2
class: CommandLineTool
baseCommand: gottcha2
label: gottcha2_gottcha2
doc: "GOTTCHA2 - Genomic Origin Through Taxonomic CHAllenge v2.2.0\n\nTool homepage:
  https://github.com/poeli/gottcha2"
inputs:
  - id: command
    type: string
    doc: The command to run (profile, extract, version)
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gottcha2:2.2.0--pyhdfd78af_0
stdout: gottcha2_gottcha2.out
