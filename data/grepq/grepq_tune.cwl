cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grepq
label: grepq_tune
doc: "Tune the regex patterns by analyzing matched substrings: report the matched patterns (and counts, names and variants) in the first N matches.\n\nTool homepage: https://github.com/Rbfinch/grepq"
arguments:
  - position: 4
    valueFrom: tune
inputs:
  - id: output_name
    type: string
    default: grepq_tune.txt
    doc: "Name of the file that receives the standard output."
  - id: read_gzip
    type:
      - 'null'
      - boolean
    doc: "Read the FASTQ file in gzip compressed format"
    inputBinding:
      position: 1
      prefix: --read-gzip
  - id: read_zstd
    type:
      - 'null'
      - boolean
    doc: "Read the FASTQ file in zstd compressed format"
    inputBinding:
      position: 1
      prefix: --read-zstd
  - id: patterns
    type: File
    doc: "Patterns file in plain text (one regex per line) or JSON format."
    inputBinding:
      position: 2
  - id: fastq
    type: File
    doc: "FASTQ file in plain text, gzip or zstd compressed format."
    inputBinding:
      position: 3
  - id: num_matches
    type: int
    doc: "Total number of matches"
    inputBinding:
      position: 5
      prefix: -n
  - id: count_patterns
    type:
      - 'null'
      - boolean
    doc: "Include count of records for matching patterns"
    inputBinding:
      position: 5
      prefix: -c
  - id: names
    type:
      - 'null'
      - boolean
    doc: "Include regexSetName and regexName in the output"
    inputBinding:
      position: 5
      prefix: --names
  - id: json_matches
    type:
      - 'null'
      - boolean
    doc: "Write the output to a JSON file called matches.json"
    inputBinding:
      position: 5
      prefix: --json-matches
  - id: variants
    type:
      - 'null'
      - int
    doc: "Number of top most frequent variants to include in the output"
    inputBinding:
      position: 5
      prefix: --variants
  - id: all
    type:
      - 'null'
      - boolean
    doc: "Include all variants in the output"
    inputBinding:
      position: 5
      prefix: --all
outputs:
  - id: output
    type: stdout
    doc: "Matched patterns (and counts, names and variants when requested)."
  - id: matches_json
    type:
      - 'null'
      - File
    doc: "matches.json (with --json-matches)."
    outputBinding:
      glob: matches.json
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grepq:1.5.4--h6ce8773_0
