cwlVersion: v1.2
class: CommandLineTool
baseCommand: thapbi_pict
label: thapbi-pict_thapbi_pict
doc: "THAPBI Phytophthora ITS1 Classifier Tool (PICT), v1.0.21.\n\nTool homepage:
  https://github.com/peterjc/thapbi-pict"
inputs:
  - id: subcommand
    type: string
    doc: Each subcommand has its own additional help.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_thapbi_pict.out
