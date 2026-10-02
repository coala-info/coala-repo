cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_stat.py
label: rseqc_bam_stat.py
doc: Summarizing mapping statistics of a BAM or SAM file.
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Alignment file in BAM or SAM format.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality (phred scaled) to determine "uniquely mapped" 
      reads. default=30
    inputBinding:
      position: 101
      prefix: --mapq
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: bam_stat.py.out
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
