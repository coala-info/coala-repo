cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamAlignCleaner
label: bamaligncleaner_bamAlignCleaner
doc: "removes unaligned references in BAM/CRAM alignment files\n\nTool homepage: https://github.com/maxibor/bamAlignCleaner"
inputs:
  - id: bam_file
    type: File
    doc: BAM alignment file (sorted, and optionally indexed)
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
  - id: method
    type:
      - 'null'
      - string
    doc: unaligned reference removal method
    inputBinding:
      position: 102
      prefix: --method
  - id: reflist
    type:
      - 'null'
      - File
    doc: File listing references to keep in output bam
    inputBinding:
      position: 102
      prefix: --reflist
  - id: output_file_path
    type: string
    doc: 'filtered bam file [default: STDOUT]'
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: filtered bam file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamaligncleaner:0.3--pyhdfd78af_0
