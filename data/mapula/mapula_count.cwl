cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mapula
  - count
label: mapula_count
doc: "Count mapping stats from a SAM/BAM file\n\nTool homepage: https://github.com/epi2me-labs/mapula"
inputs:
  - id: input_alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: Input alignments in SAM or BAM format. (Default - stdin).
    inputBinding:
      position: 1
  - id: reference_fasta
    type:
      type: array
      items: File
    secondaryFiles:
      - .fai
    doc: Reference .fasta file(s), each with its .fai index.
    inputBinding:
      position: 102
      prefix: -r
  - id: expected_counts_csv
    type:
      - 'null'
      - File
    doc: 'Expected counts CSV. Required columns: reference,expected_count.'
    inputBinding:
      position: 102
      prefix: -c
  - id: relay_stdout
    type:
      - 'null'
      - boolean
    doc: Enable relay of input SAM records to stdout.
    inputBinding:
      position: 102
      prefix: -p
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output results in this format. [Choices: csv, json, all] (Default - csv).'
    inputBinding:
      position: 102
      prefix: -f
  - id: split_aggregation
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Change aggregation behaviour to split by these criteria. [Choices: source
      fasta run_id barcode read_group reference] (Default - all).'
    inputBinding:
      position: 102
      prefix: -s
  - id: output_prefix
    type: string
    default: mapula
    doc: Prefix of the output files, if there are any.
    inputBinding:
      position: 103
      prefix: -n
outputs:
  - id: output_prefix_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output_prefix (.csv and/or .json)
    outputBinding:
      glob: $(inputs.output_prefix).*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
stdout: mapula_count.out
