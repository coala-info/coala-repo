cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - artic
  - guppyplex
label: artic_guppyplex
doc: "Basecalled and demultiplexed (guppy) results directory\n\nTool homepage: https://github.com/artic-network/fieldbioinformatics"
inputs:
  - id: directory
    type: Directory
    doc: Basecalled and demultiplexed (guppy) results directory
    inputBinding:
      position: 101
      prefix: --directory
  - id: max_length
    type:
      - 'null'
      - int
    doc: remove reads greater than read length
    inputBinding:
      position: 101
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: remove reads less than read length
    inputBinding:
      position: 101
      prefix: --min-length
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for guppyplex files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quality
    type:
      - 'null'
      - int
    doc: remove reads against this quality filter
    inputBinding:
      position: 101
      prefix: --quality
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: sample
    type:
      - 'null'
      - int
    doc: "sampling frequency for random sample of sequence to\n                  \
      \      reduce excess"
    inputBinding:
      position: 101
      prefix: --sample
  - id: skip_quality_check
    type:
      - 'null'
      - boolean
    doc: Do not filter on quality score (speeds up)
    inputBinding:
      position: 101
      prefix: --skip-quality-check
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: FASTQ file to write
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
