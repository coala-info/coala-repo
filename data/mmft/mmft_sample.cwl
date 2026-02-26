cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft_sample
label: mmft_sample
doc: "Randomly sample records from a fasta file.\n\nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input fasta file path(s).
    inputBinding:
      position: 1
  - id: sample_number
    type:
      - 'null'
      - int
    doc: Number of records to sample.
    inputBinding:
      position: 102
      prefix: --sample-number
  - id: sample_size
    type:
      - 'null'
      - string
    doc: Target file size for the sampled sequences (e.g. 10Mb, 3Kb, 5Gb)
    inputBinding:
      position: 102
      prefix: --sample-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft_sample.out
