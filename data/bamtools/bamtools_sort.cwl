cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - sort
label: bamtools_sort
doc: "sorts a BAM file.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: by_name
    type:
      - 'null'
      - boolean
    doc: sort by alignment name
    inputBinding:
      position: 101
      prefix: -byname
  - id: input_file
    type:
      - 'null'
      - File
    doc: the input BAM file [stdin]
    inputBinding:
      position: 101
      prefix: -in
  - id: max_alignments
    type:
      - 'null'
      - int
    doc: max number of alignments per tempfile
    default: 500000
    inputBinding:
      position: 101
      prefix: -n
  - id: max_memory
    type:
      - 'null'
      - int
    doc: max memory to use (in Mb)
    default: 1024
    inputBinding:
      position: 101
      prefix: -mem
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: the output BAM file [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
