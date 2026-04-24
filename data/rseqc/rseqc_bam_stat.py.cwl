cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam_stat.py
label: rseqc_bam_stat.py
doc: "Summarizing mapping statistics of a BAM file.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_file
    type: File
    doc: Alignment file in BAM or SAM format.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality (phred scaled) for an alignment to be called 'uniquely
      mapped'.
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
stdout: rseqc_bam_stat.py.out
