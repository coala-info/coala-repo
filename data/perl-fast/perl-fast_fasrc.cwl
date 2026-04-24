cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasrc
label: perl-fast_fasrc
doc: "Append -rc to the end of identifiers in FASTA/FASTQ files (unless --nobrand
  is specified).\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 1
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile. No comment is saved by default.
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
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
      The logfile records date/time of execution, full command with options and arguments,
      and an optional comment.
    inputBinding:
      position: 102
      prefix: --log
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
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
  - id: nobrand
    type:
      - 'null'
      - boolean
    doc: This option will not append -rc to the end of the identifiers.
    inputBinding:
      position: 102
      prefix: --nobrand
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fasrc.out
