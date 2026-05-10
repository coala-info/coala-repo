cwlVersion: v1.2
class: CommandLineTool
baseCommand: blockclust
label: blockclust
doc: "Efficient clustering and classification of non-coding RNAs from short read RNA-seq
  profiles\n\nTool homepage: https://github.com/pavanvidem/blockclust"
inputs:
  - id: accept
    type:
      - 'null'
      - string
    doc: accept annotations
    inputBinding:
      position: 101
      prefix: --accept
  - id: config
    type:
      - 'null'
      - File
    doc: config file
    inputBinding:
      position: 101
      prefix: --config
  - id: in
    type:
      - 'null'
      - File
    doc: blockbuster output
    inputBinding:
      position: 101
      prefix: --in
  - id: reject
    type:
      - 'null'
      - string
    doc: reject annotations
    inputBinding:
      position: 101
      prefix: --reject
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: output dir
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blockclust:1.1.1--py311r43h2a4ad6c_1
