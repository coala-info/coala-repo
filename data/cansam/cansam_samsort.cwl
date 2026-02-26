cwlVersion: v1.2
class: CommandLineTool
baseCommand: samsort
label: cansam_samsort
doc: "Sort SAM/BAM/CRAM files\n\nTool homepage: https://github.com/jmarshall/cansam"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to sort
    inputBinding:
      position: 1
  - id: check_sorted
    type:
      - 'null'
      - boolean
    doc: Check whether input is already sorted
    inputBinding:
      position: 102
      prefix: -c
  - id: comparison_function
    type:
      - 'null'
      - string
    doc: Compare records according to comparison function CMP
    default: location
    inputBinding:
      position: 102
      prefix: -f
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compress output at level NUMBER
    default: 'SAM: no compression; BAM: 6'
    inputBinding:
      position: 102
      prefix: -z
  - id: memory_space
    type:
      - 'null'
      - string
    doc: Use SIZE amount of in-memory working space
    inputBinding:
      position: 102
      prefix: -S
  - id: merge_sorted
    type:
      - 'null'
      - boolean
    doc: Merge already-sorted files
    inputBinding:
      position: 102
      prefix: -m
  - id: output_bam
    type:
      - 'null'
      - boolean
    doc: Write output in BAM format
    inputBinding:
      position: 102
      prefix: -b
  - id: temporary_directory
    type:
      - 'null'
      - Directory
    doc: Write temporary files to DIR
    default: $TMPDIR or /tmp
    inputBinding:
      position: 102
      prefix: -T
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to FILE rather than standard output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cansam:21d64bb--h4ef8376_2
