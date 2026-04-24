cwlVersion: v1.2
class: CommandLineTool
baseCommand: sinto_blocks
label: sinto_blocks
doc: "Create scRNA-seq block file from BAM file\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam_file
    type: File
    doc: Input bam file (must be indexed)
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcode_regex
    type:
      - 'null'
      - string
    doc: "Regular expression used to extract cell barcode from\n                 \
      \       read name. If None (default), extract cell barcode\n               \
      \         from read tag. Use \"[^:]*\" to match all characters up\n        \
      \                to the first colon."
    inputBinding:
      position: 101
      prefix: --barcode_regex
  - id: barcode_tag
    type:
      - 'null'
      - string
    doc: "Read tag storing cell barcode information (default =\n                 \
      \       \"CB\")"
    inputBinding:
      position: 101
      prefix: --barcodetag
  - id: cells
    type:
      - 'null'
      - string
    doc: "Path to file containing cell barcodes to retain, or a\n                \
      \        comma-separated list of cell barcodes. If None\n                  \
      \      (default), use all cell barocodes present in the BAM\n              \
      \          file."
    inputBinding:
      position: 101
      prefix: --cells
  - id: include_strand
    type:
      - 'null'
      - boolean
    doc: Include strand information in output file
    inputBinding:
      position: 101
      prefix: --strand
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum MAPQ required to retain read (default = 30)
    inputBinding:
      position: 101
      prefix: --min_mapq
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processors (default = 1)
    inputBinding:
      position: 101
      prefix: --nproc
  - id: umi_tag
    type:
      - 'null'
      - string
    doc: "Read tag storing UMI barcode information (default =\n                  \
      \      \"UB\")"
    inputBinding:
      position: 101
      prefix: --umitag
outputs:
  - id: blocks_file
    type: File
    doc: "Name and path for output blocks file. Note that the\n                  \
      \      output is not sorted or compressed. To sort the output\n            \
      \            file use sort -k 1,1 -k2,2n"
    outputBinding:
      glob: $(inputs.blocks_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
