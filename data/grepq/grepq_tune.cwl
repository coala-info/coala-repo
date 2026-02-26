cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - grepq
  - tune
label: grepq_tune
doc: "Tune the regex patterns by analyzing matched substrings\n\nTool homepage: https://github.com/Rbfinch/grepq"
inputs:
  - id: patterns
    type: string
    doc: Regex patterns
    inputBinding:
      position: 1
  - id: file
    type: File
    doc: File to analyze
    inputBinding:
      position: 2
  - id: include_all_variants
    type:
      - 'null'
      - boolean
    doc: Include all variants in the output
    inputBinding:
      position: 103
      prefix: --all
  - id: include_count
    type:
      - 'null'
      - boolean
    doc: Include count of records for matching patterns
    inputBinding:
      position: 103
      prefix: -c
  - id: include_names
    type:
      - 'null'
      - boolean
    doc: Include regexSetName and regexName in the output
    inputBinding:
      position: 103
      prefix: --names
  - id: num_matches
    type: int
    doc: Total number of matches
    inputBinding:
      position: 103
      prefix: -n
  - id: variants
    type:
      - 'null'
      - string
    doc: Number of top most frequent variants to include in the output
    inputBinding:
      position: 103
      prefix: --variants
outputs:
  - id: json_matches
    type:
      - 'null'
      - File
    doc: Write the output to a JSON file called matches.json
    outputBinding:
      glob: $(inputs.json_matches)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grepq:1.5.4--h6ce8773_0
