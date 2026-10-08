cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - finaletoolkit
  - interval-mds
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
  - id: file_out
    type: string
    doc: Path to the output BED/BEDGraph file containing MDS for each interval.
    inputBinding:
      position: 2
  - id: header
    type:
      - 'null'
      - int
    doc: Number of header rows to ignore. Default is 0
    inputBinding:
      position: 0
      prefix: --header
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator used in tabular file.
    inputBinding:
      position: 0
      prefix: --sep
outputs:
  - id: output_file
    type: File
    doc: Path to the output BED/BEDGraph file containing MDS for each interval.
    outputBinding:
      glob: $(inputs.file_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/finaletoolkit:0.11.0--pyhdfd78af_0
