cwlVersion: v1.2
class: CommandLineTool
baseCommand: faslen
label: perl-fast_faslen
doc: "Calculate sequence lengths for FASTA/FASTQ files and annotate descriptions or
  output as a table.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multi-fasta file(s)
    inputBinding:
      position: 1
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 102
      prefix: --comment
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: use fastq format as input and output.
    inputBinding:
      position: 102
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. Default is fasta.
    inputBinding:
      position: 102
      prefix: --format
  - id: join
    type:
      - 'null'
      - string
    doc: Use [string] to append length data in descriptions. Use with argument "\t"
      to indicate a tab-character.
    inputBinding:
      position: 102
      prefix: --join
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 102
      prefix: --log
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
    default: FAST.log.txt
    inputBinding:
      position: 102
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 102
      prefix: --moltype
  - id: table
    type:
      - 'null'
      - boolean
    doc: Output data in a table to standard output. By default, length data is annotated
      into descriptions.
    inputBinding:
      position: 102
      prefix: --table
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_faslen.out
