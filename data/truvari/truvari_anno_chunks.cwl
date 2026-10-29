cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - chunks
label: truvari_anno_chunks
doc: "Count the number of variants in each chunk. Column 3: total number of variants; column 4: comma-delimited number of sub-chunks after accounting for size; column 5: comma-delimited number of sub-chunks after accounting for size and distance again\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: bed
    type:
      - 'null'
      - File
    doc: Bed file of variants to chunk
    inputBinding:
      position: 1
      prefix: "-b"
  - id: output
    type:
      - 'null'
      - string
    default: chunks.bed
    doc: Output name
    inputBinding:
      position: 1
      prefix: "-o"
  - id: chunksize
    type:
      - 'null'
      - int
    doc: Distance between variants to split chunks (500)
    inputBinding:
      position: 1
      prefix: "-c"
  - id: sizemin
    type:
      - 'null'
      - int
    doc: Minimum SV length (50)
    inputBinding:
      position: 1
      prefix: "-s"
  - id: sizemax
    type:
      - 'null'
      - int
    doc: Maximum SV length (50000)
    inputBinding:
      position: 1
      prefix: "-S"
  - id: input
    type: File
    doc: Input VCF
    inputBinding:
      position: 2
outputs:
  - id: output_bed
    type: File
    doc: Chunk boundaries and variant counts
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
