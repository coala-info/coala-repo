cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - preseq
  - c_curve
label: preseq_c_curve
doc: "The c_curve command in preseq computes the expected complexity curve (number of distinct reads vs. total number of reads) for a genomic sequencing library.

Tool homepage: https://github.com/smithlabcode/preseq"
inputs:
  - id: input_file
    type: File
    doc: "Input file: BED or MR reads sorted by position, a BAM file (with -B), or a count histogram (-H)"
    inputBinding:
      position: 200
  - id: step_size
    type:
      - 'null'
      - float
    doc: "Step size in extrapolations [1000000]"
    inputBinding:
      position: 102
      prefix: -s
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
    doc: "Complexity curve table (total_reads, distinct_reads)"
    outputBinding:
      glob: "$(inputs.output_file_path ? inputs.output_file_path : 'no_output_file')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
stdout: preseq_c_curve.out
