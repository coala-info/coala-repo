cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, alignments, filter-bam]
label: pore-c_alignments_filter-bam
doc: "Filter a BAM file using a pore-C table.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: clean_read_name
    type:
      - 'null'
      - boolean
    doc: "Strip out the extra information placed in the BAM by reformat-bam"
    inputBinding:
      position: 1
      prefix: --clean-read-name
  - id: input_bam
    type: File
    doc: "Input BAM file"
    inputBinding:
      position: 10
  - id: pore_c_table
    type: File
    doc: "Pore-C table (parquet)"
    inputBinding:
      position: 11
  - id: output_bam
    type: string
    doc: "Output BAM file name"
    inputBinding:
      position: 12
outputs:
  - id: filtered_bam
    type: File
    doc: "Filtered BAM file"
    outputBinding:
      glob: "$(inputs.output_bam)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
