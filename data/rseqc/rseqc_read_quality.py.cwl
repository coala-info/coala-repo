cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_quality.py]
label: rseqc_read_quality.py
doc: "Calculate the Phred quality score for each position on the read. Each read should have the same fixed length.\n\nTool homepage: https://rseqc.sourceforge.net"
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
  - id: reduce
    type:
      - 'null'
      - int
    doc: "To avoid making huge vector in R, nucleotide with particular phred score less frequent than this number will be ignored. Increase this number save more memory while reduce precision. Set to 1 achieves maximum precision (i.e. every nucleotide will be considered). This option only applies to the 'boxplot'. default=1"
    inputBinding:
      position: 1
      prefix: --reduce
  - id: map_qual
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality (phred scaled) for an alignment to be called \"uniquely mapped\". default=30"
    inputBinding:
      position: 1
      prefix: --mapq
outputs:
  - id: qual_r
    type: File
    doc: "R script of the quality plots."
    outputBinding:
      glob: "$(inputs.output_prefix).qual.r"
  - id: qual_boxplot
    type: File
    doc: "Quality boxplot."
    outputBinding:
      glob: "$(inputs.output_prefix).qual.boxplot.pdf"
  - id: qual_heatmap
    type: File
    doc: "Quality heatmap."
    outputBinding:
      glob: "$(inputs.output_prefix).qual.heatmap.pdf"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
