cwlVersion: v1.2
class: CommandLineTool
baseCommand: fassub
label: perl-fast_fassub
doc: "Perform regex substitutions on FASTA/FASTQ identifiers, descriptions, or sequences.\n\
  \ \nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: perl_regex
    type: string
    doc: Perl regular expression to match
    inputBinding:
      position: 201
  - id: substitution
    type: string
    doc: Substitution string
    inputBinding:
      position: 202
  - id: multifasta_file
    type: File
    doc: Input multifasta file(s) (read from standard input)
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile. No comment is saved by default.
    inputBinding:
      position: 104
      prefix: --comment
  - id: description
    type:
      - 'null'
      - boolean
    doc: Substitute on the descriptions. By default substitution occurs on 
      identifiers.
    inputBinding:
      position: 104
      prefix: --description
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Use fastq format as input and output.
    inputBinding:
      position: 104
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. See man page for "fasconvert" for 
      allowed formats.
    inputBinding:
      position: 104
      prefix: --format
  - id: global
    type:
      - 'null'
      - boolean
    doc: Substitute all matches in the data. By default only the first match on 
      each line will be subsituted.
    inputBinding:
      position: 104
      prefix: --global
  - id: insensitive
    type:
      - 'null'
      - boolean
    doc: Substitute case-insensitively.
    inputBinding:
      position: 104
      prefix: --insensitive
  - id: log
    type:
      - 'null'
      - boolean
    doc: Creates, or appends to, a generic FAST logfile in the current working 
      directory.
    inputBinding:
      position: 104
      prefix: --log
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 104
      prefix: --moltype
  - id: sequence
    type:
      - 'null'
      - boolean
    doc: Substitute on the sequences. By default substitution occurs on 
      identifiers.
    inputBinding:
      position: 104
      prefix: --sequence
  - id: logname
    type:
      - 'null'
      - string
    doc: Use [string] as the name of the logfile.
    inputBinding:
      position: 104
      prefix: --logname
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fassub.out
stdin: $(inputs.multifasta_file.path)
