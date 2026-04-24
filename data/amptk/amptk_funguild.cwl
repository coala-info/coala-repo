cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amptk
  - funguild
label: amptk_funguild
doc: "Script takes OTU table as input and runs FUNGuild to assing functional annotation
  to an OTU\n             based on the Guilds database. AMPtk runs method based off
  of script by Zewei Song (2015-2021).\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: funguild_db_url
    type:
      - 'null'
      - string
    doc: URL to FUNGuild db.
      https://mycoportal.org/fdex/services/api/db_return.php?dbReturn=Yes&pp=1
    inputBinding:
      position: 101
      prefix: --url
  - id: input_otu_table
    type:
      - 'null'
      - File
    doc: Input OTU table with Taxonomy (via amptk taxonomy)
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output_otu_table
    type:
      - 'null'
      - File
    doc: Output OTU table with Guild annotations
    outputBinding:
      glob: $(inputs.output_otu_table)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
