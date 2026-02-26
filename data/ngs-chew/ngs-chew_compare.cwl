cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ngs-chew
  - compare
label: ngs-chew_compare
doc: "Perform fingeprint comparison.\n\nTool homepage: https://github.com/bihealth/ngs-chew"
inputs:
  - id: fingerprints
    type:
      - 'null'
      - type: array
        items: string
    doc: Fingerprints to compare
    inputBinding:
      position: 1
  - id: by_path
    type:
      - 'null'
      - boolean
    doc: Use path as fingerprint name.
    inputBinding:
      position: 102
      prefix: --by-path
  - id: max_mask_ones
    type:
      - 'null'
      - int
    doc: Maximal number of ones in mask.
    inputBinding:
      position: 102
      prefix: --max-mask-ones
  - id: min_mask_ones
    type:
      - 'null'
      - int
    doc: Minimal number of ones in mask.
    inputBinding:
      position: 102
      prefix: --min-mask-ones
  - id: no_by_path
    type:
      - 'null'
      - boolean
    doc: Use path as fingerprint name.
    inputBinding:
      position: 102
      prefix: --no-by-path
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Path to comparison file.
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
