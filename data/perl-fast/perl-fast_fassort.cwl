cwlVersion: v1.2
class: CommandLineTool
baseCommand: fassort
label: perl-fast_fassort
doc: "Sort sequence records by descriptions, sequences, fields, tags, or regex captures.\n
  \nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: multifasta_file
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multifasta file(s)
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
  - id: description_sort
    type:
      - 'null'
      - boolean
    doc: Sort sequence records by their descriptions. If used in combination with
      the -x, --regex option, sort records by values of a regex capture applied to
      their descriptions.
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
  - id: field
    type:
      - 'null'
      - int
    doc: Sort sequence records by values at a specific field in sequence descriptions.
      One-based indexing or negative indices.
    inputBinding:
      position: 102
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input.
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
  - id: numeric
    type:
      - 'null'
      - boolean
    doc: Compare keys by their string numerical value.
    inputBinding:
      position: 102
      prefix: --numeric
  - id: regex
    type:
      - 'null'
      - string
    doc: Sort sequence records by values of a regex capture applied to identifiers,
      descriptions, or sequences.
    inputBinding:
      position: 102
      prefix: --regex
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Reverse the result of comparisons so that greater keys come first.
    inputBinding:
      position: 102
      prefix: --reverse
  - id: sequence_sort
    type:
      - 'null'
      - boolean
    doc: Sort sequence records by their sequences. If used in combination with the
      -x, --regex option, sort records by values of a regex capture applied to their
      sequences.
    inputBinding:
      position: 102
      prefix: --sequence
  - id: split_on_regex
    type:
      - 'null'
      - string
    doc: Use regex to split descriptions for the -f option instead of the perl default.
    inputBinding:
      position: 102
      prefix: --split-on-regex
  - id: tag
    type:
      - 'null'
      - string
    doc: Sort sequence records by values of a named tag in the description (e.g.,
      name:value or name=value).
    inputBinding:
      position: 102
      prefix: --tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fassort.out
