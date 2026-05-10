cwlVersion: v1.2
class: CommandLineTool
baseCommand: pxs2nex
label: phyx_pxs2nex
doc: "Convert seqfiles from nexus, phylip, or fastq to nexus. Can read from STDIN
  or file.\n\nTool homepage: https://github.com/FePhyFoFum/phyx"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: display phyx citation and exit
    inputBinding:
      position: 101
      prefix: --citation
  - id: seq_file
    type:
      - 'null'
      - File
    doc: input sequence file, STDIN otherwise
    inputBinding:
      position: 101
      prefix: --seqf
  - id: uppercase
    type:
      - 'null'
      - boolean
    doc: export characters in uppercase
    inputBinding:
      position: 101
      prefix: --uppercase
  - id: out_file_path
    type: string
    doc: Output or path parameter `out_file_path`
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: output sequence file, STOUT otherwise
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
