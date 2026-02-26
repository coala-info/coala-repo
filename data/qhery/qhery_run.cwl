cwlVersion: v1.2
class: CommandLineTool
baseCommand: qhery run
label: qhery_run
doc: "Run the QHERY pipeline.\n\nTool homepage: http://github.com/mjsull/qhery/"
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
    type: Directory
    doc: Directory with latest Stanford resistance database.
    inputBinding:
      position: 101
      prefix: --database_dir
  - id: download
    type:
      - 'null'
      - boolean
    doc: Download the latest database.
    inputBinding:
      position: 101
      prefix: --download
  - id: download_nextclade_data
    type:
      - 'null'
      - boolean
    doc: download nextclade data.
    inputBinding:
      position: 101
      prefix: --download_nextclade_data
  - id: fasta
    type:
      - 'null'
      - File
    doc: Consensus fasta.
    inputBinding:
      position: 101
      prefix: --fasta
  - id: lineage
    type:
      - 'null'
      - string
    doc: Lineage report of variants.
    inputBinding:
      position: 101
      prefix: --lineage
  - id: nextclade_data
    type:
      - 'null'
      - Directory
    doc: directory of sars-cov-2 nextclade data, can be downloaded with 
      "nextclade dataset get --name 'sars-cov-2' --output-dir 'data/sars-cov-2'"
    inputBinding:
      position: 101
      prefix: --nextclade_data
  - id: pipeline_dir
    type: Directory
    doc: Pipeline to run program in.
    inputBinding:
      position: 101
      prefix: --pipeline_dir
  - id: rx_list
    type:
      - 'null'
      - type: array
        items: string
    doc: List of drugs to analyze.
    inputBinding:
      position: 101
      prefix: --rx_list
  - id: sample_name
    type: string
    doc: Sample name.
    inputBinding:
      position: 101
      prefix: --sample_name
  - id: vcf
    type:
      - 'null'
      - File
    doc: vcf file
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
stdout: qhery_run.out
