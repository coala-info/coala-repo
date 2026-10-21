cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bam2fq.py
label: rseqc_bam2fq.py
doc: 'Convert alignments in BAM or SAM format into fastq format.


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
  doc: Prefix of output fastq files(s).
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: single_end
  type:
  - 'null'
  - boolean
  doc: Specificy '-s' or '--single-end' for single-end sequencing.
  inputBinding:
    position: 1
    prefix: --single-end
- id: compress
  type:
  - 'null'
  - boolean
  doc: Specificy '-c' or '--compress' to compress output fastq file(s) using 'gzip'
    command.
  inputBinding:
    position: 1
    prefix: --compress
outputs:
- id: fastq_files
  type:
    type: array
    items: File
  doc: 'Output fastq file(s): Prefix.fastq (single-end) or Prefix.R1.fastq and Prefix.R2.fastq
    (paired-end), gzip-compressed with --compress.'
  outputBinding:
    glob: $(inputs.out_prefix).*fastq*
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
