cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - biopet.jar
label: biopet_-
doc: "Biopet is a framework for genomic analysis pipelines and tools developed by
  the SASC team at LUMC.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: mode
    type: string
    doc: 'Type of module to run: pipeline, tool, or template'
    inputBinding:
      position: 1
  - id: subcommand_name
    type: string
    doc: Name of the specific pipeline, tool, or template to execute
    inputBinding:
      position: 2
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments passed to the specific pipeline, tool, or template
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet_-.out
