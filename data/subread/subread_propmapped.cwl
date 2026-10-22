cwlVersion: v1.2
class: CommandLineTool
baseCommand: propmapped
label: subread_propmapped
doc: "Calculate the proportion of mapped reads/fragments.\n\nTool homepage: http://subread.sourceforge.net/"
inputs:
  - id: input_file
    type: File
    doc: An input file containing read mapping results (SAM or BAM).
    inputBinding:
      position: 1
      prefix: -i
  - id: output_file
    type:
      - 'null'
      - string
    doc: Name of output file including mapping statistics.
    inputBinding:
      position: 1
      prefix: -o
  - id: count_fragments
    type:
      - 'null'
      - boolean
    doc: Count fragments (read pairs) instead of individual reads; paired-end reads only.
    inputBinding:
      position: 1
      prefix: -f
  - id: properly_paired
    type:
      - 'null'
      - boolean
    doc: Count only properly paired reads; paired-end reads only.
    inputBinding:
      position: 1
      prefix: -p
outputs:
  - id: stats_file
    type:
      - 'null'
      - File
    doc: Mapping statistics
    outputBinding:
      glob: $(inputs.output_file)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
stdout: subread_propmapped.out
