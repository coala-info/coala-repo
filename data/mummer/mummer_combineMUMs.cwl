cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - combineMUMs
label: mummer_combineMUMs
doc: "Combine the MUMs in a gaps file by extending matches off ends and between MUMs.\n\nTool homepage: https://github.com/mummer4/mummer"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: differences_only
    type:
      - 'null'
      - boolean
    doc: "Only output to stdout the difference positions and characters"
    inputBinding:
      position: 1
      prefix: "-D"
  - id: nucleotides_only
    type:
      - 'null'
      - boolean
    doc: "Allow matches only between nucleotides, i.e., ACGTs"
    inputBinding:
      position: 1
      prefix: "-n"
  - id: break_non_acgt
    type:
      - 'null'
      - int
    doc: "Break matches at num or more consecutive non-ACGTs"
    inputBinding:
      position: 1
      prefix: "-N"
  - id: query_tag
    type:
      - 'null'
      - string
    doc: "Used to label query match"
    inputBinding:
      position: 1
      prefix: "-q"
  - id: reference_tag
    type:
      - 'null'
      - string
    doc: "Used to label reference match"
    inputBinding:
      position: 1
      prefix: "-r"
  - id: all_differences
    type:
      - 'null'
      - boolean
    doc: "Output all differences in strings"
    inputBinding:
      position: 1
      prefix: "-S"
  - id: label_header
    type:
      - 'null'
      - boolean
    doc: "Label query matches with query fasta header"
    inputBinding:
      position: 1
      prefix: "-t"
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: "Set verbose level for extra output"
    inputBinding:
      position: 1
      prefix: "-v"
  - id: errors_file_name
    type:
      - 'null'
      - string
    doc: "Reset the default output filename witherrors.gaps"
    inputBinding:
      position: 1
      prefix: "-W"
  - id: no_cover
    type:
      - 'null'
      - boolean
    doc: "Do not output .cover files"
    inputBinding:
      position: 1
      prefix: "-x"
  - id: error_rate
    type:
      - 'null'
      - float
    doc: "Set error-rate cutoff to e (e.g. 0.02 is two percent)"
    inputBinding:
      position: 1
      prefix: "-e"
  - id: ref_sequence
    type: File
    doc: "Fasta file of the reference sequence"
    inputBinding:
      position: 100
  - id: match_sequences
    type: File
    doc: "Multi-fasta file of the sequences matched against the reference"
    inputBinding:
      position: 101
  - id: gaps_file
    type: File
    doc: "Gaps file (MUM clusters from mgaps)"
    inputBinding:
      position: 102
outputs:
  - id: stdout_out
    type: stdout
    doc: "Alignments with MUMs combined by extending matches off ends and between MUMs"
  - id: errors_gaps
    type:
      - 'null'
      - File
    doc: "Gaps file of the clusters that have errors (default witherrors.gaps)"
    outputBinding:
      glob: "$(inputs.errors_file_name ? inputs.errors_file_name : 'witherrors.gaps')"
  - id: cover_files
    type: File[]
    doc: "Cover files (written unless -x is given)"
    outputBinding:
      glob: "*.cover"
  - id: log
    type: stderr
    doc: "Progress and warning messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18
stdout: mummer_combineMUMs.align
stderr: mummer_combineMUMs.log
