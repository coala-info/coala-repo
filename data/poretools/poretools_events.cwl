cwlVersion: v1.2
class: CommandLineTool
baseCommand: poretools_events
label: poretools_events
doc: "Report pre-basecalled events\n\nTool homepage: https://github.com/arq5x/poretools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: The input FAST5 files.
    inputBinding:
      position: 1
  - id: pre_basecalled
    type:
      - 'null'
      - boolean
    doc: Report pre-basecalled events
    inputBinding:
      position: 102
      prefix: --pre-basecalled
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
    dockerPull: quay.io/biocontainers/poretools:0.6.1a0--py27_0
stdout: poretools_events.out
