cwlVersion: v1.2
class: CommandLineTool
baseCommand: metavelvet-sl-feature-extraction
label: metavelvet-sl-feature-extraction
doc: 'Feature extraction for MetaVelvet-SL. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metavelvet-sl-feature-extraction:1.0--pl526_3
stdout: metavelvet-sl-feature-extraction.out
