cwlVersion: v1.2
class: CommandLineTool
baseCommand: qhery_mutations
label: qhery_mutations
doc: "Analyze mutations using the qhery tool.\n\nTool homepage: http://github.com/mjsull/qhery/"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: bam file
    inputBinding:
      position: 101
      prefix: --bam
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory with latest Stanford resistance database.
    inputBinding:
      position: 101
      prefix: --database_dir
  - id: lineage
    type:
      - 'null'
      - string
    doc: Lineage report of variants.
    inputBinding:
      position: 101
      prefix: --lineage
  - id: pipeline_dir
    type:
      - 'null'
      - Directory
    doc: Pipeline to run program in.
    inputBinding:
      position: 101
      prefix: --pipeline_dir
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: vcf
    type:
      - 'null'
      - type: array
        items: File
    doc: List of VCF files
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qhery:0.1.2--pyhdfd78af_0
stdout: qhery_mutations.out
