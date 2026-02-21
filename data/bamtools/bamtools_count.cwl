cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - count
label: bamtools_count
doc: "prints number of alignments in BAM file(s).\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: the input BAM file(s) [stdin]
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
  - id: region
    type:
      - 'null'
      - string
    doc: genomic region. Index file is recommended for better performance, and is
      used automatically if it exists.
    inputBinding:
      position: 101
      prefix: -region
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
stdout: bamtools_count.out
