cwlVersion: v1.2
class: CommandLineTool
baseCommand: genesplicer
label: genesplicer
doc: "Predicts splice sites in DNA sequences.\n\nTool homepage: https://github.com/heliocentric/genesplicer"
inputs:
  - id: fasta_file
    type: File
    doc: Input sequence file in FASTA format.
    inputBinding:
      position: 1
  - id: training_directory
    type: string
    doc: Specific genome training directory (path inside the image, for example
      /usr/local/share/genesplicer-1.0-1/human or .../arabidopsis).
    default: /usr/local/share/genesplicer-1.0-1/human
    inputBinding:
      position: 2
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
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Write the results in file_name (standard output otherwise).
    inputBinding:
      position: 102
      prefix: -f
outputs:
  - id: stdout
    type: stdout
    doc: Predicted splice sites (standard output).
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write the results in file_name
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genesplicer:1.0--1
stdout: genesplicer.out
