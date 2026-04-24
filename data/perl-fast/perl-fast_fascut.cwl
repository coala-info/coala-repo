cwlVersion: v1.2
class: CommandLineTool
baseCommand: fascut
label: perl-fast_fascut
doc: "Cut identifiers or descriptions of FASTA/FASTQ sequences by character or field.\n
  \nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: index_set
    type:
      - 'null'
      - string
    doc: Index set specifying the ranges or fields to cut
    inputBinding:
      position: 1
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA or FASTQ files
    inputBinding:
      position: 2
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile. No comment is saved by default.
    inputBinding:
      position: 103
      prefix: --comment
  - id: description
    type:
      - 'null'
      - boolean
    doc: Cut descriptions by character. Use the -f option to split descriptions by
      strings of whitespace instead. Use the -S option to split the description with
      an arbitrary regex.
    inputBinding:
      position: 103
      prefix: --description
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: use fastq format as input and output.
    inputBinding:
      position: 103
      prefix: -q
  - id: field
    type:
      - 'null'
      - boolean
    doc: Cut descriptions by field. By default, the description is split on strings
      of white-space.
    inputBinding:
      position: 103
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. See man page for "fasconvert" for allowed
      formats.
    inputBinding:
      position: 103
      prefix: --format
  - id: identifier
    type:
      - 'null'
      - boolean
    doc: Cut identifiers by character. Use the -S option to alter how the identifier
      data is split.
    inputBinding:
      position: 103
      prefix: --identifier
  - id: join
    type:
      - 'null'
      - string
    doc: Paste selected fields together with string string for new description. Use
      "\t" to indicate a tab-character.
    inputBinding:
      position: 103
      prefix: --join
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working directory.
    inputBinding:
      position: 103
      prefix: --log
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
    inputBinding:
      position: 103
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna, rna, or protein).
    inputBinding:
      position: 103
      prefix: --moltype
  - id: split_on_regex
    type:
      - 'null'
      - string
    doc: Use regex to split data. Special characters in the regex option argument
      must be quoted to protect them from the shell.
    inputBinding:
      position: 103
      prefix: --split-on-regex
  - id: strict
    type:
      - 'null'
      - boolean
    doc: This option will implement strict range checking on the coordinates. When
      used this option will skip any sequences for which the coordinates are out of
      range.
    inputBinding:
      position: 103
      prefix: --strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fascut.out
