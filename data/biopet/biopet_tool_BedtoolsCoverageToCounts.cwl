cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - BedtoolsCoverageToCounts
label: biopet_tool_BedtoolsCoverageToCounts
doc: "Sum bedtools coverage counts per feature name.\n\nTool homepage: https://github.com/biopet/biopet"
inputs:
  - id: input
    type: File
    doc: Coverage file produced with bedtools
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output file name
    inputBinding:
      position: 101
      prefix: --output
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Level of log information printed. Possible levels: ''debug'', ''info'', ''warn'',
      ''error'''
    inputBinding:
      position: 101
      prefix: --log_level
outputs:
  - id: counts
    type: File
    doc: Counts per feature
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
