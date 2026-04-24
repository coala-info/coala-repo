cwlVersion: v1.2
class: CommandLineTool
baseCommand: finaletoolkit-interval-mds
label: finaletoolkit_interval-mds
doc: "Reads k-mer frequencies from a file and calculates a motif diversity score (MDS)
  for each interval using normalized Shannon entropy as described by Jiang et al (2020).\n\
  \nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
inputs:
  - id: file_path
    type:
      - 'null'
      - File
    doc: Tab-delimited or similar file containing one column for all k-mers a 
      one column for frequency. Reads from stdin by default.
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - int
    doc: Number of header rows to ignore.
    inputBinding:
      position: 102
      prefix: --header
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator used in tabular file.
    inputBinding:
      position: 102
      prefix: --sep
outputs:
  - id: file_out
    type: File
    doc: Path to the output BED/BEDGraph file containing MDS for each interval.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
