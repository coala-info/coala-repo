cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakranger
  - lc
label: peakranger_lc
doc: Calculate library complexity of a BAM file
inputs:
  - id: data_file
    type: File
    doc: the data file
    inputBinding:
      position: 101
      prefix: --data
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress when possible
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakranger:1.18--hdcf5f25_9
stdout: peakranger_lc.out
