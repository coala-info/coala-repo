cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - leviosam2
  - collate
label: leviosam2_collate
doc: "Collate alignments to make sure reads are paired\n\nTool homepage: https://github.com/milkschen/leviosam2"
inputs:
  - id: input_bam_a
    type: File
    doc: Path to the input SAM/BAM.
    inputBinding:
      position: 101
      prefix: -a
  - id: input_bam_b
    type:
      - 'null'
      - File
    doc: Path to the input deferred SAM/BAM.
    inputBinding:
      position: 101
      prefix: -b
  - id: input_fastq
    type:
      - 'null'
      - File
    doc: Path to the input singleton FASTQ.
    inputBinding:
      position: 101
      prefix: -q
  - id: output_prefix
    type: string
    doc: Prefix to the output files (1 BAM and a pair of gzipped FASTQs).
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level
    default: 0
    inputBinding:
      position: 101
      prefix: -V
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
stdout: leviosam2_collate.out
