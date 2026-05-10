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
    inputBinding:
      position: 102
      prefix: --insertsize
  - id: quality
    type:
      - 'null'
      - int
    doc: min. mapping quality
    inputBinding:
      position: 102
      prefix: --quality
  - id: outfile_path
    type: string
    doc: Output or path parameter `outfile_path`
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: gzipped output file
    outputBinding:
      glob: $(inputs.outfile_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
