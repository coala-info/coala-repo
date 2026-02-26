cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - add_uid
label: umis_add_uid
doc: "Adds UID:[samplebc cellbc umi] to readname for umi-tools deduplication\n  Expects
  formatted fastq files with correct sample and cell barcodes.\n\nTool homepage: https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: FASTQ file
    inputBinding:
      position: 1
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of cores to use
    inputBinding:
      position: 102
      prefix: --cores
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_add_uid.out
