cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasconvert
label: perl-fast_fasconvert
doc: "Convert sequences and alignments either to or from fasta format.\n\nTool homepage:
  http://metacpan.org/pod/FAST"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input sequence or alignment files to be converted
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
  - id: files_mode
    type:
      - 'null'
      - boolean
    doc: Convert file in place. File name appended with format
    inputBinding:
      position: 102
      prefix: --files
  - id: input_format
    type:
      - 'null'
      - string
    doc: Convert file from input format to FASTA format
    inputBinding:
      position: 102
      prefix: --input
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
  - id: max_length
    type:
      - 'null'
      - int
    doc: Used when the output format is phylip, this option truncates the identifiers
      to a specified maximum length.
    inputBinding:
      position: 102
      prefix: --maxlength
  - id: output_format
    type:
      - 'null'
      - string
    doc: Convert file from FASTA format to output format
    inputBinding:
      position: 102
      prefix: --output
  - id: sequential
    type:
      - 'null'
      - boolean
    doc: Used when the ouput format is phylip, specifies to not interleave sequences
    inputBinding:
      position: 102
      prefix: --sequential
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fasconvert.out
