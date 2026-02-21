cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter_tags
label: biotradis_filter_tradis_tags
doc: "Filters a BAM file and outputs reads with tag matching -t option\n\nTool homepage:
  https://github.com/sanger-pathogens/Bio-Tradis"
inputs:
  - id: bam_file
    type: File
    doc: BAM file to filter
    inputBinding:
      position: 101
      prefix: -b
  - id: fastq_file
    type:
      - 'null'
      - File
    doc: fastq file with tradis tags attached
    inputBinding:
      position: 101
      prefix: -f
  - id: mismatches
    type:
      - 'null'
      - int
    doc: number of mismatches to allow when matching tag
    default: 0
    inputBinding:
      position: 101
      prefix: -m
  - id: tag
    type: string
    doc: tag to search for
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file name (optional. default: <file>.tag.fastq)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biotradis:1.4.5--0
