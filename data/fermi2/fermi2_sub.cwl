cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi2
  - sub
label: fermi2_sub
doc: "Subset an FM-index (RLD file) to the reads marked in a bit array.\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: reads_rld
    type: File
    doc: Input reads RLD file.
    inputBinding:
      position: 1
  - id: bits_bin
    type: File
    doc: Bit array written by fermi2 diff or fermi2 occflt (one bit per read).
    inputBinding:
      position: 2
  - id: complement
    type:
      - 'null'
      - boolean
    doc: keep the reads that are NOT marked in the bit array (complement of the subset)
    inputBinding:
      position: 103
      prefix: -c
  - id: single_stranded
    type:
      - 'null'
      - boolean
    doc: do not add the reverse-complement partner of each selected read
    inputBinding:
      position: 103
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
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
