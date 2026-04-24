cwlVersion: v1.2
class: CommandLineTool
baseCommand: remove_tags
label: biotradis_remove_tradis_tags
doc: "Removes transposon sequence and quality tags from the read strings\n\nTool homepage:
  https://github.com/sanger-pathogens/Bio-Tradis"
inputs:
  - id: fastq_file
    type: File
    doc: fastq file with tradis tags
    inputBinding:
      position: 101
      prefix: -f
  - id: mismatches
    type:
      - 'null'
      - int
    doc: number of mismatches to allow when matching tag
    inputBinding:
      position: 101
      prefix: -m
  - id: tag_to_remove
    type:
      - 'null'
      - string
    doc: tag to remove
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file name (optional. default: <file>.rmtag.fastq)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotradis:1.4.5--0
