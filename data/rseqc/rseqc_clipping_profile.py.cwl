cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- clipping_profile.py
label: rseqc_clipping_profile.py
doc: 'Estimate clipping profile of RNA-seq reads from BAM or SAM file. CIGAR strings
  within the SAM/BAM file should have the ''S'' operation (the read mapper should
  support clipped mapping).


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  doc: Alignment file in BAM or SAM format.
  inputBinding:
    position: 1
    prefix: --input-file
- id: out_prefix
  type: string
  doc: Prefix of output files(s).
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality (phred scaled) for an alignment to be considered as
    "uniquely mapped". default=30
  inputBinding:
    position: 1
    prefix: --mapq
- id: sequencing
  type: string
  doc: Sequencing layout. "SE"(single-end) or "PE"(pair-end).
  inputBinding:
    position: 1
    prefix: --sequencing
outputs:
- id: clipping_profile_xls
  type: File
  doc: Table of clipped nucleotides per read position.
  outputBinding:
    glob: $(inputs.out_prefix).clipping_profile.xls
- id: clipping_profile_r
  type: File
  doc: R script that draws the clipping profile.
  outputBinding:
    glob: $(inputs.out_prefix).clipping_profile.r
- id: clipping_profile_pdf
  type:
    type: array
    items: File
  doc: 'Clipping profile plot(s): one PDF for SE, R1 and R2 PDFs for PE.'
  outputBinding:
    glob: $(inputs.out_prefix).clipping_profile*.pdf
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
