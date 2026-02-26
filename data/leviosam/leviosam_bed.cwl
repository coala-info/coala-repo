cwlVersion: v1.2
class: CommandLineTool
baseCommand: leviosam_bed
label: leviosam_bed
doc: "Lift over a BED file\n\nTool homepage: https://github.com/alshai/levioSAM"
inputs:
  - id: allowed_gaps
    type:
      - 'null'
      - int
    doc: Number of allowed gaps for an interval.
    default: 500
    inputBinding:
      position: 101
      prefix: --allowed_gaps
  - id: bed_fname
    type: string
    doc: Path to the input BED.
    inputBinding:
      position: 101
      prefix: --bed_fname
  - id: chain_index
    type: string
    doc: Path to the chain index.
    inputBinding:
      position: 101
      prefix: --chain_index
  - id: prefix
    type: string
    doc: Prefix to the output files.
    inputBinding:
      position: 101
      prefix: --prefix
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose level
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose_level
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
stdout: leviosam_bed.out
