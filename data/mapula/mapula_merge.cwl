cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mapula
  - merge
label: mapula_merge
doc: "Combine .json outputs from mapula count\n\nTool homepage: https://github.com/epi2me-labs/mapula"
inputs:
  - id: input_json
    type:
      - 'null'
      - type: array
        items: File
    doc: Input .json files from mapula count. (Default - stdin).
    inputBinding:
      position: 1
  - id: expected_counts_csv
    type:
      - 'null'
      - File
    doc: 'Expected counts CSV. Required columns: reference,expected_count.'
    inputBinding:
      position: 102
      prefix: -c
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Sets the format(s) in which to output results. [Choices: csv, json, all]
      (Default - csv).'
    inputBinding:
      position: 102
      prefix: -f
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
stdout: mapula_merge.out
