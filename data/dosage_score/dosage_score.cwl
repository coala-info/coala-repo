cwlVersion: v1.2
class: CommandLineTool
baseCommand: dosage_score
label: dosage_score
doc: "Dosage-score pipeline 2023/8/21\n\nTool homepage: https://github.com/SegawaTenta/Dosage-score"
inputs:
  - id: bam_info
    type: File
    doc: 'BAM info file: tab separated sample name, BAM path, Control/Test, genome
      names. Give the BAM paths as the basenames of the bam_files input.'
    inputBinding:
      position: 101
      prefix: --bam_info
  - id: genome_info
    type: File
    doc: Genome info file.
    inputBinding:
      position: 101
      prefix: --genome_info
  - id: link_file
    type:
      - 'null'
      - File
    doc: Link file compared between 2 genome fasta.
    inputBinding:
      position: 101
      prefix: --link_file
  - id: minBQ
    type:
      - 'null'
      - int
    doc: Minimum base quality for a base to be considered.
    inputBinding:
      position: 101
      prefix: --minBQ
  - id: minMQ
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for an alignment to be used.
    inputBinding:
      position: 101
      prefix: --minMQ
  - id: output_dir
    type: string
    doc: Output directory.
    inputBinding:
      position: 101
      prefix: --output_dir
  - id: ref_fa1
    type: File
    doc: Referance fasta file (with its .fai index).
    secondaryFiles:
      - .fai
    inputBinding:
      position: 101
      prefix: --ref_fa1
  - id: ref_fa2
    type:
      - 'null'
      - File
    doc: Masked referance fasta file.
    inputBinding:
      position: 101
      prefix: --ref_fa2
  - id: step_size
    type:
      - 'null'
      - int
    doc: Minumum plot in window size.
    inputBinding:
      position: 101
      prefix: --step_size
  - id: thread
    type:
      - 'null'
      - int
    doc: Thread.
    inputBinding:
      position: 101
      prefix: --thread
  - id: window_size
    type:
      - 'null'
      - int
    doc: Minumum plot in window size.
    inputBinding:
      position: 101
      prefix: --window_size
  - id: bam_files
    type:
      type: array
      items: File
    doc: BAM files (with .bai index) named in the BAM info file; staged in the 
      working directory so the names in the BAM info file resolve.
    secondaryFiles:
      - .bai
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.bam_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dosage_score:1.0.0--pyhdfd78af_0
stdout: dosage_score.out
