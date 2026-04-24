cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - /usr/local/bin/transit
  - griffin
label: transit_griffin
doc: "Transit1 v3.3.20\n\nTool homepage: http://github.com/mad-lab/transit"
inputs:
  - id: wig_files
    type:
      type: array
      items: File
    doc: comma-separated .wig files
    inputBinding:
      position: 1
  - id: annotation_file
    type: File
    doc: .prot_table annotation file
    inputBinding:
      position: 2
  - id: ignore_c_terminus_fraction
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring at given fraction (as integer) of the C terminus.
    inputBinding:
      position: 103
      prefix: -iC
  - id: ignore_n_terminus_fraction
    type:
      - 'null'
      - float
    doc: Ignore TAs occuring at given fraction (as integer) of the N terminus.
    inputBinding:
      position: 103
      prefix: -iN
  - id: include_stop_codon
    type:
      - 'null'
      - boolean
    doc: Include stop-codon (default is to ignore).
    inputBinding:
      position: 103
      prefix: -sC
  - id: min_read_count
    type:
      - 'null'
      - int
    doc: Smallest read-count to consider.
    inputBinding:
      position: 103
      prefix: -m
  - id: replicates_handling
    type:
      - 'null'
      - string
    doc: How to handle replicates. Sum or Mean.
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transit:3.3.20--pyhdfd78af_0
