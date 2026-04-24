cwlVersion: v1.2
class: CommandLineTool
baseCommand: tepid-discover
label: tepid_tepid-discover
doc: "TEPID (Transposable Element Polymorphism Identification Detector) discovery
  step. Identifies transposable element polymorphisms (insertions and deletions) using
  split-read and discordant read pair analysis.\n\nTool homepage: https://github.com/ListerLab/TEPID"
inputs:
  - id: bam_file
    type: File
    doc: Coordinate sorted BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: insert_size
    type:
      - 'null'
      - int
    doc: Average insert size
    inputBinding:
      position: 101
      prefix: --insert
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Number of mismatches allowed
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: processors
    type:
      - 'null'
      - int
    doc: Number of processors to use
    inputBinding:
      position: 101
      prefix: --processor
  - id: reference_fasta
    type: File
    doc: Reference genome fasta file
    inputBinding:
      position: 101
      prefix: --ref
  - id: sample_name
    type: string
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --name
  - id: split_reads_bam
    type: File
    doc: Split reads BAM file
    inputBinding:
      position: 101
      prefix: --split
  - id: standard_deviation
    type:
      - 'null'
      - int
    doc: Standard deviation of insert size
    inputBinding:
      position: 101
      prefix: --sd
  - id: te_bed
    type: File
    doc: TE annotation bed file
    inputBinding:
      position: 101
      prefix: --te_bed
  - id: te_ref_fasta
    type: File
    doc: TE reference fasta file
    inputBinding:
      position: 101
      prefix: --te_ref
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tepid:0.10--py_0
stdout: tepid_tepid-discover.out
