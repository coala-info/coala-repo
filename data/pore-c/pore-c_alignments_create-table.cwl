cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, alignments, create-table]
label: pore-c_alignments_create-table
doc: "Convert a BAM file to a tabular format sorted by read for downstream analysis.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: alignment_haplotypes
    type:
      - 'null'
      - File
    doc: "The alignment to haplotype mapping from whatshap"
    inputBinding:
      position: 1
      prefix: --alignment-haplotypes
  - id: input_bam
    type: File
    doc: "Input BAM file"
    inputBinding:
      position: 10
  - id: output_table
    type: string
    doc: "Output alignment table (parquet)"
    inputBinding:
      position: 11
outputs:
  - id: align_table
    type: File
    doc: "Alignment table (parquet)"
    outputBinding:
      glob: "$(inputs.output_table)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
