cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_intersections
label: tasmanian-mismatch_run_intersections
doc: "Find the intersections of SAM alignments (read from standard input) with a BED or bedGraph file. The bedGraph file should contain 3 or more tab-separated columns.\n\nTool homepage: https://github.com/nebiolabs/tasmanian-mismatch"
inputs:
  - id: sam_input
    type: File
    doc: Coordinate-sorted SAM text of the alignments, read from standard input (for example samtools view -h sample.bam)
  - id: bed_file
    type: File
    doc: BED file or bedGraph file (3 or more tab-separated columns)
    inputBinding:
      position: 101
      prefix: -b
  - id: output_prefix
    type: string
    doc: Prefix of the output files
    inputBinding:
      position: 101
      prefix: -o
  - id: debug
    type:
      - 'null'
      - boolean
    doc: create a log file
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: SAM header and alignments passed through
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
stdout: tasmanian-mismatch_run_intersections.out
stdin: $(inputs.sam_input.path)
