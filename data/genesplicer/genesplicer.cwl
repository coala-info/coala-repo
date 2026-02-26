cwlVersion: v1.2
class: CommandLineTool
baseCommand: genesplicer
label: genesplicer
doc: "Predicts splice sites in DNA sequences.\n\nTool homepage: https://github.com/heliocentric/genesplicer"
inputs:
  - id: acceptor_threshold
    type:
      - 'null'
      - string
    doc: Choose t as a threshold for the acceptor sites
    inputBinding:
      position: 101
      prefix: -a
  - id: donor_threshold
    type:
      - 'null'
      - string
    doc: Choose t as a threshold for the donor sites
    inputBinding:
      position: 101
      prefix: -d
  - id: max_acceptor_score_distance
    type:
      - 'null'
      - int
    doc: The maximum acceptor score within n bp is chosen
    inputBinding:
      position: 101
      prefix: -e
  - id: max_donor_score_distance
    type:
      - 'null'
      - int
    doc: The maximum donor score within n bp is chosen
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write the results in file_name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genesplicer:1.0--1
