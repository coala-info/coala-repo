cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy_mclk
label: hyphy_mclk
doc: "RUNNING MOLECULAR CLOCK ANALYSIS\n\nTool homepage: http://hyphy.org/"
inputs:
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'Data type: Nucleotide/Protein or Codon'
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hyphy:2.5.94--h5837470_0
stdout: hyphy_mclk.out
