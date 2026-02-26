cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2_sub
label: fermi2_sub
doc: "Subsample reads from a RLD file.\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: reads_rld
    type: File
    doc: Input reads RLD file.
    inputBinding:
      position: 1
  - id: bits_bin
    type: File
    doc: Input bits file.
    inputBinding:
      position: 2
  - id: cs
    type:
      - 'null'
      - boolean
    doc: Output compressed RLD file.
    inputBinding:
      position: 103
      prefix: -c
  - id: cs
    type:
      - 'null'
      - boolean
    doc: Output compressed RLD file.
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_sub.out
