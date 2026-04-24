cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustybam_bed-length
label: rustybam_bed-length
doc: "Count the number of bases in a bed file\n\nTool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: bed_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input bed file
    inputBinding:
      position: 1
  - id: column
    type:
      - 'null'
      - string
    doc: Count bases for each category in this column
    inputBinding:
      position: 102
      prefix: --column
  - id: readable
    type:
      - 'null'
      - boolean
    doc: Make the output human readable (Mbp)
    inputBinding:
      position: 102
      prefix: --readable
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_bed-length.out
