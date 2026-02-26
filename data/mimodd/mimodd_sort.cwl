cwlVersion: v1.2
class: CommandLineTool
baseCommand: sort
label: mimodd_sort
doc: "Sorts SAM/BAM files by read name.\n\nTool homepage: http://sourceforge.net/projects/mimodd"
inputs:
  - id: input_file
    type: File
    doc: the unsorted input file in SAM/BAM format
    inputBinding:
      position: 1
  - id: by_name
    type:
      - 'null'
      - boolean
    doc: sort by read name
    inputBinding:
      position: 102
      prefix: --by-name
  - id: compression_level
    type:
      - 'null'
      - int
    doc: compression level, from 0 to 9
    inputBinding:
      position: 102
      prefix: -l
  - id: input_format
    type:
      - 'null'
      - string
    doc: the format of the input file
    default: bam
    inputBinding:
      position: 102
      prefix: --iformat
  - id: memory
    type:
      - 'null'
      - string
    doc: maximal amount of memory to be used in GB (overrides config setting)
    inputBinding:
      position: 102
      prefix: --memory
  - id: output_format
    type:
      - 'null'
      - string
    doc: specify whether the output should be in sam or bam format
    default: bam
    inputBinding:
      position: 102
      prefix: --oformat
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads to use (overrides config setting)
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect the output to the specified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimodd:0.1.9--py35_0
