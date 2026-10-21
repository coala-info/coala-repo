cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_NVC.py]
label: rseqc_read_NVC.py
doc: "For each nucleotide position of read (5'->3'), check the nucleotide frequency (NVC, Nucleotide Versus Cycle plot).\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_file
    type: File
    doc: "Input file in BAM or SAM format."
    inputBinding:
      position: 1
      prefix: --input-file
  - id: output_prefix
    type: string
    doc: "Prefix of output files(s)."
    inputBinding:
      position: 1
      prefix: --out-prefix
  - id: nx
    type:
      - 'null'
      - boolean
    doc: "Flag option. Presense of this flag tells program to include N,X in output NVC plot"
    inputBinding:
      position: 1
      prefix: --nx
  - id: map_qual
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality (phred scaled) for an alignment to be called \"uniquely mapped\". default=30"
    inputBinding:
      position: 1
      prefix: --mapq
outputs:
  - id: nvc_xls
    type: File
    doc: "Nucleotide frequency table per read position."
    outputBinding:
      glob: "$(inputs.output_prefix).NVC.xls"
  - id: nvc_plot_r
    type: File
    doc: "R script of the NVC plot."
    outputBinding:
      glob: "$(inputs.output_prefix).NVC_plot.r"
  - id: nvc_plot_pdf
    type: File
    doc: "NVC plot."
    outputBinding:
      glob: "$(inputs.output_prefix).NVC_plot.pdf"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
