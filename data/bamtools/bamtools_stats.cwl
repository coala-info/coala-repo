cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - stats
label: bamtools_stats
doc: "prints general alignment statistics.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: input_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: the input BAM file [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: input_list
    type:
      - 'null'
      - File
    doc: the input BAM file list, one line per file
    inputBinding:
      position: 101
      prefix: -list
  - id: insert_size
    type:
      - 'null'
      - boolean
    doc: summarize insert size data
    inputBinding:
      position: 101
      prefix: -insert
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
stdout: bamtools_stats.out
