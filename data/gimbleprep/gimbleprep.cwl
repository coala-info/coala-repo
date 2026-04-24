cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimbleprep
label: gimbleprep
doc: "Prepare data for GIMBLE\n\nTool homepage: https://github.com/LohseLab/gimbleprep"
inputs:
  - id: bam_dir
    type: Directory
    doc: Directory containing all BAM files
    inputBinding:
      position: 101
      prefix: --bam_dir
  - id: fasta_file
    type: File
    doc: FASTA file
    inputBinding:
      position: 101
      prefix: --fasta_file
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete temporary files
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: max_depth
    type:
      - 'null'
      - float
    doc: Max read depth (as multiple of mean coverage of each BAM)
    inputBinding:
      position: 101
      prefix: --max_depth
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Min read depth
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_qual
    type:
      - 'null'
      - int
    doc: Minimum PHRED quality
    inputBinding:
      position: 101
      prefix: --min_qual
  - id: outprefix
    type:
      - 'null'
      - string
    doc: Outprefix
    inputBinding:
      position: 101
      prefix: --outprefix
  - id: snpgap
    type:
      - 'null'
      - int
    doc: SnpGap
    inputBinding:
      position: 101
      prefix: --snpgap
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf_file
    type: File
    doc: VCF file (raw)
    inputBinding:
      position: 101
      prefix: --vcf_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimbleprep:0.0.2--pyhdfd78af_0
stdout: gimbleprep.out
