cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_format_id_filter.py
label: gs-tama_tama_format_id_filter.py
doc: "This script makes the Ensembl IDs the primary IDs and allows for filtering\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: bed_file
    type: File
    doc: bed file (required)
    inputBinding:
      position: 101
      prefix: -b
  - id: output_file_name
    type: string
    doc: Output file name (required)
    inputBinding:
      position: 101
      prefix: -o
  - id: filter_level
    type:
      - 'null'
      - string
    doc: "Filter level (default \"none\", use \"only_match\" to only include models with a match)"
    inputBinding:
      position: 101
      prefix: -f
  - id: subfield_method
    type:
      - 'null'
      - string
    doc: "Sub-field management method (default \"ensembl_merge\" for restructuring sub-fields from Ensembl ID, use \"custom\" to define sub-field shuffling)"
    inputBinding:
      position: 101
      prefix: -s
  - id: reshuffle_parameter
    type:
      - 'null'
      - string
    doc: Sub-field reshuffle parameter (default "none")
    inputBinding:
      position: 101
      prefix: -r
  - id: reshuffle_delimiters
    type:
      - 'null'
      - string
    doc: Sub-field reshuffle delimiters (default ";")
    inputBinding:
      position: 101
      prefix: -d
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Bed file with Ensembl IDs as primary IDs
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_format_id_filter.py.out
