cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sqt
  - samsetop
label: sqt_samsetop
doc: "Perform set operation on two SAM/BAM files.\n\nTool homepage: https://github.com/marcelm/sqt"
inputs:
  - id: bampath1
    type: File
    doc: First BAM or SAM file
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: 'Operation to perform: union, intersection, setminus, symdiff'
    inputBinding:
      position: 2
  - id: bampath2
    type: File
    doc: Second BAM or SAM file
    inputBinding:
      position: 3
  - id: outputpath
    type:
      - 'null'
      - string
    doc: Output BAM or SAM file. If omitted, only print the number of reads that
      would be written.
    inputBinding:
      position: 4
  - id: exclude_unmapped_a
    type:
      - 'null'
      - boolean
    doc: Exclude unmapped reads from file A
    inputBinding:
      position: 0
      prefix: -U
  - id: exclude_unmapped_b
    type:
      - 'null'
      - boolean
    doc: Exclude unmapped reads from file B
    inputBinding:
      position: 0
      prefix: -V
  - id: output_sam
    type:
      - 'null'
      - boolean
    doc: Output SAM file instead of BAM file
    inputBinding:
      position: 0
      prefix: -s
  - id: remove_trailing_slash_suffix
    type:
      - 'null'
      - boolean
    doc: Remove trailing "/*" from read names. Useful if one mapper appends "/1"
      and another does not.
    inputBinding:
      position: 0
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Number of reads that would be written (when no output file is given)
  - id: output
    type:
      - 'null'
      - File
    doc: Output BAM or SAM file
    outputBinding:
      glob: $(inputs.outputpath)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sqt:v0.8.0-3-deb-py3_cv1
stdout: sqt_samsetop.out
