cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapula
label: mapula_count
doc: "Count mapping stats from a SAM/BAM file\n\nTool homepage: https://github.com/epi2me-labs/mapula"
inputs:
  - id: input_sam
    type:
      - 'null'
      - File
    doc: Input alignments in SAM format.
    inputBinding:
      position: 1
  - id: expected_counts_csv
    type:
      - 'null'
      - boolean
    doc: 'Expected counts CSV. Required columns: reference,expected_count.'
    inputBinding:
      position: 102
      prefix: -c
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'If aggregating [-a], output results in this format. [Choices: csv, json,
      all]'
    inputBinding:
      position: 102
      prefix: -f
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of the output files, if there are any.
    inputBinding:
      position: 102
      prefix: -n
  - id: reference_fasta
    type:
      type: array
      items: File
    doc: Reference .fasta file(s).
    inputBinding:
      position: 102
      prefix: -r
  - id: relay_stdout
    type:
      - 'null'
      - boolean
    doc: Enable relay of input SAM records to stdout.
    inputBinding:
      position: 102
      prefix: -p
  - id: split_aggregation
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Change aggregation behaviour to split by these criteria, space separated.
      [Choices: source fasta run_id barcode read_group reference]'
    inputBinding:
      position: 102
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
stdout: mapula_count.out
