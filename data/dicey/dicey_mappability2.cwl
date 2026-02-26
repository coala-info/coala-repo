cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dicey
  - mappability2
label: dicey_mappability2
doc: "Calculate mappability of a BAM file\n\nTool homepage: https://github.com/gear-genomics/dicey"
inputs:
  - id: input_bam
    type: File
    doc: Chopped BAM file
    inputBinding:
      position: 1
  - id: chromosome
    type:
      - 'null'
      - string
    doc: chromosome name to process
    inputBinding:
      position: 102
      prefix: --chromosome
  - id: insertsize
    type:
      - 'null'
      - int
    doc: insert size
    default: 501
    inputBinding:
      position: 102
      prefix: --insertsize
  - id: quality
    type:
      - 'null'
      - int
    doc: min. mapping quality
    default: 10
    inputBinding:
      position: 102
      prefix: --quality
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: gzipped output file
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
