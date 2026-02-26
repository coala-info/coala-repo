cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamauxmerge
label: biobambam_bamauxmerge
doc: "Merges BAM files.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input BAM files to merge
    inputBinding:
      position: 1
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level for the output BAM file (0-9)
    default: 5
    inputBinding:
      position: 102
      prefix: --compression-level
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite output file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: sort_order
    type:
      - 'null'
      - string
    doc: Sort order of the output BAM file (coordinate, queryname, or unsorted)
    inputBinding:
      position: 102
      prefix: --sort-order
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: 0
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output BAM file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
