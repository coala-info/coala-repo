cwlVersion: v1.2
class: CommandLineTool
baseCommand: samcat
label: cansam_samcat
doc: "Concatenate SAM/BAM files\n\nTool homepage: https://github.com/jmarshall/cansam"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input SAM/BAM files
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
  - id: flags
    type:
      - 'null'
      - string
    doc: Display only alignment records matching FLAGS
    inputBinding:
      position: 102
      prefix: -f
  - id: output_bam_format
    type:
      - 'null'
      - boolean
    doc: Write output in BAM format (equivalent to -Obam)
    inputBinding:
      position: 102
      prefix: -b
  - id: output_format
    type:
      - 'null'
      - string
    doc: Write output in the specified FORMAT
    inputBinding:
      position: 102
      prefix: -O
  - id: suppress_headers
    type:
      - 'null'
      - boolean
    doc: Suppress '@' headers in the output
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to FILE rather than standard output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
