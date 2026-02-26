cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac eval
label: deepac_eval
doc: "Evaluate deep-AC models.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: ens_config
    type:
      - 'null'
      - File
    doc: Simple ensemble evaluation.
    inputBinding:
      position: 101
      prefix: --ensemble
  - id: reads_config
    type:
      - 'null'
      - File
    doc: Read-wise evaluation.
    inputBinding:
      position: 101
      prefix: --reads
  - id: species_config
    type:
      - 'null'
      - File
    doc: Species-wise evaluation.
    inputBinding:
      position: 101
      prefix: --species
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_eval.out
