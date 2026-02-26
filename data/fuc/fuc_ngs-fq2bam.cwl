cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc ngs-fq2bam
label: fuc_ngs-fq2bam
doc: "Pipeline for converting FASTQ files to analysis-ready BAM files.\n\nTool homepage:
  https://github.com/sbslee/fuc"
inputs:
  - id: manifest
    type: File
    doc: Sample manifest CSV file.
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Reference FASTA file.
    inputBinding:
      position: 2
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 3
  - id: java
    type: string
    doc: Java resoruce to request for GATK.
    inputBinding:
      position: 4
  - id: vcf
    type:
      type: array
      items: File
    doc: One or more reference VCF files containing known variant sites (e.g. 
      1000 Genomes Project).
    inputBinding:
      position: 5
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file.
    inputBinding:
      position: 106
      prefix: --bed
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 106
      prefix: --force
  - id: job
    type:
      - 'null'
      - string
    doc: Job submission ID for SGE.
    inputBinding:
      position: 106
      prefix: --job
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep temporary files.
    inputBinding:
      position: 106
      prefix: --keep
  - id: platform
    type:
      - 'null'
      - string
    doc: Sequencing platform
    default: Illumina
    inputBinding:
      position: 106
      prefix: --platform
  - id: qsub
    type:
      - 'null'
      - string
    doc: SGE resoruce to request for qsub.
    inputBinding:
      position: 106
      prefix: --qsub
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 1
    inputBinding:
      position: 106
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_ngs-fq2bam.out
