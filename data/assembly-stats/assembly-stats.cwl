cwlVersion: v1.2
class: CommandLineTool
baseCommand: stats
label: assembly-stats
doc: "Reports sequence length statistics from fasta and/or fastq files\n\nTool homepage:
  https://github.com/sanger-pathogens/assembly-stats"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: List of fasta and/or fastq files
    inputBinding:
      position: 1
  - id: grep_friendly
    type:
      - 'null'
      - boolean
    doc: Print 'grep friendly' output
    inputBinding:
      position: 102
      prefix: -s
  - id: min_length_cutoff
    type:
      - 'null'
      - int
    doc: Minimum length cutoff for each sequence. Sequences shorter than the cutoff
      will be ignored
    default: 1
    inputBinding:
      position: 102
      prefix: -l
  - id: tab_delimited
    type:
      - 'null'
      - boolean
    doc: Print tab-delimited output
    inputBinding:
      position: 102
      prefix: -t
  - id: tab_delimited_no_header
    type:
      - 'null'
      - boolean
    doc: Print tab-delimited output with no header line
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assembly-stats:1.0.1--h9948957_10
stdout: assembly-stats.out
