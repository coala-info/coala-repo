cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi2
  - unpack
label: fermi2_unpack
doc: "Unpack an FM-index (RLD file) into reads, one read and its index per line.\n\n\
  Tool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: reads_rld
    type: File
    doc: Input FM-index (RLD file)
    inputBinding:
      position: 1
  - id: read_list_file
    type:
      - 'null'
      - File
    doc: Text file with one read index per line; only these reads are unpacked
    inputBinding:
      position: 2
  - id: read_indices
    type:
      - 'null'
      - string
    doc: Comma-separated read indices (for example 0,5,7); only these reads are
      unpacked. Used when no list file is given.
    inputBinding:
      position: 2
      valueFrom: ':$(self)'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_unpack.out
