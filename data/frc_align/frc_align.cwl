cwlVersion: v1.2
class: CommandLineTool
baseCommand: frc_align
label: frc_align
doc: "Feature Response Curve (FRC) tool for assembly evaluation, used to compute and
  visualize assembly quality features from alignment data.\n\nTool homepage: https://github.com/vezzi/FRC_align"
inputs:
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Estimated genome size.
    inputBinding:
      position: 101
      prefix: --genome-size
  - id: long_sam
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM file(s) for long-read libraries.
    inputBinding:
      position: 101
      prefix: --long-sam
  - id: mp_max_insert
    type:
      - 'null'
      - type: array
        items: int
    doc: Maximum insert size for mate-pair libraries.
    inputBinding:
      position: 101
      prefix: --mp-max-insert
  - id: mp_sam
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM file(s) for mate-pair libraries.
    inputBinding:
      position: 101
      prefix: --mp-sam
  - id: pe_max_insert
    type:
      - 'null'
      - type: array
        items: int
    doc: Maximum insert size for paired-end libraries.
    inputBinding:
      position: 101
      prefix: --pe-max-insert
  - id: pe_sam
    type:
      - 'null'
      - type: array
        items: File
    doc: SAM file(s) for paired-end libraries.
    inputBinding:
      position: 101
      prefix: --pe-sam
  - id: output_prefix_path
    type: string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 102
      prefix: --output-prefix
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: Prefix for output files.
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frc:5b3f53e--boost1.64_0
