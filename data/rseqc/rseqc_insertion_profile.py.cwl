cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- insertion_profile.py
label: rseqc_insertion_profile.py
doc: 'Calculate the distributions of inserted nucleotides across reads. CIGAR strings
  within the SAM/BAM file should have the ''I'' operation.


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
- id: insertion_profile_xls
  type: File
  doc: Table of inserted nucleotides per read position.
  outputBinding:
    glob: $(inputs.out_prefix).insertion_profile.xls
- id: insertion_profile_r
  type: File
  doc: R script that draws the insertion profile.
  outputBinding:
    glob: $(inputs.out_prefix).insertion_profile.r
- id: insertion_profile_pdf
  type:
    type: array
    items: File
  doc: 'Insertion profile plot(s): one PDF for SE, R1 and R2 PDFs for PE.'
  outputBinding:
    glob: $(inputs.out_prefix).insertion_profile*.pdf
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
