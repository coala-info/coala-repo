cwlVersion: v1.2
class: CommandLineTool
baseCommand: catrep
label: consel_catrep
doc: "Join rep files (or rmt files with -m) and select scales; writes <output_base>.rep (or .rmt).\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: input_files
    type: File[]
    doc: "input rep files (rmt files with -m)"
    inputBinding:
      position: 2
  - id: output_base
    type: string
    doc: "base name of the output file, without extension"
    default: "catrep_out"
    inputBinding:
      position: 3
  - id: rmt_mode
    type:
      - 'null'
      - boolean
    doc: "input and output are rmt files (set no_sort too: the default sort of each item's replicates breaks the joint rmt replicates)"
    inputBinding:
      position: 1
      prefix: -m
  - id: pa_file
    type:
      - 'null'
      - File
    doc: "pa file listing the scales to keep"
    inputBinding:
      position: 1
      prefix: -p
  - id: scale_tolerance
    type:
      - 'null'
      - double
    doc: "tolerance for matching scale values (default 0.005)"
    inputBinding:
      position: 1
      prefix: -e
  - id: no_replicates
    type:
      - 'null'
      - boolean
    doc: "do not read the replicates (print the file information only)"
    inputBinding:
      position: 1
      prefix: -n
  - id: ascii_output
    type:
      - 'null'
      - boolean
    doc: "write the output as ascii text"
    inputBinding:
      position: 1
      prefix: -a
  - id: long_matrix
    type:
      - 'null'
      - boolean
    doc: "read the replicates in the long matrix format"
    inputBinding:
      position: 1
      prefix: -L
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: "do not sort the scales"
    inputBinding:
      position: 1
      prefix: --no_sort
  - id: debug_mode
    type:
      - 'null'
      - int
    doc: "debug mode level"
    inputBinding:
      position: 1
      prefix: -d
outputs:
  - id: rep
    type:
      - 'null'
      - File
    doc: "joined rep file"
    outputBinding:
      glob: $(inputs.output_base).rep
  - id: rmt
    type:
      - 'null'
      - File
    doc: "joined rmt file (with -m)"
    outputBinding:
      glob: $(inputs.output_base).rmt
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_catrep.log
