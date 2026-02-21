cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - barbell
  - trim
label: barbell_trim
doc: "Trim and sort reads based on filtered annotations\n\nTool homepage: https://github.com/rickbeeloo/barbell"
inputs:
  - id: input
    type: File
    doc: Input filtered annotation file
    inputBinding:
      position: 101
      prefix: --input
  - id: no_flanks
    type:
      - 'null'
      - boolean
    doc: Disable flank in output filenames
    inputBinding:
      position: 101
      prefix: --no-flanks
  - id: no_label
    type:
      - 'null'
      - boolean
    doc: Disable label in output filenames
    inputBinding:
      position: 101
      prefix: --no-label
  - id: no_orientation
    type:
      - 'null'
      - boolean
    doc: Disable orientation in output filenames
    inputBinding:
      position: 101
      prefix: --no-orientation
  - id: only_side
    type:
      - 'null'
      - string
    doc: 'Only keep left or right label in output filenames [possible values: left,
      right]'
    inputBinding:
      position: 101
      prefix: --only-side
  - id: reads
    type: File
    doc: Read FASTQ file
    inputBinding:
      position: 101
      prefix: --reads
  - id: sort_labels
    type:
      - 'null'
      - boolean
    doc: Sort barcode labels in output filenames
    inputBinding:
      position: 101
      prefix: --sort-labels
outputs:
  - id: output
    type: Directory
    doc: Output folder path for trimmed reads
    outputBinding:
      glob: $(inputs.output)
  - id: failed_out
    type:
      - 'null'
      - File
    doc: Write ids of failed trimmed reads to this file
    outputBinding:
      glob: $(inputs.failed_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barbell:0.3.1--hc1c3326_0
