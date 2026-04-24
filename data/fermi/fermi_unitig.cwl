cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - unitig
label: fermi_unitig
doc: "Generate unitigs from an FMD-index.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: reads_fmd
    type: File
    doc: Input FMD-index file
    inputBinding:
      position: 1
  - id: min_match
    type:
      - 'null'
      - int
    doc: min match
    inputBinding:
      position: 102
      prefix: -l
  - id: rank_file
    type:
      - 'null'
      - File
    doc: rank file
    inputBinding:
      position: 102
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_unitig.out
