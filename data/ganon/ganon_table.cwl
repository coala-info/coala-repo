cwlVersion: v1.2
class: CommandLineTool
baseCommand: ganon_table
label: ganon_table
doc: "Create a table from Ganon report files.\n\nTool homepage: https://github.com/pirovc/ganon"
inputs:
  - id: filtered_label
    type:
      - 'null'
      - string
    doc: Add column with filtered count/percentage with the chosen label. May be
      the same as --unclassified-label (e.g. unassigned)
    inputBinding:
      position: 101
      prefix: --filtered-label
  - id: header
    type:
      - 'null'
      - string
    doc: Header information [name, taxid, lineage]
    inputBinding:
      position: 101
      prefix: --header
  - id: input
    type:
      type: array
      items: File
    doc: Input file(s) and/or folder(s). '.tre' file(s) from ganon report.
    inputBinding:
      position: 101
      prefix: --input
  - id: input_extension
    type: string
    doc: Required if --input contains folder(s). Wildcards/Shell Expansions not 
      supported (e.g. *).
    inputBinding:
      position: 101
      prefix: --input-extension
  - id: max_count
    type:
      - 'null'
      - float
    doc: Maximum number/percentage of counts to keep an taxa [values between 0-1
      for percentage, >1 specific number]
    inputBinding:
      position: 101
      prefix: --max-count
  - id: min_count
    type:
      - 'null'
      - float
    doc: Minimum number/percentage of counts to keep an taxa [values between 0-1
      for percentage, >1 specific number]
    inputBinding:
      position: 101
      prefix: --min-count
  - id: min_frequency
    type:
      - 'null'
      - float
    doc: Minimum number/percentage of files containing an taxa to keep the taxa 
      [values between 0-1 for percentage, >1 specific number]
    inputBinding:
      position: 101
      prefix: --min-frequency
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: Show only entries matching exact names of the provided list
    inputBinding:
      position: 101
      prefix: --names
  - id: names_with
    type:
      - 'null'
      - type: array
        items: string
    doc: Show entries containing full or partial names of the provided list
    inputBinding:
      position: 101
      prefix: --names-with
  - id: no_root
    type:
      - 'null'
      - boolean
    doc: Do not report root node entry and lineage. Direct and shared matches to
      root will be accounted as unclassified
    inputBinding:
      position: 101
      prefix: --no-root
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format [tsv, csv]
    inputBinding:
      position: 101
      prefix: --output-format
  - id: output_value
    type:
      - 'null'
      - string
    doc: Output value on the table [percentage, counts]. percentage values are 
      reported between [0-1]
    inputBinding:
      position: 101
      prefix: --output-value
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output mode
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rank
    type:
      - 'null'
      - string
    doc: Define specific rank to report. Empty will report all ranks.
    inputBinding:
      position: 101
      prefix: --rank
  - id: skip_zeros
    type:
      - 'null'
      - boolean
    doc: Do not print lines with only zero count/percentage
    inputBinding:
      position: 101
      prefix: --skip-zeros
  - id: taxids
    type:
      - 'null'
      - type: array
        items: int
    doc: One or more taxids to report (including children taxa)
    inputBinding:
      position: 101
      prefix: --taxids
  - id: top_all
    type:
      - 'null'
      - int
    doc: Top hits of all samples (ranked by percentage)
    inputBinding:
      position: 101
      prefix: --top-all
  - id: top_sample
    type:
      - 'null'
      - int
    doc: Top hits of each sample individually
    inputBinding:
      position: 101
      prefix: --top-sample
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose output table (taxa as cols and files as rows)
    inputBinding:
      position: 101
      prefix: --transpose
  - id: unclassified_label
    type:
      - 'null'
      - string
    doc: Add column with unclassified count/percentage with the chosen label. 
      May be the same as --filtered-label (e.g. unassigned)
    inputBinding:
      position: 101
      prefix: --unclassified-label
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output mode
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output filename for the table
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.2.0--py312hfc6b275_0
