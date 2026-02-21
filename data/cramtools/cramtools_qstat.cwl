cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cramtools
  - qstat
label: cramtools_qstat
doc: "Quality statistics for CRAM or BAM files\n\nTool homepage: https://github.com/enasequence/cramtools"
inputs:
  - id: default_quality_score
    type:
      - 'null'
      - int
    doc: Use this value as a default or missing quality score. Lowest is 0, which
      corresponds to '!' in fastq.
    default: 30
    inputBinding:
      position: 101
      prefix: --default-quality-score
  - id: input_file
    type:
      - 'null'
      - File
    doc: The path to the CRAM or BAM file.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Change log level: DEBUG, INFO, WARNING, ERROR.'
    default: ERROR
    inputBinding:
      position: 101
      prefix: --log-level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cramtools:3.0.b127--0
stdout: cramtools_qstat.out
