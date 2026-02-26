cwlVersion: v1.2
class: CommandLineTool
baseCommand: fuc ngs-m2
label: fuc_ngs-m2
doc: "Pipeline for somatic short variant discovery.\n\nTool homepage: https://github.com/sbslee/fuc"
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
  - id: pon
    type: File
    doc: PoN VCF file.
    inputBinding:
      position: 4
  - id: germline
    type: File
    doc: Germline VCF file.
    inputBinding:
      position: 5
  - id: qsub
    type: string
    doc: SGE resoruce to request for qsub.
    inputBinding:
      position: 6
  - id: java
    type: string
    doc: Java resoruce to request for GATK.
    inputBinding:
      position: 7
  - id: bed_file
    type:
      - 'null'
      - File
    doc: BED file.
    inputBinding:
      position: 108
      prefix: --bed
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 108
      prefix: --force
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep temporary files.
    inputBinding:
      position: 108
      prefix: --keep
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_ngs-m2.out
