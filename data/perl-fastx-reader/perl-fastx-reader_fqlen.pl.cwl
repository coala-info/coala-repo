cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqlen.pl
label: perl-fastx-reader_fqlen.pl
doc: "A demo implementation to filter fastx files by length. Can process multiple
  files and rename the produced sequences.\n\nTool homepage: https://github.com/telatin/FASTQ-Parser"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA/FASTQ files (uncompressed or GZipped)
    inputBinding:
      position: 1
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length to print a sequence
    inputBinding:
      position: 102
      prefix: --min
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length to print a sequence
    inputBinding:
      position: 102
      prefix: --max
  - id: add_length
    type:
      - 'null'
      - boolean
    doc: Add read length as comment
    inputBinding:
      position: 102
      prefix: --len
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: 'Force FASTA output (default: as input)'
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fasta_width
    type:
      - 'null'
      - int
    doc: 'Paginate FASTA sequences (default: no)'
    inputBinding:
      position: 102
      prefix: --fasta-width
  - id: namescheme
    type:
      - 'null'
      - string
    doc: 'Sequence name scheme: raw (default), num, or file'
    inputBinding:
      position: 102
      prefix: --namescheme
  - id: prefix
    type:
      - 'null'
      - string
    doc: Use as sequence name prefix this string
    inputBinding:
      position: 102
      prefix: --prefix
  - id: separator
    type:
      - 'null'
      - string
    doc: 'Separator between prefix and number (default: .)'
    inputBinding:
      position: 102
      prefix: --separator
  - id: strip_comment
    type:
      - 'null'
      - boolean
    doc: 'Remove sequence comment (default: no)'
    inputBinding:
      position: 102
      prefix: --strip-comment
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Add verbose feedback on % of printed reads
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Selected sequences
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fastx-reader:1.12.0--pl5321hdfd78af_0
stdout: perl-fastx-reader_fqlen.pl.out
