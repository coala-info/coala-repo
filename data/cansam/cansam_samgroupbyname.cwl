cwlVersion: v1.2
class: CommandLineTool
baseCommand: cansam_samgroupbyname
label: cansam_samgroupbyname
doc: "Group SAM/BAM records by read name.\n\nTool homepage: https://github.com/jmarshall/cansam"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input SAM/BAM file. Reads from stdin if not specified.
    inputBinding:
      position: 1
  - id: display_info
    type:
      - 'null'
      - boolean
    doc: Display file information and statistics
    inputBinding:
      position: 102
      prefix: -v
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: Write output in BAM format
    inputBinding:
      position: 102
      prefix: -b
  - id: pairs_only
    type:
      - 'null'
      - boolean
    doc: Emit pairs only, discarding any leftover singleton reads
    inputBinding:
      position: 102
      prefix: -p
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 103
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to FILE rather than standard output
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
