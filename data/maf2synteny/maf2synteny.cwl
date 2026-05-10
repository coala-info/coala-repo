cwlVersion: v1.2
class: CommandLineTool
baseCommand: maf2synteny
label: maf2synteny
doc: "A tool for constructing synteny blocks from multiple alignments in MAF format.\n\
  \ \nTool homepage: https://github.com/fenderglass/maf2synteny"
inputs:
  - id: maf_file
    type: File
    doc: Input MAF file containing multiple alignments
    inputBinding:
      position: 1
  - id: block_sizes
    type:
      - 'null'
      - string
    doc: Minimum block sizes (comma-separated list of integers)
    inputBinding:
      position: 102
      prefix: --block-sizes
  - id: simplify
    type:
      - 'null'
      - boolean
    doc: Simplify blocks
    inputBinding:
      position: 102
      prefix: --simplify
  - id: out_dir_path
    type: Directory
    doc: Output or path parameter `out_dir_path`
    inputBinding:
      position: 103
      prefix: --out-dir
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for synteny blocks
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/maf2synteny:1.2--h9948957_5
