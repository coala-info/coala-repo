cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - scaf
label: fermi_scaf
doc: "Scaffold contigs using FMD-index and remapped MAG files.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: in_fmd
    type: File
    doc: Input FMD-index file
    inputBinding:
      position: 1
  - id: in_remapped_mag
    type: File
    doc: Input remapped MAG file
    inputBinding:
      position: 2
  - id: avg
    type: float
    doc: Average read length
    inputBinding:
      position: 3
  - id: std
    type: float
    doc: Standard deviation of read length
    inputBinding:
      position: 4
  - id: min_supporting_reads
    type:
      - 'null'
      - int
    doc: minimum number of supporting reads
    default: 5
    inputBinding:
      position: 105
      prefix: -m
  - id: print_links
    type:
      - 'null'
      - boolean
    doc: print the links between unitigs
    inputBinding:
      position: 105
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 105
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_scaf.out
