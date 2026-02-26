cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - mb_filter
label: umis_mb_filter
doc: "Filters umis with non-ACGT bases Expects formatted fastq files.\n\nTool homepage:
  https://github.com/vals/umis"
inputs:
  - id: fastq
    type: File
    doc: FASTQ file to filter
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
stdout: umis_mb_filter.out
