cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakranger
  - nr
label: peakranger_nr
doc: Estimate ChIP-seq data quality (noise rate) from a data and a control file
inputs:
  - id: control_file
    type: File
    doc: control file
    inputBinding:
      position: 101
      prefix: --control
  - id: data_file
    type: File
    doc: data file
    inputBinding:
      position: 101
      prefix: --data
  - id: ext_length
    type:
      - 'null'
      - int
    doc: read extension length
    inputBinding:
      position: 101
      prefix: --ext_length
  - id: format
    type:
      - 'null'
      - string
    doc: 'the format of the data file, can be one of : bowtie, sam, bam and bed'
    inputBinding:
      position: 101
      prefix: --format
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
stdout: peakranger_nr.out
