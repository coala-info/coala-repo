cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - finaletoolkit
  - mds
label: finaletoolkit_mds
doc: "Reads k-mer frequencies from a file and calculates a motif diversity score (MDS)
  using normalized Shannon entropy as described by Jiang et al (2020). The score
  is printed to standard output.\n\nTool homepage: https://github.com/epifluidlab/FinaleToolkit"
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
    doc: Number of header rows to ignore. Default is 0
    inputBinding:
      position: 102
      prefix: --header
  - id: sep
    type:
      - 'null'
      - string
    doc: Separator used in tabular file.
    inputBinding:
      position: 102
      prefix: --sep
outputs:
  - id: stdout
    type: stdout
    doc: Motif diversity score printed to standard output
stdout: mds.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
