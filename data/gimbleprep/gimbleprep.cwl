cwlVersion: v1.2
class: CommandLineTool
baseCommand: gimbleprep
label: gimbleprep
doc: "Prepare data for GIMBLE\n\nTool homepage: https://github.com/LohseLab/gimbleprep"
inputs:
  - id: bam_dir
    type: Directory
    doc: Directory containing all BAM files (each with its .bai index and a
      readgroup sample ID)
    inputBinding:
      position: 101
      prefix: --bam_dir
  - id: fasta_file
    type: File
    doc: FASTA file
    secondaryFiles:
      - pattern: .fai
        required: true
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
    type: string
    default: gimble
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
    doc: VCF file (raw), bgzip-compressed and tabix-indexed
    secondaryFiles:
      - pattern: .tbi
        required: true
    inputBinding:
      position: 101
      prefix: --vcf_file
outputs:
  - id: genome_file
    type: File
    doc: Genome file (sequence_id, length) based on the FASTA file
    outputBinding:
      glob: $(inputs.outprefix).genomefile
  - id: sample_file
    type: File
    doc: Sample file (sample_id) based on the readgroup IDs in the BAM files
    outputBinding:
      glob: $(inputs.outprefix).samples.csv
  - id: coverage_summary
    type: File
    doc: Coverage threshold report for each BAM file
    outputBinding:
      glob: $(inputs.outprefix).coverage_summary.csv
  - id: gimble_vcf
    type: File
    doc: Filtered VCF file that complies with gimble data requirements
    secondaryFiles:
      - pattern: .tbi
        required: true
    outputBinding:
      glob: $(inputs.outprefix).vcf.gz
  - id: gimble_bed
    type: File
    doc: BED file of callable regions with the samples that are covered
    outputBinding:
      glob: $(inputs.outprefix).bed
  - id: log_file
    type: File
    doc: Log of executed commands
    outputBinding:
      glob: $(inputs.outprefix).log.txt
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimbleprep:0.0.2--pyhdfd78af_0
stdout: gimbleprep.out
