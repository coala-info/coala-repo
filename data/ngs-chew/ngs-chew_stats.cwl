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
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Path to output file.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
