cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnparser
label: gnparser
doc: "Parses scientific names into their semantic elements.\n\nTool homepage: https://parser.globalnames.org/"
inputs:
  - id: file_or_name
    type: string
    doc: A file containing names (one per line) or a single scientific name.
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: maximum number of names in a batch send for processing.
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: capitalize
    type:
      - 'null'
      - boolean
    doc: capitalize the first letter of input name-strings
    inputBinding:
      position: 102
      prefix: --capitalize
  - id: compact_authors
    type:
      - 'null'
      - boolean
    doc: remove spaces between initials of authors
    inputBinding:
      position: 102
      prefix: --compact-authors
  - id: cultivar
    type:
      - 'null'
      - boolean
    doc: parse according to cultivar code ICNCP (DEPRECATED, use 
      nomenclatural-code instead)
    inputBinding:
      position: 102
      prefix: --cultivar
  - id: details
    type:
      - 'null'
      - boolean
    doc: provides more details
    inputBinding:
      position: 102
      prefix: --details
  - id: diaereses
    type:
      - 'null'
      - boolean
    doc: preserve diaereses in names
    inputBinding:
      position: 102
      prefix: --diaereses
  - id: flatten_output
    type:
      - 'null'
      - boolean
    doc: flattens nested JSON results
    inputBinding:
      position: 102
      prefix: --flatten-output
  - id: format
    type:
      - 'null'
      - string
    doc: "Sets the output format. Accepted values are: - 'csv': Comma-separated values
      - 'tsv': Tab-separated values - 'compact': Compact JSON format - 'pretty': Human-readable
      JSON format. If not set, the output format defaults to 'csv'."
    default: csv
    inputBinding:
      position: 102
      prefix: --format
  - id: ignore_tags
    type:
      - 'null'
      - boolean
    doc: ignore HTML entities and tags when parsing.
    inputBinding:
      position: 102
      prefix: --ignore_tags
  - id: jobs
    type:
      - 'null'
      - int
    doc: number of threads to run. CPU's threads number is the default.
    inputBinding:
      position: 102
      prefix: --jobs
  - id: nomenclatural_code
    type:
      - 'null'
      - string
    doc: "Modifies the parser's behavior in ambiguous cases, sometimes introducing
      additional parsing rules. Accepted values are: - 'bact', 'icnp', 'bacterial'
      for bacterial code - 'bot', 'icn', 'botanical' for botanical code - 'cult',
      'icncp', 'cultivar' for cultivar code - 'vir', 'virus', 'viral', 'ictv', 'icvcn'
      for viral code - 'zoo', 'iczn', 'zoological' for zoological code. If not set,
      the parser will attempt to determine the appropriate code/s."
    inputBinding:
      position: 102
      prefix: --nomenclatural-code
  - id: port
    type:
      - 'null'
      - int
    doc: starts web site and REST server on the port.
    inputBinding:
      position: 102
      prefix: --port
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not show progress
    inputBinding:
      position: 102
      prefix: --quiet
  - id: species_group_cut
    type:
      - 'null'
      - boolean
    doc: cut autonym/species group names to species for stemmed version
    inputBinding:
      position: 102
      prefix: --species-group-cut
  - id: stream
    type:
      - 'null'
      - boolean
    doc: parse one name at a time in a stream instead of a batch parsing
    inputBinding:
      position: 102
      prefix: --stream
  - id: unordered
    type:
      - 'null'
      - boolean
    doc: output and input are in different order
    inputBinding:
      position: 102
      prefix: --unordered
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnparser:1.14.2--he881be0_0
stdout: gnparser.out
