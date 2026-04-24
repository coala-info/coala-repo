cwlVersion: v1.2
class: CommandLineTool
baseCommand: faswc
label: perl-fast_faswc
doc: "Output tallies of sequences and/or characters in FASTA files.\n\nTool homepage:
  http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multi-FASTA files
    inputBinding:
      position: 1
  - id: characters
    type:
      - 'null'
      - boolean
    doc: Output tallies of sequence characters only by file and/or in total.
    inputBinding:
      position: 102
      prefix: --characters
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
    doc: Use fastq format as input and output.
    inputBinding:
      position: 102
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. See man page for "faslen" for allowed formats.
    inputBinding:
      position: 102
      prefix: --format
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
      - File
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
  - id: sequences
    type:
      - 'null'
      - boolean
    doc: Output tallies of sequences only by file and/or in total.
    inputBinding:
      position: 102
      prefix: --sequences
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_faswc.out
