cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_duplication.py]
label: rseqc_read_duplication.py
doc: "Calculate reads' duplication rate. Sequence-based: reads with identical sequence are duplicates. Mapping-based: reads mapped to the exact same location are duplicates.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_file
    type: File
    doc: "Alignment file in BAM or SAM format."
    inputBinding:
      position: 1
      prefix: --input-file
  - id: output_prefix
    type: string
    doc: "Prefix of output files(s)."
    inputBinding:
      position: 1
      prefix: --out-prefix
  - id: up_limit
    type:
      - 'null'
      - int
    doc: "Upper limit of reads' occurrence. Only used for plotting, default=500 (times)"
    inputBinding:
      position: 1
      prefix: --up-limit
  - id: map_qual
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality (phred scaled) for an alignment to be considered as \"uniquely mapped\". default=30"
    inputBinding:
      position: 1
      prefix: --mapq
outputs:
  - id: pos_dup_rate
    type: File
    doc: "Mapping-based duplication rate table."
    outputBinding:
      glob: "$(inputs.output_prefix).pos.DupRate.xls"
  - id: seq_dup_rate
    type: File
    doc: "Sequence-based duplication rate table."
    outputBinding:
      glob: "$(inputs.output_prefix).seq.DupRate.xls"
  - id: dup_plot_r
    type: File
    doc: "R script of the duplication plot."
    outputBinding:
      glob: "$(inputs.output_prefix).DupRate_plot.r"
  - id: dup_plot_pdf
    type: File
    doc: "Duplication rate plot."
    outputBinding:
      glob: "$(inputs.output_prefix).DupRate_plot.pdf"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
