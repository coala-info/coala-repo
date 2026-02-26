cwlVersion: v1.2
class: CommandLineTool
baseCommand: kyber
label: kyber
doc: "Tool to create a length-accuracy heatmap from a cram or bam file\n\nTool homepage:
  https://github.com/wdecoster/kyber"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: cram or bam file(s), or use `-` to read a file from stdin with e.g. 
      samtools view -h
    inputBinding:
      position: 1
  - id: background
    type:
      - 'null'
      - string
    doc: 'Color used for background [possible values: black, white]'
    default: black
    inputBinding:
      position: 102
      prefix: --background
  - id: color
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Color used for heatmap [possible values: red, green, blue, purple, yellow]'
    inputBinding:
      position: 102
      prefix: --color
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: Normalize the counts in each bin with a log2
    inputBinding:
      position: 102
      prefix: --normalize
  - id: phred
    type:
      - 'null'
      - boolean
    doc: Plot accuracy in phred scale
    inputBinding:
      position: 102
      prefix: --phred
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel decompression threads to use
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
  - id: ubam
    type:
      - 'null'
      - boolean
    doc: get reads from ubam file
    inputBinding:
      position: 102
      prefix: --ubam
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kyber:0.6.0d--ha6fb395_0
