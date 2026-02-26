cwlVersion: v1.2
class: CommandLineTool
baseCommand: stag
label: stag_the
doc: "Supervised Taxonomic Assignment of marker Genes\n\nTool homepage: https://github.com/zellerlab/stag"
inputs:
  - id: command
    type: string
    doc: 'The command to run. Available commands: train, classify, align, create_db,
      check_input, correct_seq, convert_ali, unzip_db, train_genome, classify_genome'
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - type: array
        items: string
    doc: Options for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
stdout: stag_the.out
