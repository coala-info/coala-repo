cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pxblat
  - twobittofa
label: pxblat_twobittofa
doc: "Convert all or part of .2bit file to fasta.\n\nTool homepage: https://pypi.org/project/pxblat/"
inputs:
  - id: input_2bit
    type: File
    doc: The input 2bit file
    inputBinding:
      position: 1
  - id: bed
    type:
      - 'null'
      - File
    doc: Grab sequences specified by input.bed.
    inputBinding:
      position: 102
      prefix: --bed
  - id: bed_pos
    type:
      - 'null'
      - boolean
    doc: With -bed, use chrom:start-end as the fasta ID in output.fa.
    inputBinding:
      position: 102
      prefix: --bedPos
  - id: bpt
    type:
      - 'null'
      - File
    doc: Use bpt index instead of built-in one.
    inputBinding:
      position: 102
      prefix: --bpt
  - id: end
    type:
      - 'null'
      - int
    doc: End at given position in sequence (non-inclusive).
    default: 0
    inputBinding:
      position: 102
      prefix: --end
  - id: no_mask
    type:
      - 'null'
      - boolean
    doc: Convert sequence to all upper case.
    inputBinding:
      position: 102
      prefix: --noMask
  - id: seq
    type:
      - 'null'
      - string
    doc: Restrict this to just one sequence.
    inputBinding:
      position: 102
      prefix: --seq
  - id: seq_list
    type:
      - 'null'
      - File
    doc: File containing list of the desired sequence names
    inputBinding:
      position: 102
      prefix: --seqList
  - id: start
    type:
      - 'null'
      - int
    doc: Start at given position in sequence (zero-based).
    default: 0
    inputBinding:
      position: 102
      prefix: --start
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Place to put cache for remote bigBed/bigWigs.
    inputBinding:
      position: 102
      prefix: --udcDir
outputs:
  - id: output_fa
    type: File
    doc: The output fasta file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
