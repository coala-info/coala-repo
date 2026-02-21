cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasuniq
label: perl-fast_fasuniq
doc: "Removes duplicate sequences from FASTA/FASTQ files by matching on descriptions
  or identifiers.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_file
    type:
      - 'null'
      - File
    doc: Input MULTIFASTA file
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
  - id: concat
    type:
      - 'null'
      - string
    doc: Concatenate identifiers of repeated sequences in output. Use delimiter [string]
      to concatenate identifiers. If none given, default is ":"
    default: ':'
    inputBinding:
      position: 102
      prefix: --concat
  - id: count
    type:
      - 'null'
      - boolean
    doc: Annotate the number of redundant records into descriptions.
    inputBinding:
      position: 102
      prefix: --count
  - id: description
    type:
      - 'null'
      - boolean
    doc: Removes duplicate sequences by matching on descriptions.
    inputBinding:
      position: 102
      prefix: --description
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
    doc: Use alternative format for input. See man page for "fasconvert" for allowed
      formats.
    default: fasta
    inputBinding:
      position: 102
      prefix: --format
  - id: identifier
    type:
      - 'null'
      - boolean
    doc: Removes duplicate sequences by matching on identifiers.
    inputBinding:
      position: 102
      prefix: --identifier
  - id: join
    type:
      - 'null'
      - string
    doc: Use <string> to append count data to sequence record descriptions. Use with
      argument "\t" to indicate a tab-character.
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fasuniq.out
