cwlVersion: v1.2
class: CommandLineTool
baseCommand: PACU_map
label: pacu_snp_PACU_map
doc: "Map sequencing reads to a reference genome.\n\nTool homepage: https://github.com/BioinformaticsPlatformWIV-ISP/PACU"
inputs:
  - id: dir_working
    type:
      - 'null'
      - Directory
    doc: Working directory
    inputBinding:
      position: 101
      prefix: --dir-working
  - id: fastq_illumina
    type:
      - 'null'
      - type: array
        items: File
    doc: Illumina FASTQ files (pair)
    inputBinding:
      position: 101
      prefix: --fastq-illumina
  - id: fastq_illumina_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Original FASTQ names (used for Galaxy)
    inputBinding:
      position: 101
      prefix: --fastq-illumina-names
  - id: fastq_ont
    type:
      - 'null'
      - File
    doc: ONT FASTQ file
    inputBinding:
      position: 101
      prefix: --fastq-ont
  - id: fastq_ont_name
    type:
      - 'null'
      - string
    doc: Original FASTQ name (used for Galaxy)
    inputBinding:
      position: 101
      prefix: --fastq-ont-name
  - id: read_type
    type: string
    doc: Type of sequencing reads (ont or illumina)
    inputBinding:
      position: 101
      prefix: --read-type
  - id: ref_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --ref-fasta
  - id: ref_fasta_name
    type:
      - 'null'
      - string
    doc: Original FASTA file name (used for Galaxy)
    inputBinding:
      position: 101
      prefix: --ref-fasta-name
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Trim reads prior to mapping
    inputBinding:
      position: 101
      prefix: --trim
outputs:
  - id: output
    type: File
    doc: Output BAM file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pacu_snp:1.0.0--pyhdfd78af_0
