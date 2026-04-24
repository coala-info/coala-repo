cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools_stats
label: poretools_stats
doc: "Calculate and report statistics from FAST5 files.\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: full_tsv
    type:
      - 'null'
      - boolean
    doc: Verbose output in tab-separated format.
    inputBinding:
      position: 102
      prefix: --full-tsv
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not output warnings to stderr
    inputBinding:
      position: 102
      prefix: --quiet
  - id: type
    type:
      - 'null'
      - string
    doc: Which type of FASTQ entries should be reported?
    inputBinding:
      position: 102
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
stdout: poretools_stats.out
