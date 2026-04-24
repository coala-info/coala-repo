cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastail
label: perl-fast_fastail
doc: "Print the last sequence records of a multifasta file.\n\nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multifasta file(s)
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Annotate sequence descriptions with file names if and when input is being
      processed from files.
    inputBinding:
      position: 102
      prefix: --annotate
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
    doc: Use fastq format as input and output.
    inputBinding:
      position: 102
      prefix: --fastq
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input. See man page for 'fasconvert' for allowed
      formats.
    inputBinding:
      position: 102
      prefix: --format
  - id: join
    type:
      - 'null'
      - string
    doc: Use [string] to append filenames in descriptions.
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
    inputBinding:
      position: 102
      prefix: --logname
  - id: records
    type:
      - 'null'
      - int
    doc: The number of sequence records to print. Must be a positive integer.
    inputBinding:
      position: 102
      prefix: --records
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fastail.out
