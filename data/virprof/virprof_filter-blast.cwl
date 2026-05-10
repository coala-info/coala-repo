cwlVersion: v1.2
class: CommandLineTool
baseCommand: virprof filter-blast
label: virprof_filter-blast
doc: "Filter sequences based on blast hits\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: in_blast7
    type: File
    doc: input blast7 format file
    inputBinding:
      position: 101
      prefix: --in-blast7
  - id: in_fasta
    type: File
    doc: input blast7 format file
    inputBinding:
      position: 101
      prefix: --in-fasta
  - id: max_aligned_bp
    type:
      - 'null'
      - int
    doc: maximum number of aligned basepairs
    inputBinding:
      position: 101
      prefix: --max-aligned-bp
  - id: min_unaligned_bp
    type:
      - 'null'
      - int
    doc: minimum number of unaligned basepairs
    inputBinding:
      position: 101
      prefix: --min-unaligned-bp
  - id: out_path
    type: string
    doc: Output CSV file containing final calls (one row
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type: File
    doc: output blast7 format file
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
