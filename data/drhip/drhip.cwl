cwlVersion: v1.2
class: CommandLineTool
baseCommand: drhip
label: drhip
doc: "Summarize HyPhy analysis results for many genes into 2-4 CSV files. Always produces
  summary and site files. CFEL and RELAX results, if present, will generate additional
  comparison files.\n\nTool homepage: https://github.com/veg/drhip"
inputs:
  - id: input
    type: Directory
    doc: Path to hyphy results directory (CAPHEINE workflow format)
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to output directory (defaults to current directory)
    inputBinding:
      position: 101
      prefix: --output
  - id: tabular
    type:
      - 'null'
      - boolean
    doc: 'Output tab-delimited files (default: comma-delimited).'
    inputBinding:
      position: 101
      prefix: --tabular
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drhip:0.1.4--pyhdfd78af_0
stdout: drhip.out
