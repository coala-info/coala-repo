cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_tags
label: biotradis_check_tradis_tags
doc: "Check for the existence of tradis tags in a bam\n\nTool homepage: https://github.com/sanger-pathogens/Bio-Tradis"
inputs:
  - id: bam_file
    type: File
    doc: bam file with tradis tags
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotradis:1.4.5--0
stdout: biotradis_check_tradis_tags.out
