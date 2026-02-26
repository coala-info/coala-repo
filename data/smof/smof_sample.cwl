cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof sample
label: smof_sample
doc: "Randomly sample entries. `sample` reads the entire file into memory, so should
  not be used for extremely large files.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: input fasta sequence
    default: stdin
    inputBinding:
      position: 1
  - id: number
    type:
      - 'null'
      - int
    doc: sample size
    default: 1
    inputBinding:
      position: 102
      prefix: --number
  - id: seed
    type:
      - 'null'
      - int
    doc: set random seed (for reproducibility/debugging)
    inputBinding:
      position: 102
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_sample.out
