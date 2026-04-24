cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-process_pacbio.py
label: amptk_pacbio
doc: "Script to process pacbio CCS amplicon data\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: barcodes_fasta
    type: File
    doc: Barcodes FASTA file
    inputBinding:
      position: 101
      prefix: --barcodes
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. Default: auto'
    inputBinding:
      position: 101
      prefix: --cpus
  - id: fwd_primer
    type:
      - 'null'
      - string
    doc: Forward Primer
    inputBinding:
      position: 101
      prefix: --fwd_primer
  - id: input_bam_dir
    type: Directory
    doc: Input directory containing Lima BAM files
    inputBinding:
      position: 101
      prefix: --bam
  - id: int_primer
    type:
      - 'null'
      - string
    doc: Internal primer
    inputBinding:
      position: 101
      prefix: --int_primer
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length to keep
    inputBinding:
      position: 101
      prefix: --min_len
  - id: output_basename
    type: string
    doc: Output basename
    inputBinding:
      position: 101
      prefix: --out
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in primer
    inputBinding:
      position: 101
      prefix: --primer_mismatch
  - id: rev_primer
    type:
      - 'null'
      - string
    doc: Reverse Primer
    inputBinding:
      position: 101
      prefix: --rev_primer
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_pacbio.out
