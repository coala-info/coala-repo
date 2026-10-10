cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtsv-reference
label: mtsv-tools_mtsv-reference
doc: "Extract reference sequences for taxids present in mtsv results.\n\nTool homepage: https://github.com/FofanovLab/mtsv_tools"
inputs:
  - id: taxids
    type:
      type: array
      items: int
    doc: Extract reference sequences for these taxids
    inputBinding:
      position: 1
  - id: index
    type: File
    doc: Path to the mtsv index file.
    inputBinding:
      prefix: --index
  - id: results_path
    type: string
    doc: Output file path (FASTA).
    inputBinding:
      prefix: --results
  - id: verbose
    type: ['null', boolean]
    doc: Include this flag to trigger debug-level logging.
    inputBinding:
      prefix: -v
outputs:
  - id: reference_fasta
    type: File
    doc: FASTA file with the reference sequences of the taxids
    outputBinding:
      glob: $(inputs.results_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtsv-tools:2.1.0--h54198d6_0
