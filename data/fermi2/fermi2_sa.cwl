cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2 sa
label: fermi2_sa
doc: "Builds a suffix array for an FMD-index.\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: in_fmd
    type: File
    doc: Input FMD-index file.
    inputBinding:
      position: 1
  - id: step_shift
    type:
      - 'null'
      - int
    doc: Step shift for the suffix array construction.
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_sa.out
