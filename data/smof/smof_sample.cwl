cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - sample
label: smof_sample
doc: "Randomly sample entries from a FASTA file.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: number
    type:
      - 'null'
      - int
    doc: "Sample size (default=1)"
    inputBinding:
      position: 100
      prefix: --number
  - id: seed
    type:
      - 'null'
      - string
    doc: "Set random seed (for reproducibility/debugging)"
    inputBinding:
      position: 101
      prefix: --seed
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_sample.out
