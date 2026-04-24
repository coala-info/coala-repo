cwlVersion: v1.2
class: CommandLineTool
baseCommand: pullseq
label: pullseq
doc: "a bioinformatics tool for manipulating fasta and fastq files\n\nTool homepage:
  https://github.com/bcthomas/pullseq"
inputs:
  - id: chars_per_line
    type:
      - 'null'
      - int
    doc: Sequence characters per line
    inputBinding:
      position: 101
      prefix: --length
  - id: convert
    type:
      - 'null'
      - boolean
    doc: Convert input to fastq/fasta (e.g. if input is fastq, output will be 
      fasta)
    inputBinding:
      position: 101
      prefix: --convert
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: Just count the possible output, but don't write it
    inputBinding:
      position: 101
      prefix: --count
  - id: excluded
    type:
      - 'null'
      - boolean
    doc: Exclude the header id names in the list (-n)
    inputBinding:
      position: 101
      prefix: --excluded
  - id: input_file
    type: File
    doc: Input fasta/fastq file
    inputBinding:
      position: 101
      prefix: --input
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum sequence length
    inputBinding:
      position: 101
      prefix: --max
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum sequence length
    inputBinding:
      position: 101
      prefix: --min
  - id: names_file
    type:
      - 'null'
      - File
    doc: File of header id names to search for
    inputBinding:
      position: 101
      prefix: --names
  - id: names_stdin
    type:
      - 'null'
      - boolean
    doc: Use STDIN for header id names
    inputBinding:
      position: 101
      prefix: --names_stdin
  - id: quality_code
    type:
      - 'null'
      - string
    doc: ASCII code to use for fasta->fastq quality conversions
    inputBinding:
      position: 101
      prefix: --quality
  - id: regex
    type:
      - 'null'
      - string
    doc: Regular expression to match (PERL compatible; always case-insensitive)
    inputBinding:
      position: 101
      prefix: --regex
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print extra details during the run
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pullseq:1.0.2--h1104d80_11
stdout: pullseq.out
