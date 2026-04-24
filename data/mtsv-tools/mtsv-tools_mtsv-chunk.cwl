cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-chunk
label: mtsv-tools_mtsv-chunk
doc: "Split a FASTA reference database into chunks for index generation.\n\nTool homepage:
  https://github.com/FofanovLab/mtsv_tools"
inputs:
  - id: chunk_size_gb
    type: float
    doc: Chunk size (in gigabytes).
    inputBinding:
      position: 101
      prefix: --gb
  - id: debug_logging
    type:
      - 'null'
      - boolean
    doc: Include this flag to trigger debug-level logging.
    inputBinding:
      position: 101
      prefix: -v
  - id: input
    type: File
    doc: Path(s) to vedro results files to collapse
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: Directory
    doc: Folder path to write split output files to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
