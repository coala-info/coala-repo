cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - bamstats
  - merge
label: biopet-bamstats_merge
doc: "Merge bamstats files into a single file.\n\nTool homepage: https://github.com/biopet/bamstats"
inputs:
  - id: input_file
    type:
      type: array
      items: File
    doc: Files to merge into a single file
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-bamstats:1.0.1--0
