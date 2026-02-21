cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - artic-tools
  - align_trim
label: artic-tools_align_trim
doc: "Trim alignments from an amplicon scheme\n\nTool homepage: https://github.com/will-rowe/artic-tools"
inputs:
  - id: scheme
    type: File
    doc: The ARTIC primer scheme
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input BAM file (will try STDIN if not provided)
    inputBinding:
      position: 102
      prefix: --inputFile
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: A minimum MAPQ threshold for processing alignments
    default: 15
    inputBinding:
      position: 102
      prefix: --minMAPQ
  - id: no_read_groups
    type:
      - 'null'
      - boolean
    doc: Do not divide reads into groups in SAM output
    inputBinding:
      position: 102
      prefix: --no-read-groups
  - id: normalise
    type:
      - 'null'
      - int
    doc: Subsample to N coverage per strand (deactivate with 0)
    default: 100
    inputBinding:
      position: 102
      prefix: --normalise
  - id: remove_incorrect_pairs
    type:
      - 'null'
      - boolean
    doc: Remove amplicons with incorrect primer pairs
    inputBinding:
      position: 102
      prefix: --remove-incorrect-pairs
  - id: start
    type:
      - 'null'
      - boolean
    doc: Trim to start of primers instead of ends
    inputBinding:
      position: 102
      prefix: --start
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Output debugging information to STDERR
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: report
    type:
      - 'null'
      - File
    doc: Output an align_trim report to file
    outputBinding:
      glob: $(inputs.report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/artic-tools:0.3.1--hf9554c4_7
