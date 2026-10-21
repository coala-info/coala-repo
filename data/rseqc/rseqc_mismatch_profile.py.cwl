cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- mismatch_profile.py
label: rseqc_mismatch_profile.py
doc: 'Calculate the distribution of mismatches across reads. Note that the "MD" tag
  must exist in BAM file.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input
  type: File
  doc: Input BAM file. [required]
  inputBinding:
    position: 1
    prefix: --input
- id: read_align_length
  type: int
  doc: Alignment length of read. It is usually set to the orignial read length. For
    example, all these cigar strings ("101M", "68M140N33M", "53M1D48M") suggest the
    read alignment length is 101. [required]
  inputBinding:
    position: 1
    prefix: --read-align-length
- id: out_prefix
  type: string
  doc: Prefix of output files(s). [required]
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: read_num
  type:
  - 'null'
  - int
  doc: Number of aligned reads with mismatches used to calculate the mismatch profile.
    default=1000000
  inputBinding:
    position: 1
    prefix: --read-num
- id: mapq
  type:
  - 'null'
  - int
  doc: Minimum mapping quality. default=30
  inputBinding:
    position: 1
    prefix: --mapq
outputs:
- id: mismatch_profile_xls
  type: File
  doc: Table of mismatches per read position.
  outputBinding:
    glob: $(inputs.out_prefix).mismatch_profile.xls
- id: mismatch_profile_r
  type:
  - 'null'
  - File
  doc: R script that draws the mismatch profile.
  outputBinding:
    glob: $(inputs.out_prefix).mismatch_profile.r
- id: mismatch_profile_pdf
  type:
  - 'null'
  - File
  doc: Mismatch profile plot.
  outputBinding:
    glob: $(inputs.out_prefix).mismatch_profile.pdf
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
