cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - biopet.jar
label: biopet
doc: "A bioinformatics pipeline and tool suite for processing genomic data.\n\nTool
  homepage: https://github.com/biopet/biopet"
inputs:
  - id: category
    type: string
    doc: 'The category of the command to execute: pipeline, tool, or template.'
    inputBinding:
      position: 1
  - id: command_name
    type: string
    doc: The name of the specific pipeline, tool, or template to run (e.g., Bam2Wig,
      BamStats, Gentrap).
    inputBinding:
      position: 2
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments passed to the specific pipeline or tool.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
stdout: biopet.out
