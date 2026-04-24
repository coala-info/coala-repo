cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_union
label: ccphylo_union
doc: "CCPhylo union finds the union between templates in res files created by e.g.
  KMA.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: create_reference_fasta_file
    type:
      - 'null'
      - boolean
    doc: Create reference fasta file
    inputBinding:
      position: 101
      prefix: --reference_file
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file(s)
    inputBinding:
      position: 101
      prefix: --input
  - id: min_cov
    type:
      - 'null'
      - string
    doc: Minimum coverage
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum overlapping length
    inputBinding:
      position: 101
      prefix: --min_len
  - id: print_ordered_wrt_template_db_filename
    type:
      - 'null'
      - boolean
    doc: Print ordered wrt. template DB filename
    inputBinding:
      position: 101
      prefix: --database
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
