cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngs-chew
  - stats
label: ngs-chew_stats
doc: "Compute statistics from fingerprint .npz files.\n\nTool homepage: https://github.com/bihealth/ngs-chew"
inputs:
  - id: fingerprints
    type:
      - 'null'
      - type: array
        items: File
    doc: Fingerprint .npz files
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
