cwlVersion: v1.2
class: CommandLineTool
baseCommand: artic filter
label: artic_filter
doc: "Filter FASTQ reads based on length.\n\nTool homepage: https://github.com/artic-network/fieldbioinformatics"
inputs:
  - id: filename
    type: File
    doc: FASTQ file.
    inputBinding:
      position: 1
  - id: max_length
    type:
      - 'null'
      - int
    doc: remove reads greater than read length
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: remove reads less than read length
    inputBinding:
      position: 102
      prefix: --min-length
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
stdout: artic_filter.out
