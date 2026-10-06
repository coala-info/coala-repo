cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - biopet
  - tool
  - SquishBed
label: biopet_tool_SquishBed
doc: "Remove overlapping parts of BED records so no region is covered twice.\n\nTool homepage:\
  \ https://github.com/biopet/biopet"
inputs:
  - id: input
    type: File
    doc: Input BED file
    inputBinding:
      position: 101
      prefix: --input
  - id: output
    type: string
    doc: Output BED file
    inputBinding:
      position: 101
      prefix: --output
  - id: strand_sensitive
    type:
      - 'null'
      - boolean
    doc: Squish per strand
    inputBinding:
      position: 101
      prefix: --strandSensitive
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
  - id: output_bed
    type: File
    doc: Squished BED file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet:0.9.0--py36r3.3.2_0
