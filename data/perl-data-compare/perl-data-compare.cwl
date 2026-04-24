cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-data-compare
label: perl-data-compare
doc: "Compare two data files (e.g. VCF, BED, TSV) and report differences.\n\nTool
  homepage: http://metacpan.org/pod/Data::Compare"
inputs:
  - id: file1
    type: File
    doc: First data file to compare.
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: Second data file to compare.
    inputBinding:
      position: 2
  - id: compare_columns
    type:
      - 'null'
      - string
    doc: Comma-separated list of column indices (1-based) to compare. If not 
      specified, all columns except key columns are compared.
    inputBinding:
      position: 103
      prefix: --compare-columns
  - id: diff_type
    type:
      - 'null'
      - string
    doc: 'Type of differences to report. Options: all, added, removed, modified. Defaults
      to all.'
    inputBinding:
      position: 103
      prefix: --diff-type
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format. Options: tsv, json, html. Defaults to tsv.'
    inputBinding:
      position: 103
      prefix: --format
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Ignore case when comparing strings.
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: ignore_comments
    type:
      - 'null'
      - boolean
    doc: Ignore lines starting with '#'.
    inputBinding:
      position: 103
      prefix: --ignore-comments
  - id: ignore_whitespace
    type:
      - 'null'
      - boolean
    doc: Ignore leading/trailing whitespace and collapse multiple whitespace 
      characters into one.
    inputBinding:
      position: 103
      prefix: --ignore-whitespace
  - id: key_columns
    type:
      - 'null'
      - string
    doc: Comma-separated list of column indices (1-based) to use as keys for 
      comparison. If not specified, all columns are used.
    inputBinding:
      position: 103
      prefix: --key-columns
  - id: only_in_file1
    type:
      - 'null'
      - boolean
    doc: Only report lines that are present in the first file but not in the 
      second.
    inputBinding:
      position: 103
      prefix: --only-in-file1
  - id: only_in_file2
    type:
      - 'null'
      - boolean
    doc: Only report lines that are present in the second file but not in the 
      first.
    inputBinding:
      position: 103
      prefix: --only-in-file2
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file to write differences to. Defaults to stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-data-compare:1.25--pl526_0
