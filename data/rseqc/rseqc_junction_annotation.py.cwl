cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- junction_annotation.py
label: rseqc_junction_annotation.py
doc: 'Annotate splicing reads against a gene model in two levels: reads level and
  junction level.

  Note:

  1) A read, especially long read, can be spliced 2 or more times

  2) Multiple splicing reads spanning the same intron can be consolidated into one
  splicing junction.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  doc: Alignment file in BAM or SAM format.
  inputBinding:
    position: 1
    prefix: --input-file
- id: refgene
  type: File
  doc: Reference gene model in bed format. This file is better to be a pooled gene
    model as it will be used to annotate splicing junctions [required]
  inputBinding:
    position: 1
    prefix: --refgene
- id: out_prefix
  type: string
  doc: Prefix of output files(s). [required]
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: min_intron
  type:
  - 'null'
  - int
  doc: Minimum intron length (bp). default=50 [optional]
  inputBinding:
    position: 1
    prefix: --min-intron
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality (phred scaled) for an alignment to be considered as
    "uniquely mapped". default=30
  inputBinding:
    position: 1
    prefix: --mapq
outputs:
- id: junction_xls
  type: File
  doc: Table of splice junctions with annotation status and read counts.
  outputBinding:
    glob: $(inputs.out_prefix).junction.xls
- id: junction_r
  type: File
  doc: R script that draws the junction plots.
  outputBinding:
    glob: $(inputs.out_prefix).junction_plot.r
- id: junction_bed
  type:
  - 'null'
  - File
  doc: BED12 file of the splice junctions.
  outputBinding:
    glob: $(inputs.out_prefix).junction.bed
- id: junction_interact_bed
  type:
  - 'null'
  - File
  doc: Interact-format BED file of the splice junctions.
  outputBinding:
    glob: $(inputs.out_prefix).junction.Interact.bed
- id: splice_events_pdf
  type: File
  doc: Pie chart of splice events.
  outputBinding:
    glob: $(inputs.out_prefix).splice_events.pdf
- id: splice_junction_pdf
  type: File
  doc: Pie chart of splice junctions.
  outputBinding:
    glob: $(inputs.out_prefix).splice_junction.pdf
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
