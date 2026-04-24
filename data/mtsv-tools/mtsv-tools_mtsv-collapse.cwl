cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-collapse
label: mtsv-tools_mtsv-collapse
doc: "Tool for combining the output of multiple separate mtsv runs.\n\nTool homepage:
  https://github.com/FofanovLab/mtsv_tools"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Path(s) to mtsv results files to collapse
    inputBinding:
      position: 1
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Collapse mode: taxid (min edit per taxid) or taxid-gi (min edit per taxid-gi).'
    inputBinding:
      position: 102
      prefix: --mode
  - id: report
    type:
      - 'null'
      - File
    doc: Write per-taxid stats TSV report.
    inputBinding:
      position: 102
      prefix: --report
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads for sorting.
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Include this flag to trigger debug-level logging.
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output
    type: File
    doc: Path to write combined outupt file to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
