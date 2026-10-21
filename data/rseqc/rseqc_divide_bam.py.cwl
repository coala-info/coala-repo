cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- divide_bam.py
label: rseqc_divide_bam.py
doc: 'Equally divide BAM file (m alignments) into n parts. Each part contains roughly
  m/n alignments that are randomly sampled from total alignments.


  Tool homepage: https://rseqc.sourceforge.net'
inputs:
- id: input_file
  type: File
  secondaryFiles:
  - pattern: .bai
    required: false
  doc: Alignment file in BAM format. BAM file should be sorted and indexed.
  inputBinding:
    position: 1
    prefix: --input-file
- id: subset_num
  type: int
  doc: Number of small BAM files
  inputBinding:
    position: 1
    prefix: --subset-num
- id: out_prefix
  type: string
  doc: Prefix of output BAM files. Output "Prefix_num.bam".
  inputBinding:
    position: 1
    prefix: --out-prefix
- id: skip_unmap
  type:
  - 'null'
  - boolean
  doc: Skip unmapped reads.
  inputBinding:
    position: 1
    prefix: --skip-unmap
outputs:
- id: subset_bams
  type:
    type: array
    items: File
  doc: The small BAM files Prefix_0.bam, Prefix_1.bam, ... Prefix_(n-1).bam.
  outputBinding:
    glob: $(inputs.out_prefix)_*.bam
- id: stdout
  type: stdout
  doc: Number of alignments written to each small BAM file.
stdout: divide_bam.out
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
