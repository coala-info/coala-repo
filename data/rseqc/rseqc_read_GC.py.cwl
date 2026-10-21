cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_GC.py]
label: rseqc_read_GC.py
doc: "Calculate the distribution of reads' GC content.\n\nTool homepage: https://rseqc.sourceforge.net"
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
  - id: map_qual
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality (phred scaled) for an alignment to be called \"uniquely mapped\". default=30"
    inputBinding:
      position: 1
      prefix: --mapq
outputs:
  - id: gc_xls
    type: File
    doc: "GC content table."
    outputBinding:
      glob: "$(inputs.output_prefix).GC.xls"
  - id: gc_plot_r
    type: File
    doc: "R script of the GC content plot."
    outputBinding:
      glob: "$(inputs.output_prefix).GC_plot.r"
  - id: gc_plot_pdf
    type: File
    doc: "GC content plot."
    outputBinding:
      glob: "$(inputs.output_prefix).GC_plot.pdf"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
