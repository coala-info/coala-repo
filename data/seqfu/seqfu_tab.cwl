cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabulate
label: seqfu_tab
doc: "Convert FASTQ to TSV and viceversa. Single end is a 4 columns table (name, comment,
  seq, qual), paired end have 4 columns for the R1 and 4 columns for the R2. Paired
  end reads need to be supplied as interleaved.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file (FASTQ or TSV)
    inputBinding:
      position: 1
  - id: comment_sep
    type:
      - 'null'
      - string
    doc: Separator between name and comment
    inputBinding:
      position: 102
      prefix: --comment-sep
  - id: detabulate
    type:
      - 'null'
      - boolean
    doc: Convert TSV to FASTQ (if reading from file is autodetected)
    inputBinding:
      position: 102
      prefix: --detabulate
  - id: field_sep
    type:
      - 'null'
      - string
    doc: Field separator when deinterleaving
    inputBinding:
      position: 102
      prefix: --field-sep
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Input is interleaved (paired-end)
    inputBinding:
      position: 102
      prefix: --interleaved
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_tab.out
