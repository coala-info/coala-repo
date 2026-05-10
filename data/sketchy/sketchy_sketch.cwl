cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchy sketch
label: sketchy_sketch
doc: "Create a sketch from input sequences\n\nTool homepage: https://github.com/esteinig/sketchy"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Fast{a,q}.{gz,xz,bz}, stdin if not present
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: scale
    type:
      - 'null'
      - float
    doc: Hash scaler for finch format
    inputBinding:
      position: 101
      prefix: --scale
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed for hashing k-mers
    inputBinding:
      position: 101
      prefix: --seed
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: Sketch size
    inputBinding:
      position: 101
      prefix: --sketch-size
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output sketch file path
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
