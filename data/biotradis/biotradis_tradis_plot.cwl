cwlVersion: v1.2
class: CommandLineTool
baseCommand: tradis_plot
label: biotradis_tradis_plot
doc: "Create insertion site plot for Artemis\n\nTool homepage: https://github.com/sanger-pathogens/Bio-Tradis"
inputs:
  - id: bam_file
    type: File
    doc: mapped, sorted bam file
    inputBinding:
      position: 101
      prefix: -f
  - id: mapping_quality
    type:
      - 'null'
      - int
    doc: mapping quality must be greater than X
    inputBinding:
      position: 101
      prefix: -m
outputs:
  - id: output_base_name
    type:
      - 'null'
      - File
    doc: output base name for plot
    outputBinding:
      glob: $(inputs.output_base_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotradis:1.4.5--0
