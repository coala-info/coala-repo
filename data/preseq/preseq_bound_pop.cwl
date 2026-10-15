cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - bound_pop
label: preseq_bound_pop
doc: "The bound_pop command in preseq estimates a lower bound on the population size (species richness) of a library.

Tool homepage: https://github.com/smithlabcode/preseq"
inputs:
  - id: input_file
    type: File
    doc: "Input file: BED or MR reads sorted by position, a BAM file (with -B), a count histogram (-H) or duplicate counts only (-V)"
    inputBinding:
      position: 200
  - id: max_num_points
    type:
      - 'null'
      - int
    doc: "Maximum number of points in quadrature estimates [10]"
    inputBinding:
      position: 102
      prefix: -p
  - id: tolerance
    type:
      - 'null'
      - float
    doc: "Numerical tolerance [0.0]"
    inputBinding:
      position: 102
      prefix: -t
  - id: bootstraps
    type:
      - 'null'
      - int
    doc: "Number of bootstraps [500]"
    inputBinding:
      position: 102
      prefix: -n
  - id: clevel
    type:
      - 'null'
      - float
    doc: "Level for confidence intervals [0.95]"
    inputBinding:
      position: 102
      prefix: -c
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print more information"
    inputBinding:
      position: 102
      prefix: -v
  - id: pe_input
    type:
      - 'null'
      - boolean
    doc: "Input is a paired end read file"
    inputBinding:
      position: 102
      prefix: -P
  - id: hist_input
    type:
      - 'null'
      - boolean
    doc: "Input is a text file containing the observed histogram"
    inputBinding:
      position: 102
      prefix: -H
  - id: vals_input
    type:
      - 'null'
      - boolean
    doc: "Input is a text file containing only the observed counts"
    inputBinding:
      position: 102
      prefix: -V
  - id: bam_input
    type:
      - 'null'
      - boolean
    doc: "Input is in BAM format"
    inputBinding:
      position: 102
      prefix: -B
  - id: seg_len
    type:
      - 'null'
      - int
    doc: "Maximum segment length when merging paired end bam reads [5000]"
    inputBinding:
      position: 102
      prefix: -l
  - id: quick
    type:
      - 'null'
      - boolean
    doc: "Quick mode, estimate without bootstrapping"
    inputBinding:
      position: 102
      prefix: -Q
  - id: seed
    type:
      - 'null'
      - int
    doc: "Seed for random number generator [408]"
    inputBinding:
      position: 102
      prefix: -r
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Output file name (default: stdout)"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Species richness lower bound table"
    outputBinding:
      glob: "$(inputs.output_file_path ? inputs.output_file_path : 'no_output_file')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_bound_pop.out
