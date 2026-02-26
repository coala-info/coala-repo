cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - chkbwt
label: fermi_chkbwt
doc: "Check the BWT index file\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: idxbase_bwt
    type: File
    doc: Input BWT index file
    inputBinding:
      position: 1
  - id: check_rank
    type:
      - 'null'
      - boolean
    doc: check rank
    inputBinding:
      position: 102
      prefix: -r
  - id: memory_mapped
    type:
      - 'null'
      - boolean
    doc: load the FM-index as a memory mapped file
    inputBinding:
      position: 102
      prefix: -M
  - id: print_bwt
    type:
      - 'null'
      - boolean
    doc: print the BWT to the stdout
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_chkbwt.out
