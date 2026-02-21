cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasfilter
label: perl-fast_fasfilter
doc: "Filter sequence records by their descriptions, fields, tags, or regex captures.\n
  \nTool homepage: http://metacpan.org/pod/FAST"
inputs:
  - id: ranges
    type:
      - 'null'
      - string
    doc: Ranges to filter by
    inputBinding:
      position: 1
  - id: multifasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input multifasta files
    inputBinding:
      position: 2
  - id: comment
    type:
      - 'null'
      - string
    doc: Include comment [string] in logfile.
    inputBinding:
      position: 103
      prefix: --comment
  - id: description_filter
    type:
      - 'null'
      - boolean
    doc: Filter sequence records by their descriptions. If used in combination with
      the -x, --regex option, filters records by values of a regex capture applied
      to their descriptions.
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
      prefix: --fastq
  - id: field
    type:
      - 'null'
      - int
    doc: Filter sequence records by a specific field in their descriptions. One-based
      indexing is used.
    inputBinding:
      position: 103
      prefix: --field
  - id: format
    type:
      - 'null'
      - string
    doc: Use alternative format for input.
    default: fasta
    inputBinding:
      position: 103
      prefix: --format
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
      - File
    doc: Use [string] as the name of the logfile.
    default: FAST.log.txt
    inputBinding:
      position: 103
      prefix: --logname
  - id: moltype
    type:
      - 'null'
      - string
    doc: Specify the type of sequence on input (dna|rna|protein).
    inputBinding:
      position: 103
      prefix: --moltype
  - id: negate
    type:
      - 'null'
      - boolean
    doc: Output sequences that do not meet the specified numerical criteria.
    inputBinding:
      position: 103
      prefix: --negate
  - id: regex
    type:
      - 'null'
      - string
    doc: Filter sequence records by values of a regex capture applied to identifiers
      or descriptions.
    inputBinding:
      position: 103
      prefix: --regex
  - id: split_on_regex
    type:
      - 'null'
      - string
    doc: Use regex <regex> to split the description for the -f option instead of the
      perl default.
    inputBinding:
      position: 103
      prefix: --split-on-regex
  - id: tag
    type:
      - 'null'
      - string
    doc: Filter sequence records by values of a named tag in the description (e.g.,
      name:value or name=value).
    inputBinding:
      position: 103
      prefix: --tag
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-fast:1.06--pl5321hdfd78af_2
stdout: perl-fast_fasfilter.out
